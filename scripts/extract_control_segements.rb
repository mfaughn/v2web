require 'open3'
module V2Web
  class DocXtractor
    def extract_control_segements(doc, html)
      @html = File.open(html) { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!
      @segment  = nil
      @metadata = false
      @values = false
      @sets = {}
      @node_names = []
      do_control_segements
    end
    
    def do_control_segements
      @html.at('body').children.each do |node|
        # blockquote
        # ol
        # p
        # section
        # table
        # text
        # ul
        case node.name
        when 'h3'
          create_segment(node)
        when 'h4'
          puts "H4 -- #{node.text}"
          # create_value_set(node)
        when 'h5'
          puts "H5 -- #{node.text}"
        when 'blockquote'
          # FIXME
        when 'ol'
          # FIXME
        when 'ul'
          # FIXME
        when 'text'
          # t = extract_text(node)
          t = node.text.strip
          puts Rainbow(t).red if t[0]
        when 'table'
          # extract_vs_table(node)
          @metadata = false
          @values   = false
        when 'p'
          # puts "Paragraph -- #{node.text}"
          
          # vs_p(node)
        when 'section'
          puts "Section"#{}" -- #{node.text}"
        else
          puts Rainbow(node.name).red
          # puts node
        end
      end
      # @html_dt.keys.sort.each {|k| p k}
    end
    
    def set_vs_type(node)
      t = node.text
      ChangeTracker.start
      case
      when t =~ /User-defined/
        @vs.type = 'user-defined'
      when t =~ /External(ly-defined)?/
        @vs.type = 'externally-defined'
      when t =~ /HL7 Table/
        @vs.type = 'hl7-defined'
      when t =~ /Imported/
        @vs.type = 'imported'
      end
      @vs.save
      ChangeTracker.commit
    end
    
    def vs_p(node)
      text = node.to_s
      if text =~ /Table Metadata/
        @metadata = true
      elsif text =~ /(User-defined|External(ly-defined)?|HL7|Imported) Table/
        @values = true
        set_vs_type(node)
      elsif text =~ /These values are suggestions only; they are not required for use in HL7 messages/
        ChangeTracker.start
        @vs.values_are_suggestions = true
        ChangeTracker.commit
      else
        ChangeTracker.start
        if @vs.text
          @vs.text_content = @vs.text_content + "\n" + text
        else
          html = Gui_Builder_Profile::RichText.create(:content => text)
          html.markup_language = 'HTML'
          html.save
          @vs.text = html
        end
        @vs.save
        ChangeTracker.commit
      end
    end
        
    def create_segment(node)
      t = node.text
      abbrv, name = t.split(/\s*[-|‑|-|–]\s*/)
      # puts Rainbow("#{abbrv} - #{name}").green
      ChangeTracker.start
      @vs = HL7::SegmentType.create(:name => name.strip, :abbreviation => abbrv)
      ChangeTracker.commit
    end
    
    def add_vs_content(node, type = nil)
      t = extract_text(node).strip
      return if t.empty?
      case type
      when :example
        puts Rainbow(t).cyan
      when :note
        puts Rainbow(t).yellow
      else
        puts Rainbow(t).orange
      end
    end
    
    def extract_vs_table(node)
      extract_vs_metadata(node) if @metadata
      extract_values(node) if @values
      @values   = false
      @metadata = false
    end
    
    def get_table_array(node)
      # if @vs.table_id == 56
      #   puts node;puts
      # end
      rows = node.at('tbody').children.reject { |n| n.name == 'text' }
      rows.map do |row|
        cells = row.children.reject { |n| n.name == 'text' }
        cells.map do |c|
          t = c.inner_html
          t.empty? ? nil : t
        end
      end
    end
    
    def get_table_headers(node)
      row = node.at('thead')&.children&.reject { |n| n.name == 'text' }&.first
      if row
        row.children.reject { |n| n.name == 'text' }.map do |c|
          t = c.inner_html
          t.empty? ? nil : t
        end
      else
        nil
      end
    end
    
    def extract_vs_metadata(node)
      rows = get_table_array(node)
      puts "#{vs.table_id} has weird metadata" unless rows.first.size == 6
      rows.each do |r|
        ChangeTracker.start
        @vs.steward = r[1]
        @vs.v_3_harmonization = r[2]
        @vs.v_3_equivalent = r[3]
        @vs.where_used = r[4]
        @vs.status = r[5].downcase if r[5]
        puts Rainbow("#{@vs.table_id} - #{@vs.name} has no status").red unless r[5]
        @vs.save
        ChangeTracker.commit
      end
    end
    
    def extract_values(node)
      rows = get_table_array(node)
      headers = get_table_headers(node)
      headers ||= rows.shift
      unless headers[0] =~ /Value/ && headers[1] =~ /Description/ && headers[2] =~ /Comment/ && headers.count == 3
        puts Rainbow(@vs.table_id.to_s + ' - ' + headers.inspect).green
      end
      ChangeTracker.start
      @vs.field_names = headers.join(' | ')
      @vs.save
      ChangeTracker.commit
      comment_header = headers.index { |f| f =~ /Comment/i }
      rows.each_with_index do |r, i|
        ChangeTracker.start
        v = HL7::Value.create
        if comment_header
          comment = r.delete_at(comment_header)
          html = Gui_Builder_Profile::RichText.create(:content => comment)
          html.markup_language = 'HTML'
          html.save
          v.comment = html
          v.save
        end
        v.field_1 = r[0] if r[0]
        v.field_2 = r[1] if r[1]
        v.field_3 = r[2] if r[2]
        v.field_4 = r[3] if r[3]      
        @vs.add_value(v)
        ChangeTracker.commit
        # p v;puts
      end
    end
    
    # def _extract_value_sets(node)
    #   case node.name
    #   when 'body', 'document'
    #     node.children.each { |c| _extract_value_sets(c) }
    #   when 'tbl'
    #     extract_vs_table(node)
    #   when 'bookmarkStart', 'bookmarkEnd', 'sectPr'
    #     # ignore
    #   when 'p'
    #     last_node_was_list = false
    #     # puts Rainbow(node.path).green
    #     styles = node.xpath('.//pPr/pStyle')
    #     puts Rainbow('Multiple Styles!').red if styles.count > 1
    #     if styles.first
    #       val_attr = styles.first.attributes.find { |a| a.first == 'val' }
    #       style = val_attr.last.value
    #       if style =~ /Heading/
    #         if style[-1].to_i == 4
    #           create_value_set(node)
    #         else
    #           raise
    #         end
    #       else
    #         case style
    #         when 'TOC1', 'TOC2', 'TOC3', 'TOC4', 'TOC5', 'TableofFigures'
    #         when 'NormalIndented'
    #           #FIXME
    #         when 'HL7TableCaption'
    #           @values = true
    #           ChangeTracker.start
    #           @vs.defined_by = 'hl7'
    #           ChangeTracker.commit
    #         when 'UserTableCaption'
    #           @values = true
    #           ChangeTracker.start
    #           @vs.defined_by = 'user'
    #           ChangeTracker.commit
    #         when 'TableMetaCaption'
    #           @metadata = true
    #         when 'Note'
    #           add_vs_content(node, :note)
    #         when 'Example'
    #           add_vs_content(node, :example)
    #         else
    #           puts 'Unknown style for paragraph: ' + Rainbow(style).red
    #         end
    #       end
    #     else
    #       text = extract_text(node).strip
    #       if text =~ /These values are suggestions only; they are not required for use in HL7 messages/
    #         ChangeTracker.start
    #         @vs.values_are_suggestions = true
    #         ChangeTracker.commit
    #       else
    #         add_vs_content(node)
    #         # puts Rainbow(node.to_s).orange unless text.empty?
    #         # puts Rainbow(text).orange unless text.empty?
    #       end
    #     end
    #   else
    #     puts Rainbow(node.name).orange
    #     puts node.to_xml[0..1000]
    #   end
    # end

  end
end
