require_relative 'extractor_helpers'
module V2Web
  class DocXtractor
    def extract_segments_definitions(docx)
      create_segment_list(docx)
      @docx_segs.each { |k, v| create_segment(k,v) }
    end
    
    def create_segment_list(docx)
      docx.remove_namespaces!
      @docx = docx
      @docx_segs = {}
      @current_docx_seg
      find_segments_from_docx
      @docx_segs.delete('OBX - Observation Segment Usage')
      @docx_segs.keys.each { |k| HL7Parse.segment_titles << k }
    end
    
    def find_segments_from_docx
      # Dump everything that comes before segment definitions
      remainder = @docx.at('body').children.drop_while do |node|
        if node.name == 'p'
          style = node.xpath('.//pPr/pStyle').first&.attribute('val')&.value
          if style == 'Heading3'
            txt = extract_text(node)
            txt !~ /^\s*[A-Z][A-Z0-9][A-Z0-9] .*Segment/i
          else
            true
          end
        else
          true
        end
      end
      # elements = elements.each do |node|
      #   if node.name == 'p'
      #     style = node.xpath('.//pPr/pStyle').first&.attribute('val')&.value
      #     if style == 'Heading3'
      #       txt = extract_text(node)
      #       puts Rainbow(txt).orange.blink if txt =~ /OMC/
      #     end
      #   end
      # end
      elements = []
      add_to_elements = false
      leftovers = [] # keep these just in case we need to examine them later
      remainder.each do |node|
        if node.name == 'p'
          style = node.xpath('.//pPr/pStyle').first&.attribute('val')&.value
          if style == 'Heading3'
            txt = extract_text(node)
            add_to_elements = txt.strip =~ /^[A-Z][A-Z][A-Z0-9]\s*[–|-]\s*.+/ && txt =~ /segment/i
            if add_to_elements
              # puts Rainbow("Add '#{txt}'").cyan
            elsif txt =~ /^[A-Z][A-Z][A-Z0-9]\s*[–|-]\s*.+/
              # puts Rainbow("Skip H3 '#{txt}'").red unless txt =~ /\(?event\s+.+\d/i
            else
              # puts Rainbow("Skip H3 '#{txt}'") unless txt =~ /\(?event\s+.+\d/i
            end
          elsif style =~ /Heading[1|2]/
            add_to_elements = false
            # puts Rainbow("#{style.upcase} #{extract_text(node)}").yellow
          end
        end
        if add_to_elements
          elements << node
        else
          leftovers << node
        end
      end

      @field_number = nil
      elements.each do |node|
    
        case node.name
        when 'p'
          # last_node_was_list = false
          # puts Rainbow(node.path).green
          styles = node.xpath('.//pPr/pStyle')&.map { |s| s['val'] }&.uniq
          # styles.each { |s| @styles << s }
          puts Rainbow("Multiple Styles! #{styles}").red if styles.count > 1
          if styles.first
            style = styles.first
            if style =~ /Heading/
              # puts "#{style} = #{extract_text(node)}"
              if style[-1].to_i == 3
                # abbrv, name = split_title(node.text)
                # @current_docx_seg = name.strip
                txt = extract_text(node).strip
                txt = txt.gsub(/withdrawn/i, '').delete('()').strip if txt =~ /withdrawn/i
                @current_docx_seg = txt
                # puts @current_docx_seg
                @docx_segs[@current_docx_seg] = {:table => nil, :fields => {}, :before_table => [], :after_table => [], :withdrawn => txt =~ /withdrawn/i }
                @field_number = 0
              elsif style[-1].to_i == 4 && extract_text(node).strip[0] # there were empty headings, get rid them
                @field_number += 1
                @docx_segs[@current_docx_seg][:fields][@field_number] = [node]
              end
            else
              case style
              when 'AttributeTableCaption'
                @caption_seen = true
              when 'NormalIndented', 'Components', 'NormalList', 'Note', 'Example', 'NormalListAlpha', 'NormalListNumbered', 'NormalListBullets', 'OtherTableCaption', 'ListBullet2', 'ListBullet3'
                sort_seg_node(node)
              else
                puts Rainbow(style).red
                sort_seg_node(node)
              end
            end
          else
            text = extract_text(node).strip
            # puts Rainbow(node.name).orange + ' ' + text unless text.empty?
            sort_seg_node(node)
            # add_text(node)
          end
          # @last_figure = nil
          # @list = nil unless last_node_was_list # assumes that all items in a list occur in successive pelements
        when 'tbl'
          if @caption_seen && @current_docx_seg && !@docx_segs[@current_docx_seg][:table]
            @docx_segs[@current_docx_seg][:table] = node
            @caption_seen = false
            next
          else
            sort_seg_node(node)
          end
        when 'bookmarkStart', 'bookmarkEnd'
          # TODO
        when 'sectPr'
          # TODO not sure what this is for
        else
          unless node.name == 'bookmarkStart' # not worrying about bookmarks in Word document
            puts "Unknown node type: " + Rainbow(node.name).orange
            puts node.to_xml[0..1000]
          end
        end        
      end
    end
    
    def sort_seg_node(node)
      # puts extract_text(node)
      if @field_number > 0
        # puts @field_number.to_s
        @docx_segs[@current_docx_seg][:fields][@field_number] << node
      elsif !@docx_segs[@current_docx_seg][:table]
        # puts 'before'
        @docx_segs[@current_docx_seg][:before_table] << node
      else
        # puts 'after'
        @docx_segs[@current_docx_seg][:after_table] << node
      end
    end

    def create_segment(code_and_name, content)
      # check
      parts = code_and_name.split(/\s+[-|–]\s+/)
      code = parts.shift
      name = parts.join(' - ')
      # return unless code == 'TQ2'
      # puts Rainbow("#{code} - #{name}").magenta
      raise unless code && name
      if ['CM0', 'CM1', 'CM2'].include?(code.to_s) && chapter == 7
        # placeholder in case we want to skip these later.  They are defined in Ch8
      elsif name.to_s =~ /[s|S]egment\s*(\(Proposed Example Only\)|\(Fields That Apply to Most Observations(\/Services)?\))?$/
        # Pass through and create the segment!
      elsif ['OM1', 'OM7'].include?(code)
        # Pass through and create the segment!
      elsif name.to_s =~ /segment usage in vaccine messages/
        puts Rainbow('Not creating profile on RXA - segment usage in vaccine messages').red
        return
        # TODO how deal with what amounts to a profile on a segment definition
        # this appears to be a one-off from Ch.4A
      else
        if code_and_name =~ /\([E|e]vent.+\)/
        elsif code_and_name =~ /[s|S]egment\s*$/
          puts "Skipping #{code_and_name}: #{extract_text(content[:before_table].first)}"
        elsif code_and_name =~ /[s|S]egment/
          puts 'Not creating ' + Rainbow(code_and_name).red
        else
          # puts Rainbow("#{txt}").yellow + '  is not a segment.'
        end
        return
      end
      puts code_and_name if code =~ /RXA/ # why?
      puts Rainbow('# ').orange + 'Starting segment (Ch.' + chapter.to_s + ') ' + Rainbow(code).magenta

      ChangeTracker.start
      segment = HL7::SegmentDefinition.create(:name => name, :code => code)
      # segment.source = make_html_code(html_seg) # FIXME maybe...store XML instead of HTML
      segment.withdrawn = content[:withdrawn]
      segment.origin = chapter
      description = ''
      if !content[:before_table].empty?
        description << Docx2HTML::Processor.new(content[:before_table], :chapter => @chapter).process
      end
      if content[:table]
        description << "<div class='insert-segment-table' id='#{code}-attribute-table' style='display: none;'></div>"
      end
      if !content[:after_table].empty?
        description << Docx2HTML::Processor.new(content[:after_table], :chapter => @chapter).process
      end
      # puts Rainbow(description).cyan
      segment.description = Gui_Builder_Profile::RichText.new(:content => description)
      segment.save
      ChangeTracker.commit
      extract_fields(content, segment)
    end

    def report_def_field_error(rows, defns, segment)
      puts Rainbow("#{segment.name} has #{rows.count} fields and #{defns.count} definitions").red
      puts Rainbow('Fields').red
      rows.each do |row|
        entries = []
        row.children.each do |td|
          next if td.name == 'text'
          entry = td.text.strip
          entry = nil if entry.empty?
          entries << entry
        end
        puts entries.inspect
      end
      puts Rainbow('Definitions').red
      pp defns.map { |sn, d| "#{sn} #{extract_text(d.first)}" }
      puts
      raise
    end
    
    def remove_bad_nodes(node_hash)
      return node_hash unless node_hash.any?
      first_field_header = extract_text(node_hash[1].first)
      if first_field_header =~ /\w{3}\s+.?\s?[F|f]ields? [D|d]efinitions?/
        # puts "Removing bad field definition clause '#{first_field_header}'"
        node_hash.delete(1)
        new_node_hash = {}
        node_hash.values.each_with_index { |v, i| new_node_hash[i+1] = v }
        new_node_hash
      else
        node_hash
      end
    end

    def extract_fields(content, segment)
      table = content[:table]
      unless table
        if segment.code =~/CM[0-2]/
          return
        end
        raise "#{segment.code} has no table" 
      end
      # return unless table
  
      field_nodes = remove_bad_nodes(content[:fields])
      # rows = table.at('tbody').children.reject { |n| n.name == 'text'}
      rows = table.css('tr')[1..-1]
      rows.shift if rows[0].children.reject { |n| n.name == 'text'}.first.text == 'SEQ'
      # defns.shift if defns.count == rows.count + 1 # hope like heck that this deals with the hidden extra '0' section before the definitions....
      unless (rows.count == field_nodes.count) || field_nodes.count == 0 
        report_def_field_error(rows, field_nodes, segment)
      end
      rows.each { |row| extract_field(row, table, field_nodes, segment) }
    end

    def extract_field(row, table, defns, segment)
      cells = row.children.select { |n| n.name == 'tc' }.map { |cell| Nokogiri::HTML(extract_raw_tc(cell)).text }
      seq, len, clen, dt, opt, rp, tbl, item_num, name = cells
      # print Rainbow("seq #{seq} ").green
      check_field_value_formats(len, clen)
      c_length = c_length = clen&.delete('#=')
      example = name.slice(/(?<=\(e\.g\., ).+(?=\))/)
      # HACK unless for 3.4.17.5
      name  = name.strip.gsub(/ \(.*/, '') unless name =~ /\(years\)/
      # HACK for 3.4.16
      if name == "Industry" && seq == '54'
        seq = '5'
      end
  
      name.gsub!(/\s+/, ' ')
      min_length, max_length = len.to_s.split(/\.+/).map(&:strip)
      item_num = item_num.to_i

      data_element = HL7::DataElement.where(:item_number => item_num).first
      if data_element
        check_data_element_is_same(data_element, min_length, max_length, c_length, name)
      else
        data_element = create_data_element_for_field(seq, item_num, min_length, max_length, clen, c_length, name, cells)
      end
      add_datatype_to_data_element(dt, data_element, opt)
      link_value_set_to_data_element(tbl, data_element)
      unless segment.code == 'ROL' # stupid exceptional case...
        add_definition_to_data_element(data_element, seq, name, defns, "#{segment.code}.#{seq || 1}")
      end

      # min_cardinality and max_cardinality and must_support are derived from rp and opt
      field_props = make_field_properties(seq, rp, name)
  
      ChangeTracker.start
      field = HL7::Field.create(field_props)
      set_field_optionality_and_must_support(field,opt,name)
      ChangeTracker.commit
      ChangeTracker.start
      field.data_element = data_element
      segment.add_field(field)
      ChangeTracker.commit
    end
    
    def check_data_element_is_same(data_element, min_length, max_length, c_length, name)
      # because the original source is such a mess, we have to do all this checking....
      if data_element.min_length.to_i != min_length.to_i
        puts Rainbow("min_length mismatch for #{data_element.item_number} -- #{data_element.min_length.inspect} #{min_length.to_i.inspect}").red
        puts "#{data_element.field_info}"
      end
      if data_element.max_length.to_i != max_length.to_i
        puts Rainbow("max_length mismatch for #{data_element.item_number} -- #{data_element.max_length.inspect} #{max_length.to_i.inspect}").red
        puts "#{data_element.field_info}"
      end
      if data_element.c_length != c_length
        puts Rainbow("c_length mismatch for #{data_element.item_number}").red
        puts "#{data_element.field_info}"
      end
      if data_element.name != name
        puts Rainbow("DataElement name mismatch for item number #{data_element.item_number}").red + " this field: #{name} vs. existing: #{data_element.name}"
        puts "#{data_element.field_info}"
      end
    end
    
    def check_field_value_formats(len, clen)
      if len&.[](0) && !(len =~ /^\d+$/ || len =~ /^\d+\.\.\d+$/)
        puts Rainbow("Malformed Length #{len}").magenta
      end
      if clen&.[](0) && ((clen =~ /\d/ && clen !~ /[#=]/) || (clen && clen !~ /\d/))
        puts Rainbow("Malformed C.LEN #{clen.inspect}").magenta
      end
    end
    
    def make_field_properties(seq, rp, name)      
      # min_cardinality and max_cardinality and must_support are derived from rp and opt
      props = {
        :sequence_number => seq,
        :repetition => rp
      }
      
      if rp.nil? || rp.strip.empty? || rp == 'N'
        props[:max_cardinality] = 1
      elsif rp == 'Y' || rp == 'y'
        # props[:max_length] = '*' # unset implies '*'
      elsif rp =~ /Y\/\d+$/
        props[:max_cardinality] = rp.slice(/\d+/).to_i
      elsif rp =~ /\d+/
        props[:max_cardinality] = rp.to_i
      elsif rp =~ /\d+-\d+/
        lo,hi = rp.split('-')
        props[:max_cardinality] = hi.to_i
      elsif rp[0]
        puts Rainbow("RP/# for #{name} was #{rp}").red
      end
      props
    end
    
    def link_value_set_to_data_element(tbl, data_element)
      if tbl && !tbl.strip.empty?
        tid = tbl.to_s.strip.to_i
        vs = HL7::ValueSet.where(:table_id => tid).first
        devs = data_element.table
        if devs && vs && !(devs&.id == vs&.id)
          puts Rainbow("ValueSet mismatch for DataElement #{data_element.item_number}").red
          puts "existing DataElement ValueSet #{devs.table_id}:"
          # puts Rainbow(devs.pretty_inspect).red
          puts "this ValueSet #{vs.table_id}:"
          # puts Rainbow(vs.pretty_inspect).red
          puts "This DataElement also found in: #{data_element.field_info}"
        end
        if devs.nil?
          ChangeTracker.start
          vs ||= HL7::ValueSet.create(:table_id => tid)
          data_element.table = vs
          ChangeTracker.commit
        end
      end
    end
    
    def add_datatype_to_data_element(dt, data_element, opt)
      if dt && !dt.strip.empty?
        dt = 'Varies' if dt == 'varies' # handle source material slop
        data_type_obj = HL7::DataType.where(:code => dt.strip).first
        dedt = data_element.data_type
        if dedt
          if !(dedt == data_type_obj)
            puts Rainbow("DataType mismatch for DataElement#{data_element.item_number}").red
            puts "Existing DataElement's DataType had id #{dedt.id} - #{dedt.code.inspect}"
            puts "This field indicates DataType with id #{data_type_obj&.id} - #{dt.inspect}"
            puts data_element.field_info
          end
        else
          ChangeTracker.start
          data_type_obj ||= HL7::DataType.create(:code => dt.strip)
          data_element.data_type = data_type_obj
          data_element.save
          ChangeTracker.commit
        end
      else
        puts Rainbow("No DataType for #{entries}").yellow.blink unless opt.strip == 'W'
      end
    end

    def add_definition_to_data_element(data_element, seq, name, defns, segment_string)
      defn = defns[seq.to_i]
      if defn
        defn_content = sort_data_element_definition_content(defn)
        # # HACK really this just sweeps inconsistency in the sources under the rug...
        # search_name = name.gsub(/\W+/, '').downcase
        # _, defn = defns.find { |k,_| k.gsub(/\W+/, '').downcase == search_name }
        # unless defn
        #   _, defn = defns.find { |k,_| k.gsub(/\W+/, '').downcase == hack_fix_de_name(search_name) }
        # end
        ChangeTracker.start
        de_def = HL7::DefinitionText.create(:chapter => chapter, :original_container => segment_string)
        # de_def.definition = make_html_text(defn)
        html = Docx2HTML::Processor.new(defn_content, :chapter => @chapter, :remove_headings => true).process
        de_def.definition = Gui_Builder_Profile::RichText.create(:content => html )
        if html =~ /Components: [<|&lt;|&gt;]/
          # Do not remove this check!
          puts Rainbow(html).cyan
          puts defn_content
          raise
        end 
        # puts html
        # puts '*'*22
        clause_title = extract_text(defn_content.first).inspect
        unless name.downcase.gsub(/-|‑/, '') == clause_title.downcase.gsub(/-|‑/, '')
          msg = seq + Rainbow(" DataElement name mismatch for [#{name}] and [#{clause_title}]").yellow
          # puts msg
          HL7Parse.name_mismatchs << "Ch. #{chapter} #{seq} DataElement name mismatch -- Element Name: '#{name}'; DEFINITION TITLE: '#{clause_title}'"
        end

        # puts "DataElement #{data_element.item_number} already has definition!" if data_element.definitions_count > 0
        data_element.add_definition(de_def)
        ChangeTracker.commit
      else
        puts Rainbow("Can't find a definition for #{seq} - #{name.inspect}").red
        pp defns.map { |sn, d| "#{sn} #{extract_text(d.first)}" }
        raise unless ['Marketing Basis'].include?(name)
      end
    end

    def create_data_element_for_field(seq, item_num, min_length, max_length, clen, c_length, name, cells)
      # puts "#{cells.inspect}"
      # puts " --> #{min_length}..#{max_length}"
      data_element_props = {
        :item_number => item_num,
        :min_length  => min_length,
        :max_length  => max_length,
        :c_length    => c_length,
        :name        => name
      }
      ChangeTracker.start
      data_element = HL7::DataElement.create(data_element_props)
      if clen =~ /=/
        data_element.may_truncate = 'false'
      elsif clen =~ /#/
        data_element.may_truncate = 'true'
      else
        data_element.may_truncate = 'not applicable'
      end
      # data_element.source = make_html_code([row])
      ChangeTracker.commit
      # puts "Created DataElement named #{data_element.name}"
      data_element
    end
    
    # unused
    def hack_fix_de_name(name)
      if name =~ /DME/
        if name == "DME Certificate of Medical Necessity Transmission Code".downcase
          return "DME (Durable Medical Equipment) Certificate of Medical Necessity Transmission Code".downcase
        end
        if name =~ / code$/
          return name.gsub(/ code$/, '')
        end
      end
      
      if name
        name
      else
        name
      end
        
    end
    
    def sort_data_element_definition_content(defn)
      defn.select do |node|
        nn = node.name
        unless ['p', 'Hyperlink', 'tbl'].include?(nn)
          puts node
          raise node.name
        end
        puts Rainbow(nn).light_blue if nn == 'Hyperlink'
        style = node.xpath('.//pPr/pStyle').first&.attribute('val')&.value
        if style
          puts style unless ['Components', 'NormalIndented', 'Heading4', 'Example', 'Note', 'NormalListBullets', 'NormalList', 'NormalListAlpha', 'OtherTableCaption', 'OtherTableHeader', 'OtherTableBody', 'NoteChar', 'NoteIndented'].include?(style)
        end
        # puts "Rejecting" if style == 'Components'
        style != 'Components'
      end
        
    end

    def set_field_optionality_and_must_support(field, opt, name)
      field.optionality = opt
      case opt.strip
      when 'R'
        field.must_support = true
        field.min_cardinality = 1
      when 'RE'
        field.must_support = true
        field.min_cardinality = 0
      when 'O'
        field.must_support = false
        field.min_cardinality = 0
      when 'C'
        field.must_support = false
        field.min_cardinality = 0
      when 'C', 'C(a/b)'
        # Never occurs
        raise
      when 'X'
        # Never occurs
        raise
      when 'B'
        field.must_support = false
        field.min_cardinality = 0
      when 'W'
        field.min_cardinality = 0
        field.max_cardinality = 0
        field.must_support = false
      when '-'
        # This is an unofficial value found in the ROL seg def
        # leave must_support as nil for now
      else
        puts Rainbow("OPT for #{name} was #{opt}").red
      end
    end
    

  end # DocXtractor
end # V2Web
