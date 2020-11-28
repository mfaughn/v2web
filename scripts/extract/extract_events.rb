require_relative 'extractor_helpers'
require_relative 'extract_acs'
module V2Web
  class DocXtractor    
    def extract_events(doc)
      # return unless @chapter == '10'
      doc.remove_namespaces!
      @docx = doc
      @events = {}
      find_events_from_docx
      create_special_segment_defitions # create the HL7 wildcard segment....TODO is there a better way?
      @events.each { |k, v| create_event_and_messages(k,v) }
    end
    
    def clause_regex_by_chapter
      case @chapter.to_s
      when '5'
        /QUERY\/RESPONSE MESSAGE PAIRS/i
      when '8'
        /(MASTER FILES|MESSAGES)$/i
      when '11'
        /PATIENT TREATMENT AUTHORIZATION REQUESTS|Trigger/
      when '12'
        /Message Definitions/
      else
        /Trigger/i
      end
    end
    
    def sort_event_node(node, style = nil)
      @events[@event][:nodes] << node
      if node.name == 'tbl'
        if is_msg_table?(node)
          if @msg_table
            raise "Already have a message table for " + @msg_table if @events[@event][:msgs][@msg_table]
            @events[@event][:msgs][@msg_table] = node
            @msg_table = nil
          else
            show_cells(node)
            raise "Uh oh"
          end
        elsif is_ack_table?(node)
          title = ack_table_msg(node)
          raise "Already have an ack table for " + title if @events[@event][:acs][title]
          @events[@event][:acs][title] = node
        else
          # isn't either one, just part of normative text
        end
        return
      end

      if style.nil? && node.name != 'p'
        puts Rainbow(node.name).red unless node.name == p
      else
        case style
        when nil
          # unstyled p
        when 'MsgTableCaption'
          @msg_table = extract_text(node)
        when 'NormalIndented', 'Components', 'NormalList', 'Note', 'Example', 'NormalListAlpha', 'NormalListNumbered', 'NormalListBullets', 'ListBullet2', 'ListBullet3', 'Heading4', 'NoteChar', 'OtherTableCaption', 'QryTableCaption', 'AttributeTableCaption'
          # sort_seg_node(node)
        when 'Heading3'
          # Should we include these??
        when  'ACK-ChoreographyHeader', 'ACK-ChoreographyBody', 'CommentText', 'EndnoteText'
          xtxt = extract_text(node).strip
          unless xtxt.empty?
            puts Rainbow(style).red + " #{extract_text(node)}"
          end
        else
          puts Rainbow(style).yellow + " #{extract_text(node)}"
        end
      end
    end

    def find_events_from_docx
      return find_events_from_ch10_docx if chapter == '10'
      elements = []
      msgs_section = false
      msg_section  = false
      regex = clause_regex_by_chapter
      @docx.at('body').children.each do |node|
        if node.name == 'p'
          style = node.xpath('.//pPr/pStyle').first&.attribute('val')&.value
          if style =~ /Heading/
            txt = extract_text(node).strip
            if style == 'Heading1'
              # puts Rainbow(txt)
            elsif style == 'Heading2'
              # puts Rainbow(txt).orange
              if txt =~ regex
                msgs_section = true
              else
                msgs_section = false
                @event = nil
              end
            elsif style == 'Heading3'
              if msgs_section
                next if txt =~ /Organization of This Chapter: Trigger Events and Message Definitions/
                if txt =~ /event/i
                  # puts Rainbow(txt) unless txt =~ /[E|e]vents?\s+[A-Z]\d/i || txt =~ /\([A-Z]+\d+.*\)/ || txt =~ /\(events vary\)/

                  @event = txt
                  @events[@event] = { :nodes => [], :msgs => {}, :acs => {} }
                elsif txt =~ /^(Usage Notes for|Activity Diagram|Actors|IV solutions groups|)/i
                  @event = false
                else
                  puts Rainbow(txt).cyan
                  raise
                end
                sort_event_node(node, style) if @event
              else
                next
              end
            else
              sort_event_node(node, style) if @event
            end
          else
            sort_event_node(node, style) if @event
          end
        else
          next if ['bookmarkStart', 'bookmarkEnd'].include?(node.name )
          sort_event_node(node) if @event
        end
      end
    end
           
    def parse_event_title(title)
      case @chapter
      when '3'
        event_codes  = title.slice(/Event [A-Z]\d+/).to_s.sub(/Event\s*/, '')
        event_titles = [title.slice(/.+(?=\(Event)/)].map(&:strip)
        if event_codes.empty?
          event_codes = title.slice(/Events [A-Z]\d+.+/).to_s.sub(/Events\s*/, '').delete('()').split(/\s+and\s+/i).map(&:strip)
          event_titles << event_titles.first
          # puts event_codes.inspect; puts event_titles.inspect
        end
        [event_codes, event_titles]
      else
      end
    end

    def parse_multiple_event_codes(title)
      puts Rainbow("Parsing multiple codes from #{title}").lime
      case @chapter
      when '7'
        range = title.slice(/Events [A-Z]\d+.+/).to_s.sub(/Events\s*/, '').delete('()')
        event_codes = parse_code_set(range)
      else
        raise 'Multiple event title parsing not implemented for Chapter ' + @chapter
      end
    end
    
    def subsitute_event_title(title, code)
      title.sub(/Events [A-Z]\d+(-|,\s*)[A-Z]\d+/, 'Event ' + code)
    end
    
    def subsitute_msg_code(msg_code, code)
      msg_code.sub(/[A-Z]\d+(-|,\s*)[A-Z]\d+/, code)
    end
    
    def alt_create_event_and_messages(title, data)
      nodes       = data[:nodes]
      msg_tables  = data[:msgs]
      ac_tables   = data[:acs]
      event_codes = parse_multiple_event_codes(title)
      case @chapter
      when '7'
        if msg_tables.keys.count == 1
          mkey = msg_tables.keys.first
          event_codes.each do |ec|
            # puts Rainbow(ec.inspect).coral
            title2 = subsitute_event_title(title, ec)
            mkey2  = subsitute_msg_code(mkey, ec)
            ackey2 = mkey2.slice(/.+?(?=:)/).strip
            # puts title2
            # puts mkey2
            ac_tables2 = ac_tables.select { |k,v| k == ackey2 }
            # puts ac_tables2.keys.inspect
            data2 = {:nodes => nodes, :msgs => {mkey2 => msg_tables[mkey]}, :acs => ac_tables2}
            create_event_and_messages(title2, data2)
          end
        else
          raise
        end
      else
        raise
      end
    end
      
    
    def create_event_and_messages(title, data)
      # return unless title =~ /C01/
      nodes       = data[:nodes]
      msg_tables  = data[:msgs]
      ac_tables   = data[:acs]
      if msg_tables.count != ac_tables.count
        puts Rainbow("There are #{msg_tables.count} message tables and #{ac_tables.count} ack choreographies.")
        msg_tables.each do |name, table|
          puts "msg: #{name}"
        end
        ac_tables.each do |name, table|
          puts "ac: #{name}"
        end
        alt_create_event_and_messages(title, data)
        return
      end
      event = nil
      if msg_tables.empty?
        events = create_withdrawn_events(title, nodes)
        events.each { |e| set_event_description(e, nodes)} # Not sure what else to do here....
      else
        print Rainbow("  begin ").orange + "Ch. #{@chapter} #{title} "
        messages   = []
        events     = []
        # acs        = []
        msg_tables.each do |name, table|
          event, message, structure = create_event_elements(name, nodes)
          events << event unless events.find { |e| e.id == event.id }
          messages << message
          # structures << structure
          extract_segments_from_table(table, structure) unless structure.segments.any?
          set_msg_structure(message, structure, name)
          # pp message_def; puts
          # show_cells(msgt)
        end
        ac_tables.each_with_index do |ac_data, i|
          name  = ac_data.first
          table = ac_data.last
          create_ac(messages[i], name, table)
          #   # message_def.notes = "{ac_table_title: '#{ac[:name]}'}" # TODO: add this        
        end
        # events.uniq!
        puts Rainbow("Multiple events from #{title}").red unless events.count == 1
        events.each { |e| set_event_description(e, nodes) }
      end
      puts
    end
    
    def create_withdrawn_events(title, nodes)
      codes = parse_withdrawn_event_title(title).first
      events = []
      codes.each do |event_code|
        event = HL7::Event.where(:code => event_code.strip).first
        unless event
          ChangeTracker.start
          event = HL7::Event.create(:code => event_code.strip, :origin => @chapter)
          print Rainbow(" #{event.code} ").violet
          set_event_description(event, nodes)
          ChangeTracker.commit
        end
        events << event
      end
      events
    end
    
    def parse_withdrawn_event_title(title)
      print Rainbow("Parsing #{title} ").coral
      case @chapter
      when '3'
        event_codes  = [title.slice(/Event [A-Z]\d+/).to_s.sub(/Event\s*/, '')]
        event_titles = [title.slice(/.+(?=\(Event)/)].map(&:strip)
        if event_codes.empty?
          event_codes = title.slice(/Events [A-Z]\d+.+/).to_s.sub(/Events\s*/, '').delete('()').split(/\s+and\s+/i).map(&:strip)
          event_titles << event_titles.first
          # puts event_codes.inspect; puts event_titles.inspect
        end
        [event_codes, event_titles]
      when '4A', '6', '7', '8'
        event_codes  = [title.slice(/Event [A-Z]\d+/).to_s.sub(/Event\s*/, '')]
        event_titles = [title.slice(/.+(?=\(Event)/)].map(&:strip)
        
        event_codes = event_codes.map { |c| parse_code_set(c) }.flatten
        
        [event_codes, event_titles]
      when '10'
        event_codes  = [title.slice(/Event [A-Z]\d+/).to_s.sub(/Event\s*/, '')]
        event_titles = [title.slice(/.+(?=\(Event)/)].map(&:strip)
        raise if event_codes.empty?
        [event_codes, event_titles]
      else
        raise 'Event title parsing not implemented for Chapter ' + @chapter
      end
    end
        
    def set_event_description(event, nodes)
      html = []
      nodes.each do |node|
        if node_style(node) == 'MsgTableCaption'
          @caption = extract_text(node)
          next
        end
        if node.name == 'tbl'
          if is_msg_table?(node)
            raise "No MsgTableCaption for event #{event.code}" unless @caption
            id_txt = @caption.slice(/.+(?=:)/).strip
            raise "No code in caption: #{@caption}" unless id_txt.to_s =~ /^[A-Z]/
            html << "<div class='insert-msg-table' id='#{id_txt}-message-table' style='display: none;'>#{@caption}</div>"
            @caption = nil
          elsif is_ack_table?(node)
            title = ack_table_msg(node)
            html << "<div class='insert-ack-choreography' id='#{title}-ack-choreography' style='display: none;'>#{title}</div>"
          else
            html << Docx2HTML::Processor.new(node, :chapter => @chapter).process
          end
        else
          html << Docx2HTML::Processor.new(node, :chapter => @chapter).process
        end
      end
      event.description = Gui_Builder_Profile::RichText.new(:content => html.join)
    end    
    
    def create_ac(msg, name, table)
      msg_code = msg.name.slice(/.*?(?=:)/)&.strip
      msg_code ||= msg.name if @chapter == '10' # Barf....
      if msg_code == name
        extract_ac(table, msg)
      else
        puts Rainbow("ac name #{name.inspect} does not match msg code: #{msg_code.inspect} derived from msg.name #{msg.name.inspect}").red
      end
    end
    
    def create_event_elements(name, nodes)
      puts; puts name
      code, event_code, structure = name.slice(/\w{3}\^\w+\^\w{3}(_\w{3})?/).split('^')
      raise name unless code && event_code && structure
      event_code.strip!
      # puts Rainbow(code).green + ' ' + Rainbow(event_code).yellow + ' ' + Rainbow(structure)
      skip_event = event_code == 'Znn'
      event = HL7::Event.where(:code => event_code).first unless skip_event
      
      existing_msg = HL7::Message.where(:name => name).first
      puts Rainbow("#{name} already exists").red if existing_msg
      
      ChangeTracker.start
      message_def = HL7::Message.create(:name => name, :code => code, :origin => @chapter)
      unless skip_event
        unless event
          event = HL7::Event.create(:code => event_code.strip, :origin => @chapter)
          print Rainbow(" #{event.code} ").violet
          set_event_description(event, nodes)
        end
        # puts "Created Event #{event_code.strip<tt>}"</tt>
        looks_like_ack = name =~ /ACK\^/
        looks_like_response = !looks_like_ack && name =~ /Acknowledg|Response/
        if event.trigger.nil? && !looks_like_ack
          event.trigger = message_def
          if looks_like_response
            # puts Rainbow("Is #{name} really the trigger for #{event.name}").orange
          elsif looks_like_ack 
            puts Rainbow("Is #{name} really the trigger for #{event.code}").red
          end
        else
          if looks_like_ack && !event.ack
            event.ack = message_def
          elsif looks_like_response && !event.response
            event.response = message_def
          elsif !event.response
            event.response = message_def
            # puts Rainbow("Set #{name} as response for #{event.code}").magenta
          else
            puts Rainbow("What to do with #{name} with respect to  #{event.code}").red
          end
        end
      end
      ChangeTracker.commit
      
      if structure == 'PIN_I01'
        puts Rainbow('Changing PIN_I01 to RQI_I01').green
        structure = 'RQI_I01'
      end
      ChangeTracker.start
      msg_structure = HL7::MessageStructure.create(:code => structure, :origin => @chapter)
      # puts Rainbow("Create MessageStructure #{msg_structure.code}").magenta
      ChangeTracker.commit
  
      [event, message_def, msg_structure]
    end
    
    def set_msg_structure(message_def, structure, name)
      if name =~ /QBP\^Q25\^QBP_Q21/
        puts Rainbow("Handling the QBP^Q25^QBP_Q21 mess.").green
        ChangeTracker.start
        correct_structure = HL7::MessageStructure.where(:code => 'QBP_Q21').first
        raise unless correct_structure
        message_def.structure = correct_structure
        ChangeTracker.commit
        return
      end
      
      identical_structures = get_identical_structures_for(structure)
      if identical_structures.any?
        if identical_structures.count > 1
          raise "Whaaaattttt?"
        else
          existing_structure = identical_structures.first
          if existing_structure.code =~ /_Z/ && structure.code !~ /_Z/
            puts Rainbow("Replacing #{existing_structure.code} with #{structure.code}.  #{structure.code} ==> #{existing_structure.code}").green
            ChangeTracker.start
            existing_structure.messages.each { |msg| msg.structure = structure }
            message_def.structure = structure
            existing_structure.destroy
            ChangeTracker.commit
          else
            unless existing_structure.code == structure.code
              puts Rainbow("#{structure.code} should be replaced by #{existing_structure.code} from Chapter #{existing_structure.origin}.  #{existing_structure.code} ==> #{structure.code}").orange
              # structure.simple_render
              # puts '*'*10
              # existing_structure.simple_render
              # puts '%'*10
            end
            ChangeTracker.start
            structure.destroy
            message_def.structure = existing_structure
            ChangeTracker.commit
          end
        end
      else
        structures_with_same_code = HL7::MessageStructure.where(:code => structure.code).all.reject { |s| s.id == structure.id }
        if structures_with_same_code.any?
          raise if structures_with_same_code.count > 1
          puts Rainbow("Hold up! #{name} does not have the same structure as #{structures_with_same_code.map(&:code).join(' and ')}").red
          diff_structures(structures_with_same_code.first, structure)
          puts '%'*10
          puts "Renaming #{structure.code} as #{rename_code(structure.code)}"
          ChangeTracker.start
          structure.code = rename_code(structure.code)
          structure.save
          ChangeTracker.commit
        end
        ChangeTracker.start
        message_def.structure = structure
        ChangeTracker.commit
      end
    end
    
    def extract_segments_from_table(table, structure)
      segment_parents = [structure]
      rows = table.css('tr')
      rows.each do |row|
        cells = row.css('tc').map { |cell| Nokogiri::HTML(extract_raw_tc(cell)).text }
        entries = []
        cells.each do |cell|
          cell.strip!
          cell = nil if cell.empty?
          entries << cell
        end
        seg, desc, status, ch = entries
        next if seg =~ /Segments?/
        puts Rainbow(entries.inspect).red if seg =~ /[a-z\.]/ && seg != 'Hxx' && seg !~ /\.\.\./
        next if seg == '|'
        add_parent = false
        # puts Rainbow(seg).green
        if seg =~ /\w\w\w/
          segment = create_segment_(seg, desc, status, ch)
        elsif seg =~ /\.\.\./ 
          segment = create_segment_(seg, desc, status, ch)
        elsif seg =~ /</
          segment = create_segment_choice(seg, desc, status, ch)
          add_parent = true
        elsif seg =~ /\[|\{/
          segment = create_segment_seq(seg, desc, status, ch)
          add_parent = true
        elsif seg =~ /\]|\}|>/
          segment_parents.pop
          next
        elsif segment_parents.last.code == "QBP_Q21" && @chapter.to_s == '15'
          next # Silly stuff in 15.3.7
        else
          raise "Unexpected seg value #{seg} in #{segment_parents.first.code} / #{name} / #{@chapter}"
        end      
        ChangeTracker.start
        segment_parents.last.add_segment(segment)
        # if segment_parents.last.is_a?(HL7::SegmentChoice)
        #   puts "Added #{segment.type.code} to SegmentChoice[#{segment_parents.last.id}]"
        # end
        ChangeTracker.commit
        segment_parents << segment if add_parent
      end
    end
    
    def create_special_segment_defitions
      unless HL7::SegmentDefinition.where(:code => 'Hxx').first
        ChangeTracker.start
        hxx = HL7::SegmentDefinition.create(:code => 'Hxx', :name => 'Any HL7 Segment')
        hxx.description = Gui_Builder_Profile::RichText.create(:content => 'A choice of any HL7 segment or segment group is allowed.')
        hxx.save
        ChangeTracker.commit
      end
      unless HL7::SegmentDefinition.where(:code => '...').first
        ChangeTracker.start
        dots = HL7::SegmentDefinition.create(:code => '...', :name => 'Variable Segment')
        dots.description = Gui_Builder_Profile::RichText.create(:content => 'Variable segment.  Instances of usage are defined by the message structures in which this segment occurs.')
        dots.save
        ChangeTracker.commit
      end
    end
    
    def rename_code(code)
      if code =~ /_/
        if code =~ /[a-z]$/
          code.succ
        else
          code + 'a'
        end        
      else
        if code =~ /\d$/
          code.succ
        else
          code + '1'
        end
      end
    end
      
    
    # curly braces indicate repeating section
    # square brackets indicate optional
    # angle brackets and pipes are choice segments

    def obsolete_segs
      ['QRD', 'QRF', 'URD', 'URS']
    end
    
    # We aren't going to worry about chapter (ch) because we already know that the only segment that is duplicated is OBR and we'll deal with that by hand.
    # What does status mean? TODO add to model and capture.
    def create_segment_(seg, desc, status, ch, type = nil)
      code = seg.slice(/[A-Z][A-Z][A-Z0-9]/)
      code = '...' if seg =~ /\.\.\./
      code = 'Hxx' if seg == 'Hxx'
      if obsolete_segs.include?(code)
        s = HL7::ExampleSegment.where(:name => code).first
        return s if s
        ChangeTracker.start
        s = HL7::ExampleSegment.create(:name => code, :description => desc, :status => status)
        ChangeTracker.commit
        return s
      end
      ChangeTracker.start
      s = HL7::Segment.create(:description => desc, :status => status)
      seg = seg.sub('}}', '}]')
      s.repeat = !!(seg =~ /\{.*\}/)
      s.optional = !!(seg =~ /\[.*\]/)
      seg_def = HL7::SegmentDefinition.where(:code => code).first
      puts Rainbow("SegmentDefinition #{code.inspect} #{desc} not found!").red unless seg_def
      unless type == :example
        unless seg_def 
          raise "Could not find SegmentDefinition named #{seg} with code #{code.inspect}."
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
      s.repeat = !!(seg =~ /\{/)
      s.optional = !!(seg =~ /\[/)
      s.name = desc&.slice(/(?<=---).+(?=begin)/)&.strip
      s.save
      ChangeTracker.commit
      # puts Rainbow("Created SegmentChoice[#{s.id}]").cyan
      s
    end
    
    def create_segment_seq(seg, desc, status, ch)
      ChangeTracker.start
      s = HL7::SegmentSequence.create
      s.repeat = !!(seg =~ /\{/)
      s.optional = !!(seg =~ /\[/)
      s.name = desc&.slice(/(?<=---).+(?=begin)/)&.strip
      s.save
      ChangeTracker.commit
      s
    end
        
  end # DocXtractor
end # V2Web
