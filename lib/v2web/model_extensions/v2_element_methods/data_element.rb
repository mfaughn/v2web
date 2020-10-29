module DataElementMethods
  def local_url_name
    # name.downcase.gsub(/[^A-Za-z\d]/, '-') + item_number.to_s.rjust(5,'0')
    item_number.to_s.rjust(5,'0')
  end
  
  def field_info
    fields.map(&:info).uniq.join('; ')
  end
  
  def url_name
    'http://v2.hl7.org/fhir/DataElementDefinition/' + local_url_name
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
    xml.sub!('DATA_TYPE', resource_data_type)
    Nokogiri::XML(xml,&:noblanks).to_s
  end

  def resource_data_type
    if data_type
      begin
        HL7.get_instance_template(:data_element, 'data_type').sub!('VALUE', data_type.local_url_name)
      rescue
        puts Rainbow("Unable to create resource for data element (db id #{id}) because it has a bad data type.\n#{item_number} - #{name} found at sequence ##{field.sequence_number} of #{field.segment_definition.code} - #{field.segment_definition.name} in Chapter #{field.segment_definition.origin}\n").red
        # FIXME see 5.5.4 for DT value of 'varies'
        # puts item_number.to_s + name.downcase.gsub(/[^A-Za-z\d]/, '-')
        # puts field.segment_definition.name
        # puts field.segment_definition.code
        # puts field.segment_definition.origin
      end
    elsif fields.all? { |f| f.optionality&.value == 'W' }
      ''
    else
      puts name
      puts item_number.to_s
      puts fields.map { |f| sd = f.segment_definition; "#{sd.name} #{sd.origin}" }.uniq.to_s
      puts
      HL7.get_instance_template(:data_element, 'data_type').sub!('VALUE', 'FIXME!')
    end
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
