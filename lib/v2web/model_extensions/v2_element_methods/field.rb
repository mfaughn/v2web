module FieldMethods
  def info
    "Ch #{segment_definition.origin}: #{segment_definition.code} field #{sequence_number}#{optionality&.value == 'W' ? ' WITHDRAWN' : ''}."
  end
  
  def to_resource
    xml = HL7.get_instance_template(:segment_def, 'field')
    [:sequence_number].each do |property|
      xml.sub!(property.to_s.upcase, send(property).to_s)
    end
    xml.sub!('MUST_SUPPORT', must_support.to_s)
    xml.sub!('FLAGS', resource_flags)
    xml.sub!('MIN_CARDINALITY', resource_min_cardinality)
    xml.sub!('MAX_CARDINALITY', resource_max_cardinality)
    if data_element
      xml.sub!('DATA_ELEMENT', data_element.local_url_name)
    else
      xml.sub!('DATA_ELEMENT', 'FIXME!')
    end
    Nokogiri::XML(xml) { |config| config.strict.noblanks }.root.to_s
  end

  def resource_min_cardinality
    min_cardinality ? HL7.get_instance_template(:segment_def, 'min_cardinality').sub('VALUE', min_cardinality.to_s) : ''
  end
  def resource_max_cardinality
    max_cardinality ? HL7.get_instance_template(:segment_def, 'max_cardinality').sub('VALUE', max_cardinality.to_s) : ''
  end
  def resource_flags
    ov = optionality&.value
    if ov && !(ov == 'R' || ov == 'O' || ov == '-')
      HL7.get_instance_template(:segment_def, 'flags').sub('VALUE', ov)
    else
      ''
    end
  end
  
end
