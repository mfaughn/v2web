module HL7
  class Component
    def to_resource
      xml = HL7.get_instance_template(:data_type, 'component')
      [:name, :sequence_number].each do |property|
        xml.sub!(property.to_s.upcase, send(property).to_s)
      end
      xml.sub!('MAY_TRUNCATE', may_truncate&.value.to_s)
      xml.sub!('DEFINITION', resource_definition_content)
      xml.sub!('MUST_SUPPORT', resource_must_support)
      xml.sub!('MIN_LENGTH', resource_min_length)
      xml.sub!('MAX_LENGTH', resource_max_length)
      xml.sub!('CONF_LENGTH', resource_conf_length)
      xml.sub!('COMMENTS', resource_comments)
      xml.sub!('USAGE_NOTES', resource_usage_notes)
      xml.sub!('REQUIREMENTS', resource_requirements)
      xml.sub!('BINDING', resource_binding)
      xml.sub!('DATA_TYPE', resource_data_type)
      Nokogiri::XML(xml) { |config| config.strict.noblanks }.root.to_s
    end
    
    def resource_definition_content
       if definition_content && definition_content[0]
         HL7.get_instance_template(:data_type, 'definition').sub('VALUE', definition_content)
       else
         ''
       end
    end
    def resource_data_type
      if type
        HL7.get_instance_template(:data_type, 'component_data_type').sub('VALUE', type.local_url_name)
      elsif optionality&.value == 'W'
        ''
      elsif owner.components_count == 1
        # This component information constrains what is otherwise a primitive datatype.  This is kinda hinky but the HL7 folks apparently wanted it like this (instead of being reasonable and defining primitive data types....)
        HL7.get_instance_template(:data_type, 'component_data_type').sub('VALUE', owner.local_url_name)
      else
        HL7.get_instance_template(:data_type, 'component_data_type').sub!('VALUE', 'FIXME!')
      end
    end
    
    def resource_must_support
       must_support == nil ? '' : HL7.get_instance_template(:data_type, 'must_support').sub('VALUE', must_support.to_s)
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
    def resource_comments
      return '' if comments.empty?
      output = comments.each do |c|
        HL7.get_instance_template(:data_type, 'comments').sub('VALUE', c)
      end
      output.join
    end
    def resource_usage_notes
      return '' if usage_notes.empty?
      output = usage_notes.each do |c|
        HL7.get_instance_template(:data_type, 'usage_notes').sub('VALUE', c)
      end
      output.join
    end
    def resource_requirements
      return '' if requirements.empty?
      output = requirements.each do |c|
        HL7.get_instance_template(:data_type, 'requirements').sub('VALUE', c)
      end
      output.join
    end
    def resource_binding
      table ? HL7.get_instance_template(:data_type, 'binding').sub('VALUE', table.fhir_url) : ''
    end
  end # Class Component
end # module HL7
