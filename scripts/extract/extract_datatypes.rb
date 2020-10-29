require_relative 'extractor_helpers'
module V2Web
  class DocXtractor
    def clear_hl7
      HL7.classes(:no_imports => true).each do |c|
        next unless c < Sequel::Model
        next if c.enumeration?
        if DB.tables.include?(c.table_name)
          c.delete
        end
      end
      nil
    end
    
    def extract_datatypes(doc, html)
      @html = File.open(html) { |f| Nokogiri::XML(f) }
      @html_dt = {}
      @current_html_dt = nil      
      find_datatypes
      @node_types = []
      @styles = []
      doc.remove_namespaces!
      # ChangeTracker.start
      # ChangeTracker.commit
      @datatype = nil
      @datatypes = {}
      @component = nil
      doc.children.each { |c| _extract_datatypes(c) }
      add_types_to_components
      # puts @node_types.uniq.sort
      # puts
      # puts @styles.map { |x| x.to_s.slice(/(?<=<pStyle val=").+(?="\/>)/)}.uniq.sort
      create_varies_datatype
    end
    
    # TODO there has got to be a better way to deal with data elements that may have different datatypes
    # I would suggest defining multiple data elements and having an OR for those...
    def create_varies_datatype
      ChangeTracker.start
      @datatype = HL7::DataType.create(:name => 'Varies', :code => 'Varies')
      ChangeTracker.commit
    end
    
    def _extract_datatypes(node)
      @node_types << node.name
      case node.name
      when 'body'
        node.children.each { |c| _extract_datatypes(c) }
      when 'document'
        node.children.each { |c| _extract_datatypes(c) }
      when 'tbl'
        # Hey, this ends up doing NOTHING!
        # parse_components(node) || other_table(node)
      when 'bookmarkStart', 'bookmarkEnd'
        # TODO
      when 'sectPr'
        # TODO not sure what this is for
      when 'p'
        last_node_was_list = false
        # puts Rainbow(node.path).green
        styles = node.xpath('.//pPr/pStyle')
        # styles.each { |s| @styles << s }
        puts Rainbow('Multiple Styles!').red if styles.count > 1
        if styles.first
          val_attr = styles.first.attributes.find { |a| a.first == 'val' }
          style = val_attr.last.value
          if style =~ /Heading/
            if style[-1].to_i == 3
              create_datatype(node)
            elsif style[-1].to_i == 4 && extract_text(node).strip[0] # there were empty headings, get rid of them
              add_to_component(node)
            end
          else
            case style          
            when 'TOC1', 'TOC2', 'TOC3', 'TOC4', 'TOC5', 'TableofFigures'
            when 'List'
              # this appears to be a list item
              # puts Rainbow("#{style}: #{extract_text(node)}").yellow;puts

            # Make these DRY
            when 'NormalListAlpha'
              add_datatype_or_component_content(node, :list)
              
              # puts Rainbow("#{style}: #{extract_text(node)}").yellow;puts
            #   start_list('letters') unless @list
            #   last_node_was_list = true
            #   add_list_item(node)
            when 'Bullet', 'NormalListBullets'
              add_datatype_or_component_content(node, :bullet)
              
              # puts Rainbow("#{style}: #{extract_text(node)}").yellow
            #   start_list('bullets') unless @list
            #   last_node_was_list = true
            #   add_list_item(node)
            when 'OtherTableCaption'
              add_datatype_or_component_content(node, :table_caption)
              # FIXME this table content in a component definition
              # puts Rainbow("#{style}: #{extract_text(node)}").yellow;puts
            when 'NormalIndented'
              add_datatype_or_component_content(node)
              # this is just content found for definitions and examples and stuff, treat as normal
              # puts Rainbow('NormalIndented: ' + extract_text(node)).yellow
            when 'ComponentTableCaption'
              # These can be skipped
            when 'HL7TableCaption'
              add_datatype_or_component_content(node, :table_caption)
              # FIXME this table content in a component definition
              # This should probably have just been 'Normal' in most cases
              # puts Rainbow('HL7TableCaption: ' + extract_text(node)).yellow
            when 'Note'
              add_datatype_or_component_content(node, :note)
              # This should probably have just been 'Normal' in most cases
              # puts Rainbow('Note: ' + extract_text(node)).yellow
            when 'Example'
              add_datatype_or_component_content(node, :example)
              # This should probably have just been 'Normal' in most cases
              # puts Rainbow('Example: ' + extract_text(node)).yellow
            when 'Tableheading'
              raise
              # This should probably have just been 'Normal' in most cases
              puts Rainbow('Tableheading: ' + extract_text(node)).red;puts
            else
              
              # There aren't anymore right now but may be some in other docx
              puts 'Unknown style for paragraph: ' + Rainbow(style).red
              add_text(node)
            end
            # @figure should only be preserved for the very next paragraph after the figure, then forget about it.
          end
        else
          text = extract_text(node).strip
          puts Rainbow(node.to_s).orange unless text.empty?
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
    
    def add_types_to_components
      HL7::Component.all.each do |c|
        dt = c.legacy_dt
        if dt
          type = HL7::DataType.where(:code => dt).first
          if type
            ChangeTracker.start
            c.type = type
            ChangeTracker.commit
          else
            puts Rainbow("Could not find datatype for #{c.owner.code}::#{c.name}").orange
          end
        end
      end
    end
    
    def find_datatypes
      @html.at('body').children.each do |node|
        if node.name == 'h3'
          abbrv, name = split_title(node.text)
          @current_html_dt = name.strip
          @html_dt[@current_html_dt] = []
        end
        next unless @current_html_dt
        @html_dt[@current_html_dt] << node unless node.name == 'text'
      end
      # @html_dt.keys.sort.each {|k| p k}
    end
    
    def check
      return unless @datatype
      names = Hash.new(0)
      @datatype.components.each { |c| names[c.name] += 1 }
      dupes = names.select { |_,v| v > 1 }
      if dupes.any?
        puts Rainbow(@datatype.code).green
        puts dupes.keys
        puts
      end
    end
      
    def extract_components(table, defns)
      rows = table.at('tbody').children.reject { |n| n.name == 'text'}[1..-1]
      unless (rows.count == defns.count) || defns.count == 0 
        p defns.count.to_s + '  ' + defns.keys.join(', ')
        puts Rainbow(@datatype.name).red
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
        seq, len, clen, dt, opt, tbl, name, comment, ref = entries
        # puts Rainbow(clen).red if clen&.strip == '#' # there are none
        # if clen # all values have either = or #
        #   puts Rainbow(clen).orange unless clen =~ /=|#/
        # end
        if seq == '...'
          ChangeTracker.start
          @datatype.array_type = true
          @datatype.save
          ChangeTracker.commit
          next
        end
        example = name.slice(/(?<=\(e\.g\., ).+(?=\))/)
        name  = name.gsub(/ \(.*/, '').gsub(/\s+/, ' ')
        _clen = clen&.delete('#=')
        min_length, max_length = len.to_s.split(/\.+./)
        props = {
          :sequence_number => seq,
          :min_length => min_length,
          :max_length => max_length,
          :c_length   => _clen,
          :legacy_dt  => dt,
          :legacy_tbl => tbl,
          :name       => name,
          :legacy_ref => ref
        }
        ChangeTracker.start
        component = HL7::Component.create(props)
        component.add_comment(comment) if comment
        component.add_example(example) if example
        if opt
          component.optionality = opt
        else
          # puts "No optionality for #{seq}\n#{rows}"
        end
        if clen =~ /=/
          component.may_truncate = 'false'
        elsif clen =~ /#/
          component.may_truncate = 'true'
        else
          component.may_truncate = 'not applicable'
        end
        component.table_row_source = make_html_code([row])
        if defns.any?
          defn = defns[name.delete("’'")]
          if defn
            component.definition = make_html_text([defn].flatten)
          else
            puts Rainbow("Can't find a definition for #{name.inspect}").yellow
            pp defns.keys
            puts defn.class
          end
        end
        
        # FIXME add definition stuff using defn[name] to get html -- this dumps all examples and everything straight in with no formatting but it is a good start
        @datatype.add_component(component)
        ChangeTracker.commit
        if tbl
          tid = tbl.to_s.strip.to_i
          vs = HL7::ValueSet.where(:table_id => tid).first
          ChangeTracker.start
          vs ||= HL7::ValueSet.create(:table_id => tid)
          component.table = vs
          ChangeTracker.commit
        end
      end
    end
    
    def create_datatype(node)
      # check
      txt = extract_text(node).strip
      abbrv, name = split_title(txt)
      puts Rainbow("#{abbrv} - #{name}").magenta
      # print Rainbow("#{abbrv} ").magenta
      html_dt = @html_dt[name]
      puts Rainbow("NO NAME: #{txt.inspect}").red unless name.to_s.strip[0]
      puts Rainbow("FAIL: #{name.inspect}").red unless html_dt
      ChangeTracker.start
      @datatype = HL7::DataType.create(:name => name, :code => abbrv)
      @datatype.html_source = make_html_code(html_dt)
      @datatype.withdrawn = !!(txt =~ /WITHDRAWN/)
      @datatype.save
      ChangeTracker.commit
      inner = html_dt[1..-1].take_while { |n| n.name != 'h4' }
      inner.reject! { |n| n.text =~ /HL7 Component Table/ }
      table = inner.find { |n| n.name == 'table' }
      if table
        defns = find_inner_definitions(html_dt)
        extract_components(table, defns)
      end
      ChangeTracker.start
      @datatype.description = make_html_text(inner.select {|n| n != table}) # everything that came before the component definitions, except for the table (and table caption which already removed)
      @datatype.save
      ChangeTracker.commit
      @datatypes[name] = {:obj => @datatype, :components => []}
      @component_num = 0
      @component = nil
    end
    
=begin
    def parse_components(node)
      return
      rows = node.xpath('.//tr')
      return false unless rows.first.to_s =~ /ComponentTableHeader/
      rows[1..-1].each do |row|
        cells = row.xpath('.//tc')
        entries = cells.map do |cell|
          et = extract_text(cell).strip
        end
        entries = entries.map { |e| e.empty? ? nil : e.strip }
        @datatypes[@datatype.name][:components] << entries
        seq, len, clen, dt, opt, tbl, name, comment, ref = entries
        # puts Rainbow(clen).red if clen&.strip == '#' # there are none
        # if clen # all values have either = or #
        #   puts Rainbow(clen).orange unless clen =~ /=|#/
        # end
        if seq == '...'
          ChangeTracker.start
          @datatype.array_type = true
          @datatype.save
          ChangeTracker.commit
          next
        end
        example = name.slice(/(?<=\(e\.g\., ).+(?=\))/)
        name = name.gsub(/ \(.*/, '').gsub(/\s+/, ' ')
        _clen = clen&.delete('#=')
        props = {
          :legacy_seq => seq,
          :length     => len,
          :c_length   => _clen,
          :legacy_dt  => dt,
          :legacy_tbl => tbl,
          :name       => name,
          :comments   => comment,
          :legacy_ref => ref
        }
        ChangeTracker.start
        component = HL7::Component.create(props)
        component.example = example if example
        component.optionality = opt if opt
        if clen =~ /=/
          component.may_truncate = 'false'
        elsif clen =~ /#/
          component.may_truncate = 'true'
        else
          component.may_truncate = 'not applicable'
        end
        component.table_row_source = make_xml_code(node)
        @datatype.add_component(component)
        ChangeTracker.commit
      end
    end
=end
    def add_to_component(node)
      return
      @component_num += 1
      title = extract_text(node).gsub(/\(.*\)/, '').strip
      @component = @datatype.components.find { |c| c.name.downcase == title.downcase }
      msg = "#{@datatype.code}: #{@component_num} - #{title}"
      if @component
        # puts Rainbow(msg).green
      else
        p @datatype.components.map { |c| c.name }.sort
        puts Rainbow(msg).red
        puts node
      end
    end
    
    # FIXME ???? return ?
    def add_datatype_or_component_content(node, style = nil)
return
      obj    = @component || @datatype
      text   = extract_text(node)
      # html_text = get_html(node)
      # html_text = apply_style(html_text, style) if style
      add_datatype_or_component_definition(obj, html_text, node)
      if node.to_s =~ /href=/
        puts node.to_s
        puts "*"*22
        puts html_text
        puts
      end
      # if text =~ /^(Definition|Attention)/
      #   add_datatype_or_component_definition(obj, html_text, node)
      # else
      #   if @component
      #     # puts Rainbow(text).yellow
      #   else
      #     add_datatype_or_component_definition(obj, html_text, node)
      #   end
      #   # puts
      # end
        
    end
    
    
    def add_datatype_or_component_definition(obj, text, node)
      ChangeTracker.start
      if obj.definition_source
        obj.definition_source_content = obj.definition_source_content + "\n" + node.to_xml
      else
        obj.definition_source = make_xml_code(node)
      end
      if obj.definition
        obj.definition_content = obj.definition_content + "\n" + text
      else
        obj.definition = Gui_Builder_Profile::RichText.create(:content => text)
      end
      obj.save
      ChangeTracker.commit
    end
    
    def other_table(node)
    end
    
  end
end
