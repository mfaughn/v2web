module V2Plus
  class SegmentDefinition  
    
    def self.make(doc, identifier = nil)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      this = new
      nodeset = doc.css('SegmentDefinition')
      this.name        = nodeset.get_val('name')
      this.code        = nodeset.get_val('abbreviation')
      this.withdrawn   = nodeset.get_val('withdrawn')
      
      # desc = nodeset.css('description > div')&.to_html(save_with: Nokogiri::XML::Node::SaveOptions::AS_XML | Nokogiri::XML::Node::SaveOptions::NO_EMPTY_TAGS | Nokogiri::XML::Node::SaveOptions::FORMAT)
      desc = nodeset.css('description > div')&.to_html
      
      this.description  = Gui_Builder_Profile::RichText.create(:content => desc) # gets the entire div
      
      this.url         = nodeset.get_val('url')
      this.fields      = nodeset.css('field').map { |c| V2Plus::Field.make(c) } # fields are contained and are persisted with the SegmentDefinition so there is no need to cache them
      this.hack_zl7
      this
    end

    def hack_zl7
      return unless code == 'ZL7'
      f = fields
      return if fields.find { |f| f.data_element }
      # puts "hack ZL7"
      de1 = V2Plus::DataElement.new
      de1.name = 'Primay key value - ZL7'
      de1.item_number  = nil
      de1.min_length   = nil
      de1.max_length   = nil
      de1.c_length     = nil
      de1.may_truncate = nil
      de1.data_type    = V2Plus::DataType.get('coded-with-exceptions')
      de1.definition   = Gui_Builder_Profile::RichText.create(:content => '<p class="v2 v2_normalindented">Definition: This field contains HL7 table values for identifier and text encoded as a CWE data type.</p>')
      f[0].data_element = de1
      
      de2 = V2Plus::DataElement.new
      de2.name = 'Display-sort-key'
      de2.item_number  = nil
      de2.min_length   = nil
      de2.max_length   = nil
      de2.c_length     = 3
      de2.may_truncate = false
      de2.data_type    = V2Plus::DataType.get('numeric')
      de2.definition   = Gui_Builder_Profile::RichText.create(:content => '<p class="v2 v2_normalindented">Definition: This field is used to specify a non-alphabetic ordering for display or print versions of a standard HL7 table.</p>')
      f[1].data_element = de2
    end

    def to_web_pub
      page = to_composition_clause(3)
      # locals = {
      #   :caption => "HL7 Attribute Table - #{code} - #{name}",
      #   # FIXME
      #   :segment_list_page => "http://www.hl7.eu/refactored/seg.html",
      #   :code => code,
      #   :field_rows => field_rows
      # }
      # table = V2Plus.render_with_locals(:segment_definition, :table, locals)
      # content = description&.content
      # table_regexp = /<div class="insert-segment-table" id="...-attribute-table"><\/div>/
      # # print code
      # # print content.scan(table_regexp).count
      # content = content.sub(table_regexp, table)
      # # puts content.scan(table_regexp).count
      # # <div class="insert-segment-table" id="BHS-attribute-table"></div>
      #
      # locals = {
      #   :content => content,
      #   :field_definitions => field_defintions_html,
      #   :title => page_title
      # }
      # page = V2Plus.render_with_locals(:segment_definition, :page, locals)
      V2Plus.save_web_file("segment-definition-#{code}.html", page)
    end
    
    # TODO make dry w/ above.  Only difference may be depth variability and wrapping in page layout
    def to_composition_clause(depth)
      locals = {
        :caption => "HL7 Attribute Table - #{code} - #{name}",
        # FIXME
        :segment_list_page => "http://www.hl7.eu/refactored/seg.html",
        :code => code,
        :field_rows => field_rows
      }
      table = V2Plus.render_with_locals(:segment_definition, :table, locals)
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
        :field_definitions => field_defintions_html(depth + 1),
        :title   => page_title
      }
      clause = V2Plus.render_with_locals(:segment_definition, :page, locals)
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
    
    def field_defintions_html(depth = 4)
      html = []
      ff = fields
      ff.each_with_index { |f, i| html << f.to_web_definition("#{code}-#{i+1}", depth) }
      html.join("\n")
    end
      
  end # SegmentDefinition
end # V2Plus
