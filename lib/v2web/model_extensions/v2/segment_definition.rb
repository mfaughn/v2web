module HL7::V2
  class SegmentDefinition
    
    def data_elements
      fields.collect { |f| f.data_element }
    end
    
    def local_url_name
      name.downcase.gsub(/[^A-Za-z\d]/, '-')
    end
    
    def to_web_pub
      page = to_pub_clause(3)
      V2Pub.save_web_file("segment-definition/#{code}.html", page)
    end
    
    # TODO make dry w/ above.  Only difference may be depth variability and wrapping in page layout
    def to_pub_clause(depth)
      locals = {
        :caption => "HL7 Attribute Table - #{code} - #{name}",
        :segment_list_page => "segment-definitions.html",
        :code => code,
        :field_rows => field_rows
      }
      table = V2Pub.render_with_locals(:segment_definition, :table, locals)
      content = description&.content
      table_regexp = /<div class=.insert-segment-table. id=....-attribute-table.*><\/div>/
      # print code
      # print content.scan(table_regexp).count
      content = content.sub(table_regexp, table)
      # puts content.scan(table_regexp).count
      # <div class="insert-segment-table" id="BHS-attribute-table"></div>
      
      locals = {
        :depth   => depth,
        :content => content,
        :field_definitions => field_definitions_html(depth + 1),
        :title   => page_title
      }
      clause = V2Pub.render_with_locals(:segment_definition, :page, locals)
    end
    
    def page_title
      title = name
      title << " Segment" unless title =~ /segment/i
      title = title.split(/[–|-]/).map(&:titleize).join('-')
      title = "#{code} - #{title}"
      # puts title
      title
    end
    
    def field_rows
      html = []
      ff = fields
      ff.each_with_index { |f, i| html << f.to_segment_definition_row((i + 1) == ff.size) }
      html.join("\n")
    end
    
    def field_definitions_html(depth = 4)
      html = []
      ff = fields
      ff.each_with_index { |f, i| html << f.to_web_definition("#{code}-#{i+1}", depth) }
      html.join("\n")
    end
    
    def hack_zl7
      return unless code == 'ZL7'
      f = fields
      return if fields.find { |f| f.data_element }
      # puts "hack ZL7"
      de1 = HL7::DataElement.new
      de1.name = 'Primay key value - ZL7'
      de1.item_number  = nil
      de1.min_length   = nil 
      de1.max_length   = nil
      de1.c_length     = nil
      de1.may_truncate = nil
      de1.data_type    = HL7::DataType.get('coded-with-exceptions')
      de1.definition   = Gui_Builder_Profile::RichText.create(:content => '<p class="v2 v2-normalindented">Definition: This field contains HL7 table values for identifier and text encoded as a CWE data type.</p>')
      f[0].data_element = de1
      
      de2 = HL7::DataElement.new
      de2.name = 'Display-sort-key'
      de2.item_number  = nil
      de2.min_length   = nil
      de2.max_length   = nil
      de2.c_length     = 3
      de2.may_truncate = false
      de2.data_type    = HL7::DataType.get('numeric')
      de2.definition   = Gui_Builder_Profile::RichText.create(:content => '<p class="v2 v2-normalindented">Definition: This field is used to specify a non-alphabetic ordering for display or print versions of a standard HL7 table.</p>')
      f[1].data_element = de2
    end
    
    def get_field(num)
      num = num.strip.to_i if num.is_a?(String)
      fields.find { |f| f.sequence_number == num }
    end
    
  end # SegmentDefinition
end # V2
