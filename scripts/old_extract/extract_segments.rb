class OldSegmentExtractor
  def create_segment(node)
    # check
    txt = extract_text(node).strip
    abbrv, name = split_title(txt)
    if ['CM0', 'CM1', 'CM2'].include?(name.to_s) && chapter == 7
      # placeholder in case we want to skip these later.  They are defined in Ch8
    elsif name.to_s =~ /[s|S]egment\s*(\(Proposed Example Only\)|\(Fields That Apply to Most Observations(\/Services)?\))?$/
      # puts 'Creating ' + Rainbow("#{txt}").green
    elsif name.to_s =~ /segment usage in vaccine messages/
      puts Rainbow('Not creating profile on RXA - segment usage in vaccine messages').red
      return
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
    puts txt.inspect if abbrv =~ /RXA/
    puts Rainbow('# ').orange + 'Starting segment (Ch.' + chapter.to_s + ') ' + Rainbow(abbrv).orange
    html_seg = @html_segs[name]
    unless html_seg
      puts Rainbow("FAIL: #{name.inspect}").red
      puts node.to_s
    end
    ChangeTracker.start
    segment = HL7::SegmentDefinition.create(:name => name, :code => abbrv)
    segment.source = make_html_code(html_seg)
    segment.withdrawn = !!(txt =~ /WITHDRAWN/)
    segment.origin = chapter
    segment.save
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
      defns = find_field_definitions(html_seg, :segment)
      extract_fields(table, defns, segment)
    else
      puts Rainbow("NO TABLE for #{txt}").red
      return if txt =~ /CM[0-2]/
      inner.each { |nd| puts nd.to_xml(indent:2); puts }
      raise
    end
    ChangeTracker.start
    segment.description = make_html_text(inner.select {|n| n != table}) # everything that came before the component definitions, except for the table (and table caption which already removed)
    segment.save
    ChangeTracker.commit
    @segments[name] = {:obj => segment, :data_elements => []}
  end
  # Does Nothing -- FIXME remove this
  def add_to_data_element(node)
    raise "Why for you call me? This method is bad...."
    @data_element_num += 1
    title = extract_text(node)
            .gsub(/\(.*\).*/, '')
            .gsub(/^[A-Z]+[-]\d+/, '')
            .strip
    @data_element = segment.data_elements.find { |de| de.name.downcase == title.downcase }
    msg = "#{segmentcode}: #{@data_element_num} - #{title}"
    if @data_element
      # puts Rainbow(msg).green
    else
      p segment.data_elements.map { |de| de.name }.sort
      puts Rainbow('NOT FOUND ' + msg).red
      # puts node
    end
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
  
  def _extract_segments_1(node)
    @node_types << node.name # just for debugging I think
    case node.name
    when 'body'
      node.children.each { |c| _extract_segments_1(c) }
    when 'document'
      node.children.each { |c| _extract_segments_1(c) }
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
  
  def extract_fields(table, defns, segment)
    rows = table.at('tbody').children.reject { |n| n.name == 'text'}
    rows.shift if rows[0].children.reject { |n| n.name == 'text'}.first.text == 'SEQ'
    # defns.shift if defns.count == rows.count + 1 # hope like heck that this deals with the hidden extra '0' section before the definitions....
    unless (rows.count == defns.count) || defns.count == 0 
      report_def_field_error(rows, defns, segment)
    end
    rows.each { |row| extract_field(row, table, defns, segment) }
  end
  
  def extract_field(row, table, defns, segment)
    seq, len, clen, dt, opt, rp, tbl, item_num, name = remove_text_nodes(row)
    check_field_value_formats(len, clen)
    c_length = c_length = clen&.delete('#=')
    example = name.slice(/(?<=\(e\.g\., ).+(?=\))/)
    # HACK unless for 3.4.17.5
    name  = name.gsub(/ \(.*/, '') unless name =~ /\(years\)/
    # HACK for 3.4.16
    if name == "Industry" && seq == '54'
      seq = '5'
    end
    
    name.gsub!(/\s+/, ' ')
    min_length, max_length = len.to_s.split(/\.+./).map(&:strip)
    item_num = item_num.to_i

    data_element = HL7::DataElement.where(:item_number => item_num).first
    if data_element
      check_data_element_is_same(data_element, min_length, max_length, c_length, name)
    else
      data_element = create_data_element_for_field(seq, item_num, min_length, max_length, clen, c_length, name, row)
    end
    add_datatype_to_data_element(dt, data_element, opt)
    link_value_set_to_data_element(tbl, data_element)
    add_definition_to_data_element(data_element, seq, name, defns, "#{segment.code}.#{seq || 1}")

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
  
  def add_definition_to_data_element(data_element, seq, name, defn, segment_string)
    if defn
      defn = defns[seq.to_i]
      # # HACK really this just sweeps inconsistency in the sources under the rug...
      # search_name = name.gsub(/\W+/, '').downcase
      # _, defn = defns.find { |k,_| k.gsub(/\W+/, '').downcase == search_name }
      # unless defn
      #   _, defn = defns.find { |k,_| k.gsub(/\W+/, '').downcase == hack_fix_de_name(search_name) }
      # end
      if defn
        ChangeTracker.start
        de_def = HL7::DefinitionText.create(:chapter => chapter, :original_container => segment_string)
        de_def.definition = make_html_text([defn[:nodes]].flatten)
        
        puts [defn[:nodes]].flatten.map { |n| n.to_html }.join("\n")
        puts '*'*22
        
        unless name.downcase.gsub(/-|‑/, '') == defn[:title].downcase.gsub(/-|‑/, '')
          msg = defn[:field_id] + Rainbow(" DataElement name mismatch for [#{name}] and [#{defn[:title]}]").yellow
          # puts msg
          HL7Parse.name_mismatchs << "Ch. #{chapter} #{defn[:field_id]} DataElement name mismatch -- Element Name: '#{name}'; DEFINITION TITLE: '#{defn[:title]}'"
        end

        # puts "DataElement #{data_element.item_number} already has definition!" if data_element.definitions_count > 0
        data_element.add_definition(de_def)
        ChangeTracker.commit
      else
        puts Rainbow("Can't find a definition for #{seq} - #{name.inspect}").red
        pp defns.map { |sn, d| "#{sn} #{d[:field_id]} #{d[:title]}" }
        raise unless ['Marketing Basis'].include?(name)
      end
    end
  end
  
end