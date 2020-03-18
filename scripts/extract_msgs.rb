require_relative 'extractor_helpers'
module V2Web
  class DocXtractor    
    def extract_messages(doc, html)
      @html = File.open(html) { |f| Nokogiri::XML(f) }
      @html_msgs = {}
      find_messages
      doc.remove_namespaces!
      # TODO - get documentation and everything else....
      @html_msgs.each { |name, tables| create_msg(name, tables) }      
    end
    
    def locate_ac_table(node, msg_name, single_msg_name = nil)
      nxt = node.next
      if nxt.name == 'table'
        cell = nxt.css('thead tr th').first&.text&.strip
        ac_name = nxt.css('tbody tr td').first&.text&.strip
        if cell =~ /^Acknowledge?ment Choreography$/ && (msg_name.split(':').first == ac_name || single_msg_name.to_s.split(':').first == ac_name)
          {:name => ac_name, :table => nxt}
        else
          puts Rainbow("No AckChor table for #{msg_name} -- found #{cell} and #{ac_name}").red
        end
      else
        locate_ac_table(nxt, msg_name)
      end
    end
    
    def find_messages # events are tied in closely here.  we may want to get it all in one go.
      @html.at('body').children.each do |node|
        if node.name == 'text' && node.text == "\n"
          node.remove
        end
      end
      @html.at('body').children.each do |node|
        if node.name == 'p' && node.text =~ /\^/ && node.next&.name == 'table'
          # if node.text =~ /(\w{2,3})\^\w+\^\1/
          msgs = nil
          if node.text =~ /\w{3}\^\w+\^\w{3}(_\w{3})?/
            msg_name = node.text.strip
            msg_table = node.next
            @html_msgs[msg_name] = {:tbl => msg_table}
            ac_table = locate_ac_table(msg_table, msg_name)
            @html_msgs[msg_name][:ac] = ac_table if ac_table
          # this is pretty nasty and not very DRY....
          elsif node.text =~ /\w{3}\^\w.\d-\w.\d\,(\w{3},)+\w{3}\^\w{3}(_\w{3})?/
            # puts Rainbow(node.text).yellow
            msg_parts = node.text.split('^')
            letters = msg_parts[1].split(',').last.slice(/[A-Z]+/)
            nums = msg_parts[1].split(',').collect do |e|
              if e =~ /-/
                inner_nums = e.split('-').collect { |e| e.slice(/\d+/).to_i }
                (inner_nums.first..inner_nums.last).to_a
              else
                e.slice(/\d+/).to_i
              end
            end
            nums.flatten!
            msgs = nums.collect { |n| [msg_parts.first, letters + n.to_s.rjust(3 - letters.size, '0'), msg_parts.last].join('^') }
            # msgs.each { |m| puts Rainbow(m).cyan }
          elsif node.text =~ /\w{3}\^\w.\d-\w.\d\^\w{3}(_\w{3})?/
            # puts Rainbow(node.text).yellow
            msg_parts = node.text.split('^')
            nums = msg_parts[1].split('-').collect { |e| e.slice(/\d+/).to_i }
            letters = msg_parts[1].split('-').first.slice(/[A-Z]+/)
            msgs = (nums.first..nums.last).collect { |n| [msg_parts.first, letters + n.to_s.rjust(3 - letters.size, "0"), msg_parts.last].join('^') }
            # msgs.each { |m| puts Rainbow(m).cyan }
          elsif node.text =~ /\w{3}\^\w{3}-\w{3}\^\w{3}(_\w{3})?/
            # puts Rainbow(node.text).yellow
            msg_parts = node.text.split('^')
            last_letters = msg_parts[1].split('-').collect { |e| e[-1] }
            first_letters = msg_parts[1].split('-').first[0..1]
            msgs = (last_letters.first..last_letters.last).collect { |l| [msg_parts.first, first_letters + l, msg_parts.last].join('^') }
            # msgs.each { |m| puts Rainbow(m).cyan }
          elsif node.text =~ /\w{3}\^(\w{3},)+\w{3}\^\w{3}(_\w{3})?/
            # puts Rainbow(node.text).yellow
            msg_parts = node.text.split('^')
            msgs = msg_parts[1].split(',').collect { |e| [msg_parts.first, e, msg_parts.last].join('^') }
            # msgs.each { |m| puts Rainbow(m).cyan }
          else
            puts 'Skipping ' + Rainbow(node.text).yellow + ' because it does not look like a message definition'
          end
          if msgs
            msg_name = node.text.strip
            msg_table = node.next
            data = {:tbl => msg_table}
            # puts msg_name.inspect
            first_single_msg_name = msg_name.sub(/.*(?=:)/, msgs.first)
            ac_table = locate_ac_table(msg_table, msg_name, first_single_msg_name)
            data[:ac] = ac_table if ac_table
            msgs.each do |msg|
              msg_name = node.text.strip
              single_msg_name = msg_name.sub(/.*(?=:)/, msg)
              # puts "  #{single_msg_name}"
              @html_msgs[single_msg_name] = data
            end
          end
        end
      end
    end
    
    # TODO -- Get all of the documentation for MsgDefs.  This is simply creating the objects with no documentation.

    def create_msg(name, tables)
      puts Rainbow("  # Create Message #{name}").orange
      tbl = tables[:tbl]
      ac  = tables[:ac]
      existing_msg = HL7::MessageDefinition.where(:name => name).first
      puts Rainbow("#{name} already exists").red if existing_msg
      ChangeTracker.start
      message_def = HL7::MessageDefinition.create(:name => name, :origin => @chapter.to_s)
      src = tbl.to_xml
      if ac
        src << ac[:table].to_xml
        message_def.notes = "ac_table_title: '#{ac[:name]}'}"
      end
      # message_def.source = make_html_code(src) # not including source here because we are getting it from HTML instead of OOXML.
      ####### doing this for now...
      html = Gui_Builder_Profile::Code.create(:content => src )
      html.language = 'HTML'
      html.save
      message_def.source = html
      #######
      message_def.origin = chapter
      message_def.save
      @segment_parents = [message_def]
      ChangeTracker.commit
      extract_segments(tbl)
    end
    
    # curly braces indicate repeating section
    # square brackets indicate optional
    # angle brackets and pipes are choice segments
    def extract_segments(table)
      rows = table.at('tbody').children.reject { |n| n.name == 'text'}[1..-1]
      rows.each do |row|
        entries = []
        row.children.each do |td|
          next if td.name == 'text'
          entry = td.text.strip
          entry = nil if entry.empty?
          entries << entry
        end
        seg, desc, status, ch = entries
        next if seg == '|'
        if seg =~ /\w\w\w/
          segment = create_segment(seg, desc, status, ch)
        elsif seg =~ /\.\.\./ # it is an example...
          segment = create_segment(seg, desc, status, ch, :example)
        elsif seg =~ /</
          segment = create_segment_choice(seg, desc, status, ch)
          @segment_parents << segment
        elsif seg =~ /\[|\{/
          segment = create_segment_seq(seg, desc, status, ch)
          @segment_parents << segment
        elsif seg =~ /\]|\}|>/
          @segment_parents.pop
          next
        elsif @segment_parents.last.name =~ /QBP\^Q25\^QBP_Q21/
          next # Silly stuff in 15.3.7
        else
          raise "Unexpected seg value #{seg} in #{@segment_parents.first.name}"
        end      
        ChangeTracker.start
        @segment_parents.last.add_segment(segment)
        ChangeTracker.commit
      end
    end
    
    def obsolete_segs
      ['QRD', 'QRF', 'URD', 'URS', 'Hxx']
    end
    
    # We aren't going to worry about chapter (ch) because we already know that the only segment that is duplicated is OBR and we'll deal with that by hand.
    # What does status mean? TODO add to model and capture.
    def create_segment(seg, desc, status, ch, type = nil)
      abbreviation = seg.slice(/[A-Z][A-Z][A-Z0-9]/)
      abbreviation = 'Hxx' if seg == 'Hxx'
      if obsolete_segs.include?(abbreviation)
        s = HL7::ExampleSegment.where(:name => abbreviation).first
        return s if s
        ChangeTracker.start
        s = HL7::ExampleSegment.create(:name => abbreviation, :description => desc, :status => status)
        ChangeTracker.commit
        return s
      end
      ChangeTracker.start
      s = HL7::Segment.create(:description => desc, :status => status)
      s.repeat = !!(seg =~ /\{.*\}/)
      s.optional = !!(seg =~ /\[.*\]/)
      seg_def = HL7::SegmentDefinition.where(:abbreviation => abbreviation).first
      unless type == :example
        unless seg_def 
          raise "Could not find SegmentDefinition named #{seg} with abbreviation #{abbreviation.inspect}."
        end
        s.type = seg_def
      end
      s.save
      ChangeTracker.commit
      s
    end
    
    def create_segment_choice(seg, desc, status, ch)
      ChangeTracker.start
      s = HL7::SegmentChoice.create
      s.repeat = !!(seg =~ /\{.*\}/)
      s.optional = !!(seg =~ /\[.*\]/)
      s.save
      ChangeTracker.commit
      s
    end
    
    def create_segment_seq(seg, desc, status, ch)
      ChangeTracker.start
      s = HL7::SegmentSequence.create
      s.repeat = !!(seg =~ /\{.*\}/)
      s.optional = !!(seg =~ /\[.*\]/)
      s.name = desc&.slice(/(?<=---).+(?=begin)/)&.strip
      s.save
      ChangeTracker.commit
      s
    end
        
  end # DocXtractor
end # V2Web
