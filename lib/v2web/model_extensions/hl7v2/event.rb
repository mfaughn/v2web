module HL7
  class Event
    def local_url_name
      code.downcase.gsub(/[^a-z\d]/, '-')
    end
    
    def url_name
      'http://v2.hl7.org/fhir/EventDefinition/' + local_url_name
    end
        
    def to_resource
      xml = HL7.get_instance_template(:event, 'base')
      xml.sub!('URL', local_url_name)
      [:name, :code].each do |methd|
        xml.sub!(methd.to_s.upcase, send(methd).to_s)
      end
      xml.sub!('DESCRIPTION', resource_description_content)
      pp self unless trigger
      xml.sub!('MESSAGE_URL', trigger.local_url_name)
      xml.sub!('RESPONSE', resource_response)
      xml.sub!('ACKNOWLEDGMENT', resource_ack)
      Nokogiri::XML(xml,&:noblanks).to_s
    end
    
    def resource_description_content
       if description_content && description_content.strip[0]
         xml = HL7.get_instance_template(:common, 'description').sub('VALUE', description_content)
         Nokogiri::XML(xml,&:noblanks).root.to_s
       else
         ''
       end
    end
    
    def resource_response
       if response
         xml = HL7.get_instance_template(:event, 'response').sub('MESSAGE_URL', response.local_url_name)
         Nokogiri::XML(xml,&:noblanks).root.to_s
       else
         ''
       end
    end
    
    def resource_ack
       if ack
         xml = HL7.get_instance_template(:event, 'acknowledgment').sub('MESSAGE_URL', ack.local_url_name)
         Nokogiri::XML(xml,&:noblanks).root.to_s
       else
         ''
       end
    end
  end
end # module HL7
