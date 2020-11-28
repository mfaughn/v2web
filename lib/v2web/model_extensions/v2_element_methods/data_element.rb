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
    xml.sub!('NAME', name)
    xml.sub!('ITEM_NUMBER', item_number.to_s)
    xml.sub!('DESCRIPTION', resource_definition_content)
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
  
  def resource_definition_content
    return '' unless definitions_count > 0
    content = []
    if definitions_count > 1
      definitions.each do |defn|
        seg_code, seq_num = defn.original_container.split('.').map(&:strip)
        link = "segment-definition-#{seg_code}.html##{seg_code}-#{seq_num}" # this isn't exactly DRY with Field#local_html_id
        content << "<p class='data-element-definition-marker'><strong>(Definition from <a href='#{link}'>#{defn.original_container}</a> in Ch. #{defn.chapter})</strong></p>" + defn.definition_content
      end
    else
      content << definitions.first.definition_content
    end
    return '' if content.empty?
    HL7.get_instance_template(:common, 'description').sub('VALUE', content.join("\n"))
  end
end
