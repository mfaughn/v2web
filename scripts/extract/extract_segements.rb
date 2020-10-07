require_relative 'extractor_helpers'
module V2Web
  class DocXtractor
    def extract_segements(doc, html)
      @html = File.open(html) { |f| Nokogiri::XML(f) }
      @html_segs = {}
      @current_html_seg = nil      
      find_segments
      doc.remove_namespaces!
      @segments = {}
      @segment  = nil
      @data_element  = nil
      @node_names = []
      @node_types = []
      doc.children.each { |c| _extract_segements(c) }
    end
    
    def find_segments
      @html.at('body').children.each do |node|
        if node.name == 'h3'
          abbrv, name = split_title(node.text)
          if name =~ /[s|S]egment/
            # puts Rainbow("Found segment: #{node.text}").green
          else
            # puts Rainbow("Skipping h3: #{node.text}").yellow
            next
          end
          @current_html_seg = name.strip
          @html_segs[@current_html_seg] = []
        end
        next unless @current_html_seg
        @html_segs[@current_html_seg] << node unless node.name == 'text'
      end
      # @html_segs.keys.sort.each {|k| p k}
    end
    
    def _extract_segements(node)
      @node_types << node.name # just for debugging I think
      case node.name
      when 'body'
        node.children.each { |c| _extract_segements(c) }
      when 'document'
        node.children.each { |c| _extract_segements(c) }
      when 'tbl'
        # let's try not doing anything and see if that works...
        # puts node
      when 'bookmarkStart', 'bookmarkEnd'
        # TODO
      when 'sectPr'
        # TODO not sure what this is for
      when 'p'
        last_node_was_list = false
        # puts Rainbow(node.path).green
        styles = get_styles(node)
        puts Rainbow("Multiple Styles for this #{node.name} -- #{styles}.").red if styles.count > 1
        style = styles.first
        # styles.each { |s| @styles << s }
        if style
          if style =~ /Heading|berschrift/
            if style[-1].to_i == 3
              create_segment(node)
            elsif style[-1].to_i == 4 && extract_text(node).strip[0] # there were empty headings, get rid of them
              # add_to_data_element(node)
            end
          else
            case style
            when 'Components'       
            when 'TOC1', 'TOC2', 'TOC3', 'TOC4', 'TOC5', 'TableofFigures', 'Verzeichnis1', 'Verzeichnis2', 'Verzeichnis3', 'Verzeichnis4', 'Verzeichnis5'
            when 'ANSIdesignation'
            when 'MsgTableCaption'
            when 'ACK-ChoreographyBody'
            when 'ACK-ChoreographyHeader'
            when 'QryTableCaption'
            when 'Endnotentext', 'EndnoteText' # Ch5, empty paragraph with this  
              t = extract_text(node)
              if t && !t.empty?
                puts Rainbow("#{style}: #{t}").red
              end
            when 'Kommentartext', 'CommentText'
              t = extract_text(node)
              if t && !t.empty?
                puts Rainbow("#{style}: #{t}").red
              end
            when 'List'
              # this appears to be a list item
              # puts Rainbow("#{style}: #{extract_text(node)}").yellow;puts

            # Make these DRY
            when 'NormalListNumbered'
            when 'NormalList' 
            when 'NormalListAlpha' 
              # add_datatype_or_component_content(node, :list)
              
              # puts Rainbow("#{style}: #{extract_text(node)}").yellow;puts
            #   start_list('letters') unless @list
            #   last_node_was_list = true
            #   add_list_item(node)
            when 'Bullet', 'NormalListBullets'
              # add_datatype_or_component_content(node, :bullet)
              # puts Rainbow("#{style}: #{extract_text(node)}").yellow
            #   start_list('bullets') unless @list
            #   last_node_was_list = true
            #   add_list_item(node)
            when 'ListBullet2', 'Aufzhlungszeichen2' # FIXME ALL LISTS!!!!!
            when 'ListBullet3', 'Aufzhlungszeichen3' # FIXME ALL LISTS!!!!!
            
            when 'OtherTableCaption'
              # add_datatype_or_component_content(node, :table_caption)
              # FIXME this table content in a component definition
              # puts Rainbow("#{style}: #{extract_text(node)}").yellow;puts
            when 'NormalIndented'
              # add_datatype_or_component_content(node)
              # this is just content found for definitions and examples and stuff, treat as normal
              # puts Rainbow('NormalIndented: ' + extract_text(node)).yellow
            when 'AttributeTableCaption'
              # These can be skipped
            when 'HL7TableCaption'
              # add_datatype_or_component_content(node, :table_caption)
              # FIXME this table content in a component definition
              # This should probably have just been 'Normal' in most cases
              # puts Rainbow('HL7TableCaption: ' + extract_text(node)).yellow
            when 'Note'
              # add_datatype_or_component_content(node, :note)
              # This should probably have just been 'Normal' in most cases
              # puts Rainbow('Note: ' + extract_text(node)).yellow
            when 'NoteIndented'
            when 'NoteChar' # first appears in Ch6
            when 'Example'
              # add_datatype_or_component_content(node, :example)
              # This should probably have just been 'Normal' in most cases
              # puts Rainbow('Example: ' + extract_text(node)).yellow
            when 'Tableheading'
              raise
              # This should probably have just been 'Normal' in most cases
              puts Rainbow('Tableheading: ' + extract_text(node)).red;puts
            else
              
              # There aren't anymore right now but may be some in other docx
              puts 'Unknown style for paragraph: ' + Rainbow(style).red
              raise
            end
            # @figure should only be preserved for the very next paragraph after the figure, then forget about it.
          end
        else # no style
          # text = extract_text(node).strip
          # puts Rainbow(text).orange unless text.empty?
          # puts '*'*20
          # add_text(node)
        end
        @last_figure = nil
        @list = nil unless last_node_was_list # assumes that all items in a list occur in successive p elements
      else
        unless node.name == 'bookmarkStart' # not worrying about bookmarks in Word document
          puts Rainbow(node.name).orange
          puts node.to_xml[0..1000]
        end
      end
    end
    
    def create_segment(node)
      # check
      txt = extract_text(node).strip
      abbrv, name = split_title(txt)
      if ['CM0', 'CM1', 'CM2'].include?(name.to_s) && chapter == 7
        # placeholder in case we want to skip these later.  They are defined in Ch8
      elsif name.to_s =~ /[s|S]egment\s*(\(Proposed Example Only\)|\(Fields That Apply to Most Observations(\/Services)?\))?$/
        # puts 'Creating ' + Rainbow("#{txt}").green
      elsif name.to_s =~ /segment usage in vaccine messages/
        # TODO how deal with what amounts to a profile on a segment definition
        # this appears to be a one-off from Ch.4A
      else
        if txt =~ /\([E|e]vent.+\)/
        elsif txt =~ /[s|S]egment\s*$/
          puts node.to_s
        elsif txt =~ /[s|S]egment/
          puts 'Not creating ' + Rainbow(txt).red
        else
          # puts Rainbow("#{txt}").yellow + '  is not a segment.'
        end
        return
      end
      puts Rainbow('# ').orange + 'Starting segment ' + Rainbow(abbrv).orange
      html_seg = @html_segs[name]
      unless html_seg
        puts Rainbow("FAIL: #{name.inspect}").red
        puts node.to_s
      end
      ChangeTracker.start
      @segment = HL7::SegmentDefinition.create(:name => name, :code => abbrv)
      @segment.source = make_html_code(html_seg)
      @segment.withdrawn = !!(txt =~ /WITHDRAWN/)
      @segment.origin = chapter
      @segment.save
      ChangeTracker.commit
      inner = html_seg[1..-1].take_while { |n| n.name != 'h4' }
      table = inner.find do |n|
        found_a_table = n.name == 'table'
        next unless found_a_table
        # puts n.children
        first_td = n.css('td').first
        first_th = n.css('th').first
        found_a_table && (first_td&.text == 'SEQ' || first_th&.text == 'SEQ')
      end
      if table
        # puts Rainbow("Found table for #{txt}").magenta
        defns = find_inner_definitions(html_seg, :segment)
        extract_fields(table, defns)
      else
        puts Rainbow("NO TABLE for #{txt}").red
        return if txt =~ /CM[0-2]/
        inner.each { |nd| puts nd.to_xml(indent:2); puts }
        raise
      end
      ChangeTracker.start
      @segment.description = make_html_text(inner.select {|n| n != table}) # everything that came before the component definitions, except for the table (and table caption which already removed)
      @segment.save
      ChangeTracker.commit
      @segments[name] = {:obj => @segment, :data_elements => []}
      @data_element_num = 0
      @data_element = nil
    end
    
    def report_def_field_error(rows, defns)
      puts Rainbow("#{@segment.name} has #{rows.count} fields and #{defns.count} definitions").red
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
      defns.keys.each_with_index {|d,i| puts "#{i+1} #{d}"}
      puts
    end
    
    def extract_fields(table, defns)
      rows = table.at('tbody').children.reject { |n| n.name == 'text'}
      rows.shift if rows[0].children.reject { |n| n.name == 'text'}.first.text == 'SEQ'
      # defns.shift if defns.count == rows.count + 1 # hope like heck that this deals with the hidden extra '0' section before the definitions....
      unless (rows.count == defns.count) || defns.count == 0 
        report_def_field_error(rows, defns)
      end
      rows.each do |row|
        entries = []
        row.children.each do |td|
          next if td.name == 'text'
          entry = td.text.strip
          entry = nil if entry.empty?
          entries << entry
        end
        # @datatypes[@datatype.name][:components] << entries
        seq, len, clen, dt, opt, rp, tbl, item_num, name = entries
        # puts Rainbow(clen).red if clen&.strip == '#' # there are none
        # if clen # all values have either = or #
        #   puts Rainbow(clen).orange unless clen =~ /=|#/
        # end
        example = name.slice(/(?<=\(e\.g\., ).+(?=\))/)
        # HACK unless for 3.4.17.5
        name  = name.gsub(/ \(.*/, '') unless name =~ /\(years\)/
        name.gsub!(/\s+/, ' ')
        _clen = clen&.delete('#=')
        min_length, max_length = len.to_s.split(/\.+./)
        item_num = item_num.to_i
        
        data_element = HL7::DataElement.where(:item_number => item_num).first
        if data_element
          # puts Rainbow("  #{seq} uses existing DataElement with item number #{item_num}").green
        else
          data_element_props = {
            :item_number => item_num,
            :min_length  => min_length,
            :max_length  => max_length,
            :c_length    => _clen,
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
          data_element.source = make_html_code([row])
          if defns.any?
            # HACK really this just sweeps inconsistency in the sources under the rug...
            search_name = name.gsub(/\W+/, '').downcase
            data_element_name, defn = defns.find { |k,_| k.gsub(/\W+/, '').downcase == search_name }
            if defn
              data_element.description = make_html_text([defn].flatten)
            else
              puts Rainbow("Can't find a definition for #{name}").yellow
              pp defns.keys
            end
          end
          ChangeTracker.commit
          if dt
            datatype = HL7::DataType.where(:code => dt).first
            ChangeTracker.start
            datatype ||= HL7::DataType.create(:code => dt)
            data_element.data_type = datatype
            ChangeTracker.commit
          end
          if tbl
            tid = tbl.to_s.strip.to_i
            vs = HL7::ValueSet.where(:table_id => tid).first
            ChangeTracker.start
            vs ||= HL7::ValueSet.create(:table_id => tid)
            data_element.table = vs
            ChangeTracker.commit
          end
          # puts "Created DataElement named #{data_element.name}"
        end
        # min_cardinality and max_cardinality and must_support are derived from rp and opt
        field_props = {
          :sequence_number => seq,
          :repetition => rp
        }
        
        if rp.nil? || rp.strip.empty? || rp == 'N'
          field_props[:max_cardinality] = 1
        elsif rp == 'Y' || rp == 'y'
          # field_props[:max_length] = '*' # unset implies '*'
        elsif rp =~ /Y\/\d+$/
          field_props[:max_cardinality] = rp.slice(/\d+/).to_i
        elsif rp =~ /\d+/
          field_props[:max_cardinality] = rp.to_i
        elsif rp =~ /\d+-\d+/
          lo,hi = rp.split('-')
          field_props[:max_cardinality] = hi.to_i
        elsif rp[0]
          puts Rainbow("RP/# for #{name} was #{rp}").red
        end
        
        ChangeTracker.start
        field = HL7::Field.create(field_props)
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
          # field.must_support = FIXME
          # field.min_cardinality = FIXME
        when 'C', 'C(a/b)'
          # field.must_support = FIXME
          # field.min_cardinality = FIXME
        when 'X'
          # field.must_support = FIXME
          # field.min_cardinality = FIXME
        when 'B'
          # field.must_support = FIXME
          # field.min_cardinality = FIXME
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
        ChangeTracker.commit
        ChangeTracker.start
        field.data_element = data_element
        @segment.add_field(field)
        ChangeTracker.commit
      end
    end
    
    # Does Nothing -- FIXME remove this
    def add_to_data_element(node)
      return
      @data_element_num += 1
      title = extract_text(node)
              .gsub(/\(.*\).*/, '')
              .gsub(/^[A-Z]+[-]\d+/, '')
              .strip
      @data_element = @segment.data_elements.find { |de| de.name.downcase == title.downcase }
      msg = "#{@segment.code}: #{@data_element_num} - #{title}"
      if @data_element
        # puts Rainbow(msg).green
      else
        p @segment.data_elements.map { |de| de.name }.sort
        puts Rainbow('NOT FOUND ' + msg).red
        # puts node
      end
    end
  end # DocXtractor
end # V2Web
