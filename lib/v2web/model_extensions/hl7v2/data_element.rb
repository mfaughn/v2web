module HL7
  class DataElement
    def local_url_name
      # name.downcase.gsub(/[^A-Za-z\d]/, '-') + item_number.to_s.rjust(5,'0')
      item_number.to_s.rjust(5,'0')
    end
    
    def to_resource
      xml = HL7.get_instance_template(:data_element, 'base')
      xml.sub!('URL', local_url_name)
      [:name, :item_number].each do |property|
        xml.gsub!(property.to_s.upcase, send(property).to_s)
      end
      xml.sub!('DESCRIPTION', resource_description_content)
      xml.sub!('MAY_TRUNCATE', may_truncate.value.to_s)
      xml.sub!('MIN_LENGTH', resource_min_length)
      xml.sub!('MAX_LENGTH', resource_max_length)
      xml.sub!('CONF_LENGTH', resource_conf_length)
      if data_type
        begin
          xml.sub!('DATA_TYPE', data_type.local_url_name)
        rescue
          puts Rainbow("Unable to create resource for data element (db id #{id}) because it has a bad data type.\n#{item_number} - #{name} found at sequence ##{field.sequence_number} of #{field.segment_definition.code} - #{field.segment_definition.name} in Chapter #{field.segment_definition.origin}\n").red
          # FIXME see 5.5.4 for DT value of 'varies'
          # puts item_number.to_s + name.downcase.gsub(/[^A-Za-z\d]/, '-')
          # puts field.segment_definition.name
          # puts field.segment_definition.code
          # puts field.segment_definition.origin
        end
      else
        xml.sub!('DATA_TYPE', 'FIXME!')
      end
      Nokogiri::XML(xml,&:noblanks).to_s
    end
    
    def resource_min_length
      min_length ? HL7.get_instance_template(:common, 'min_length').sub('VALUE', min_length.to_s) : ''
    end
    def resource_max_length
      max_length ? HL7.get_instance_template(:common, 'max_length').sub('VALUE', max_length.to_s) : ''
    end
    def resource_conf_length
      c_length ? HL7.get_instance_template(:common, 'conf_length').sub('VALUE', c_length) : ''
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
