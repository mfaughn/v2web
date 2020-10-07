module HL7
  class SegmentDefinition
    def data_elements
      fields.collect { |f| f.data_element }
    end
    def local_url_name
      name.downcase.gsub(/[^A-Za-z\d]/, '-')
    end
    
    def url_name
      'http://v2.hl7.org/fhir/SegmentDefinition/' + local_url_name
    end
    
    def to_resource
      xml = HL7.get_instance_template(:segment_def, 'base')
      xml.sub!('URL', local_url_name)
      [:name, :withdrawn, :code].each do |property|
        xml.sub!(property.to_s.upcase, send(property).to_s)
      end
      xml.sub!('DESCRIPTION', resource_description_content)
      fields_xml = []
      fields.each { |f| fields_xml << f.to_resource }
      xml.sub!('FIELDS', fields_xml.join)
      Nokogiri::XML(xml,&:noblanks).to_s
    end
    
    def resource_description_content
       if description_content && description_content.strip[0]
         HL7.get_instance_template(:common, 'description').sub('VALUE', description_content)
       else
         ''
       end
    end
  end
end # module HL7
