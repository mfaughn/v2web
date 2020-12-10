require_relative 'extractor_helpers'
module V2Web
  class DocXtractor
    def setup_for_datatypes(source)
      puts Rainbow('#### Parse Data Types ####').magenta
      source == 'datatypes' ? setup(source, '2A') : setup(source)
    end

    def extract_datatypes(source)
      doc = setup_for_datatypes(source)
      create_datatype_list(doc)
      @docx_dt.each { |code_and_name, content| create_datatype(code_and_name, content) }
      add_types_to_components
      create_varies_datatype
    end
    
    def create_datatype_list(doc)
      doc.remove_namespaces!
      @docx = doc
      @docx_dt = {}
      @current_docx_dt = nil      
      find_datatypes_from_docx
      @docx_dt.keys.each { |k| HL7Parse.datatype_titles << k }
    end
    
    def sort_dt_node(node)
      # puts extract_text(node)
      if @component_number > 0
        # puts @component_number.to_s
        @docx_dt[@current_docx_dt][:components][@component_number] << node
      elsif !@docx_dt[@current_docx_dt][:table]
        # puts 'before'
        @docx_dt[@current_docx_dt][:before_table] << node
      else
        # puts 'after'
        @docx_dt[@current_docx_dt][:after_table] << node
      end
    end
    
    def find_datatypes_from_docx
      @component_number = nil
      @docx.at('body').children.each do |node|
        if node.name == 'tbl' && !@docx_dt[@current_docx_dt][:table]
          @docx_dt[@current_docx_dt][:table] = node
          next
        end
        
        case node.name
        when 'tbl'
          sort_dt_node(node)
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
                # abbrv, name = split_title(node.text)
                # @current_docx_dt = name.strip
                txt = extract_text(node).strip
                @current_docx_dt = txt.gsub(/withdrawn/i, '').delete('()').strip
                # puts @current_docx_dt
                @docx_dt[@current_docx_dt] = {:table => nil, :components => {}, :before_table => [], :after_table => [], :withdrawn => txt =~ /withdrawn/i }
                @component_number = 0
              elsif style[-1].to_i == 4 && extract_text(node).strip[0] # there were empty headings, get rid them
                @component_number += 1
                @docx_dt[@current_docx_dt][:components][@component_number] = [node]
              end
            elsif style == 'ComponentTableCaption'
              # do nothing
            else
              # puts Rainbow(style).red
              sort_dt_node(node)
            end
          else
            text = extract_text(node).strip
            puts Rainbow(node.to_s).orange unless text.empty?
            # add_text(node)
          end
          # @last_figure = nil
          # @list = nil unless last_node_was_list # assumes that all items in a list occur in successive pelements
        else
          unless node.name == 'bookmarkStart' # not worrying about bookmarks in Word document
            puts Rainbow(node.name).orange
            puts node.to_xml[0..1000]
          end
        end        
      end
      # @html_dt.keys.sort.each {|k| p k}
    end

    # node is a nokogiri node from docx
    # it is only the node for the heading line
    def create_datatype(code_and_name, content)
      code, name = code_and_name.split(/\s+[–|-]\s+/)
      # return unless code == 'RFR'
      print Rainbow("#{code} - #{name} ").magenta
      raise unless name
      # print Rainbow("#{code} ").magenta
      # html_dt = @html_dt[name]
      # puts Rainbow("NO NAME: #{txt.inspect}").red unless name.to_s.strip[0]
      # puts Rainbow("FAIL: #{name.inspect}").red unless html_dt
      ChangeTracker.start
      datatype = HL7::DataType.create(:name => name, :code => code.strip)
      # TODO put the xml source in here
      # datatype.html_source = make_html_code(html_dt)
      # datatype.html_source = make_html_code(html_dt)
      datatype.withdrawn = content[:withdrawn]
      description = ''
      if !content[:before_table].empty?
        # puts "*"*10 + 'BEFORE' +  "*"*10
        # puts content[:before_table]
        # puts "*"*10 + 'EROFEB' +  "*"*10
        description << Docx2HTML::Processor.new(content[:before_table], @processor_opts).process
        # puts "-"*22
      end
      if content[:table]
        description << "<div class='insert-component-table' id='#{code}-component-table' style='display: none;'></div>"
      end
      if !content[:after_table].empty?
        # puts "*"*10 + 'AFTER' +  "*"*10
        # puts content[:after_table]
        # puts "*"*10 + 'RETFA' +  "*"*10
        description << Docx2HTML::Processor.new(content[:after_table], @processor_opts).process
        # puts "-"*22
      end
      # puts Rainbow(description).cyan
      datatype.description = Gui_Builder_Profile::RichText.new(:content => description)
      datatype.save
      ChangeTracker.commit
      extract_components(content, datatype)
      # datatypes[name] = {:obj => datatype}
      # @component_num = 0
      # @component = nil
      # raise if code == 'CF'
      puts
    end
     
    def extract_components(content, datatype)
      table = content[:table]
      return unless table # withdrawn datatypes have no table
      nodes = content[:components]
      # process the table to get component data
      rows = table.css('tr')[1..-1]
      unless (rows.count == nodes.count) || nodes.count == 0 
        # p nodes.count + '  ' + defns.keys.join(', ')
        puts Rainbow(datatype.name).red
      end
      rows.each_with_index do |row, i|
        print Rainbow("#{i+1} ")
        cells = row.children.select { |n| n.name == 'tc' }.map { |cell| Nokogiri::HTML(extract_raw_tc(cell)).text }
        seq, len, clen, dt, opt, tbl, name, comment, ref = cells

        # puts Rainbow(clen).red if clen&.strip == '#' # there are none
        # if clen # all values have either = or #
        #   puts Rainbow(clen).orange unless clen =~ /=|#/
        # end
        if seq == '...'
          ChangeTracker.start
          datatype.array_type = true
          datatype.save
          ChangeTracker.commit
          next
        end
        example = name.slice(/(?<=\(e\.g\., ).+(?=\))/)
        name  = name.gsub(/ \(.*/, '').gsub(/\s+/, ' ')
        _clen = clen&.delete('#=')
        min_length, max_length = len.to_s.split(/\.+/)
        # HACK FIXME for MSG.3
        min_length, max_length = [3,7] if min_length == '3,7'
        if (min_length && !max_length) || (len =~ /,/)
          puts "#{datatype.code} - #{seq} #{len} - #{min_length}..#{max_length}"
        end
        
        
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
          component.optionality = opt.strip
          case opt.strip
          when 'W', 'O', 'B'
            component.must_support = false
          when 'C'
            component.must_support = false # FIXME
          when 'R', 'RE'
            component.must_support = true
          else
            puts Rainbow("optionality is #{opt} so must_support is ???").cyan if dt && !dt.strip.empty?
          end
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
        # This is all broken FIXME
        # rt = Gui_Builder_Profile::RichText.new(:content => row.to_s)
        # rt.markup_language = 'XML'
        # rt.save
        # component.table_row_source = rt
        # pp rt
        defn = nodes[i+1]
          if defn
            content = Docx2HTML::Processor.new(defn, @processor_opts).process(:remove_headings => true)            
            component.definition = Gui_Builder_Profile::RichText.create(:content => content )
          else
            if nodes.any?
              puts Rainbow("Can't find a definition for #{name.inspect}").yellow
              pp nodes
            end
          end
        # end
        
        # FIXME add definition stuff using defn[name] to get html -- this dumps all examples and everything straight in with no formatting but it is a good start
        datatype.add_component(component)
        ChangeTracker.commit
        if tbl
          tid = tbl.to_s.strip.to_i
          unless tid == 0
            vs = HL7::ValueSet.where(:table_id => tid).first
            ChangeTracker.start
            vs ||= HL7::ValueSet.create(:table_id => tid)
            component.table = vs
            ChangeTracker.commit
          end
        end
      end
    end
    
    # TODO there has got to be a better way to deal with data elements that may have different datatypes
    # I would suggest defining multiple data elements and having an OR for those...
    def create_varies_datatype
      ChangeTracker.start
      HL7::DataType.create(:name => 'Varies', :code => 'Varies')
      ChangeTracker.commit
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
            if c.optionality&.value == 'W' || c.sequence_number.nil?
            else
              puts Rainbow("Could not find datatype for #{c.owner.code}.#{c.sequence_number}::#{c.name}").orange
            end
          end
        end
      end
    end
    

      
  end
end
