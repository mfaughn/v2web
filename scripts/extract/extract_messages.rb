require_relative 'extractor_helpers'
require_relative 'extract_acs'
module V2Web
  class DocXtractor    
    def extract_messages(doc)
      # return unless @chapter == '10'
      doc.remove_namespaces!
      @docx = doc
      @hl7 = {}
      find_messages_and_acs_from_docx
      create_special_segment_defitions # create the HL7 wildcard segment....TODO is there a better way?
      @hl7.each { |k, v| create_messages_and_acs(k,v) }
    end
        
    def expand_msg_tbl_title(title)
      code   = title.split('^')[1]
      # puts "Replace #{code}"
      titles = parse_code_set(code).map { |c| title.sub(code, c) }
      # puts title
      # puts titles
      # titles
    end

    def find_messages_and_acs_from_docx
      @docx.at('body').children.each do |node|
        if node.name == 'tbl'
          if node.name == 'tbl'
            if is_msg_table?(node)
              if @msg_table
                expand_msg_tbl_title(@msg_table).each do |mt|
                  code = mt.slice(/.*?(?=:)/).strip # strip will fail if slice returns nil
                  @hl7[code] ||= {}
                  if @hl7[code][:msg]
                    next if code == 'RDY^Znn^RDY_K15' # appears twice in Ch. 5
                    raise "Already have a message table for " + mt
                  end
                  # puts @msg_table
                  @hl7[code][:msg]   = node
                  @hl7[code][:title] = mt
                end
              else
                show_cells(node)
                raise "Uh oh"
              end
            elsif is_ack_table?(node)
              title = ack_table_msg(node)
              codes = expand_msg_tbl_title(title)
              codes.each do |code|
                unless @hl7[code]
                  puts @hl7.keys.sort
                  puts Rainbow(@msg_table)
                  raise "#{code} is not a key in @hl7"
                end
                # puts Rainbow(title).green
                if @hl7[code][:acs]
                  next if code == 'RDY^Znn^RDY_K15' # appears twice in Ch. 5
                  puts @msg_table
                  puts title
                  puts code                  
                  puts ack_table_msg(@hl7[code][:acs])
                  raise "Already have an ack table for " + code
                end
                @hl7[code][:acs] = node
              end
            end
          end
        elsif node.name == 'p'
          if node_style(node) == 'MsgTableCaption'
            @msg_table = extract_text(node)
          end
        end
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
    
    def create_messages_and_acs(key, data)
      # return unless title =~ /C01/
      msg_table  = data[:msg]
      ac_table   = data[:acs]
      title      = data[:title]
      puts Rainbow("  begin ").orange + "Ch. #{@chapter} #{title} "
      event, message, structure = create_event_elements1(title)
      extract_segments_from_table(msg_table, structure) unless structure.segments.any?
      set_msg_structure(message, structure, title)
      create_ac(ac_table, message, title) if ac_table
      # message_def.notes = "{ac_table_title: '#{ac[:name]}'}" # TODO: add this ?
    end
    
    def create_ac(table, msg, title)
      # ac_msg = ack_table_msg(table)
      msg_code = msg.name#.slice(/.*?(?=:)/)&.strip
      msg_code ||= msg.name if @chapter == '10' # Barf....
      if msg_code == title
        extract_ac(table, msg, title)
      else
        puts Rainbow("ac name #{title.inspect} does not match msg code: #{msg_code.inspect} derived from msg.name #{msg.name.inspect}").red
      end
    end
    
    def create_event_elements1(title)
      # puts; puts title
      code, event_code, structure = title.slice(/\w{3}\^\w+\^\w{3}(_\w{3})?/).split('^')
      raise title unless code && event_code && structure
      event_code.strip!
      # puts Rainbow(code).green + ' ' + Rainbow(event_code).yellow + ' ' + Rainbow(structure)
      skip_event = event_code == 'Znn'
      event = HL7::Event.where(:code => event_code).first unless skip_event
      
      message_def = HL7::Message.where(Sequel.ilike(:name, "#{title.slice(/.*?(?=:)/)&.strip}%"), :code => code).first
      puts Rainbow("    #{title} already exists").darkseagreen if message_def
      
      unless message_def
        ChangeTracker.start
        message_def = HL7::Message.create(:name => title, :code => code, :origin => @chapter)
        ChangeTracker.commit
      end
      unless message_def.name == title
        ChangeTracker.start
        message_def.name = title
        message_def.save
        ChangeTracker.commit
      end
      ChangeTracker.start
      unless skip_event
        unless event
          event = HL7::Event.create(:code => event_code.strip, :origin => @chapter)
          # print Rainbow(" #{event.code} ").violet
        end
        unless event.trigger == message_def || event.ack == message_def || event.response == message_def
          # puts "Created Event #{event_code.strip<tt>}"</tt>
          looks_like_ack = title =~ /ACK\^/
          looks_like_response = !looks_like_ack && title =~ /Acknowledg|Response/
          if event.trigger.nil? && !looks_like_ack
            event.trigger = message_def
            if looks_like_response
              # puts Rainbow("Is #{title} really the trigger for #{event.name}").orange
            elsif looks_like_ack 
              puts Rainbow("Is #{title} really the trigger for #{event.code}").red
            end
          else
            if looks_like_ack && !event.ack
              event.ack = message_def
            elsif looks_like_response && !event.response
              event.response = message_def
            elsif !event.response
              event.response = message_def
              # puts Rainbow("Set #{title} as response for #{event.code}").magenta
            else
              puts Rainbow("What to do with #{message_def.id} '#{message_def.name}' #{message_def.code} with respect to  #{event.code}").red
              puts title
              puts "Trigger:  #{event.trigger&.id} '#{event.trigger&.name}' #{event.trigger&.code}"
              puts "Ack:      #{event.ack&.id} '#{event.ack&.name}' #{event.ack&.code}"
              puts "Response: #{event.response&.id} '#{event.response&.name}' #{event.response&.code}"
              raise
            end
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


def sort_msgac_node(node, style = nil)
  if node.name == 'tbl'
    if is_msg_table?(node)
      if @msg_table
        @hl7[@msg_table] ||= {}
        raise "Already have a message table for " + @msg_table if @hl7[@msg_table][:msg]
        @hl7[@msg_table][:msg] = node
      else
        show_cells(node)
        raise "Uh oh"
      end
    elsif is_ack_table?(node)
      title = ack_table_msg(node)
      raise "Already have an ack table for " + title if @hl7[@msg_table][:acs]
      @hl7[@msg_table][:acs] = node
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
    when  'ACK-ChoreographyHeader', 'ACK-ChoreographyBody'
      xtxt = extract_text(node).strip
      unless xtxt.empty?
        puts Rainbow(style).red + " #{extract_text(node)}"
      end
    when 'CommentText', 'EndnoteText'
      xtxt = extract_text(node).strip
      unless xtxt.empty?
        puts Rainbow(style).red + " #{extract_text(node)}"
      end
    when 'NormalIndented', 'Components', 'NormalList', 'Note', 'Example', 'NormalListAlpha', 'NormalListNumbered', 'NormalListBullets', 'ListBullet2', 'ListBullet3', 'Heading4', 'NoteChar', 'OtherTableCaption', 'QryTableCaption', 'AttributeTableCaption'
      # sort_seg_node(node)
    when 'Heading3'
      # Should we include these??
    else
      puts Rainbow(style).yellow + " #{extract_text(node)}"
    end
  end
end
