module V2Web
  class DocXtractor   
    def find_events_from_ch10_docx
      @general_nodes = nil
      elements = []
      msgs_section = false
      regex = clause_regex_by_chapter
      @docx.at('body').children.each do |node|
        if node.name == 'p'
          style = node.xpath('.//pPr/pStyle').first&.attribute('val')&.value
          if style =~ /Heading/
            txt = extract_text(node).strip
            if style == 'Heading1'
              # puts Rainbow(txt)
            elsif style == 'Heading2'
              distribute_nodes_ch10 if @general_nodes
              if txt =~ regex
                puts Rainbow(txt).orange
                msgs_section = true
                @general_nodes = []
                # @msgs = {}
                # @acs = {}
              else
                msgs_section = false
                @event = nil
                @general_nodes = nil
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
                sort_event_node_ch10(node, style) if msgs_section
              else
                next
              end
            else
              sort_event_node_ch10(node, style) if msgs_section
            end
          else
            sort_event_node_ch10(node, style) if msgs_section
          end
        else
          next if ['bookmarkStart', 'bookmarkEnd'].include?(node.name )
          sort_event_node_ch10(node) if msgs_section
        end
      end
    end
    
    def sort_event_node_ch10(node, style = nil)
      if @event
        sort_event_node(node, style)
      else
        if node.name == 'tbl'
          if is_msg_table?(node)
            if @msg_table
              puts "Message ID: " + Rainbow(@msg_table).lime
              ranged_id = @msg_table.slice(/.*(?=:)/)
              code = ranged_id.split('^')[1]
              msg_ids = parse_code_set(code).map { |c| ranged_id.sub(code, c) }
              msg_ids.each do |msg_id|
                @events[msg_id] ||= { :nodes => [], :msgs => {}, :acs => {} }
                @events[msg_id][:msgs][msg_id] = node
              end
              # @msgs[@msg_table] = node
              # @msg_table = nil
            else
              show_cells(node)
              raise "Uh oh"
            end
          elsif is_ack_table?(node)
            ranged_id = ack_table_msg(node)
            puts "AC: " + Rainbow(ranged_id).lime
            code = ranged_id.split('^')[1]
            msg_ids = parse_code_set(code).map { |c| ranged_id.sub(code, c) }
            msg_ids.each do |msg_id|
              @events[msg_id][:acs][msg_id] = node
            end
            # @acs[msg_id] = node
          else
            @general_nodes << node
          end
          return
        end
        @general_nodes << node
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
    end
    
    def distribute_nodes_ch10
      id_keys = @events.select { |k,_| k =~ /\^/ }
      # puts id_keys.keys
      @events.each do |k, data|
        next if id_keys.include?(k)
        event_key = k.slice(/(?<=\(Event ).*/).delete('()').strip
        matching_entries = @events.select { |k,_| k =~ /\^#{event_key}\^/ }
        matching_entries.values.each do |other_data|
          data[:msgs].merge!(other_data[:msgs])
          data[:acs].merge!(other_data[:acs])
        end
        data[:nodes] = data[:nodes] + @general_nodes
      end
      id_keys.each_key { |k| @events.delete(k) }
      # puts @events.keys;puts '*'*33
      @general_nodes = nil
      @event = nil
    end
  end
end
