module V2Plus
  class SegmentDefinition  
    
    def self.make(data)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      this = new
      this.name        = data['name'].first['value']
      this.code        = data['abbreviation'].first['value']
      this.withdrawn   = data['withdrawn'].first['value']
      this.description = data['description']
      this.url         = data['url'].first['value']
      this.fields      = data['field']&.map { |c| V2Plus::Field.make(c) } # fields are contained and are persisted with the SegmentDefinition so there is no need to cache them
      this
    end
    
    def to_web_pub
      # FIXME
      locals = {
        :caption => "HL7 Attribute Table - #{code} - #{name}",
        # FIXME
        :segment_list_page => "http://www.hl7.eu/refactored/seg.html",
        :code => code,
        :field_rows => field_rows
      }
      table = V2Plus.render_with_locals(:segment_definition, :table, locals)
      V2Plus.save_web_file("segment-definition-#{code}.html", table)
    end
    
    def field_rows
      fields.collect { |field| field.to_segment_definition_row }.join("\n")
    end
      
  end # SegmentDefinition
end # V2Plus
