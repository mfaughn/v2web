module FHIR2Obj
  module_function
  def registry
    @registry
  end
  
  def clear_registry
    @registry = {:data_types => {}, :data_elements => {}, :segment_defs => {}, :message_structures => {}, :message_defs => {}, :acks => {}, :events => {}, :compositions => {}}
  end
  
  def get_data_type(url)
    @registry.dig(:data_types, url, :obj)
  end
  
  def get_data_element(url)
    @registry.dig(:data_elements, url, :obj)
  end
  
  def get_segement_definition(url)
    @registry.dig(:segment_defs, url, :obj)
  end
  
  def get_message_structure(url)
    @registry.dig(:message_structures, url, :obj)
  end
  
  def get_message_definition(url)
    @registry.dig(:message_defs, url, :obj)
  end
  
  def get_ack(url)
    @registry.dig(:acks, url, :obj)
  end
  
  def reconstitute_from_xml
    clear_registry
    inputs = [[:data_types, data_type_xmls], [:data_elements, data_element_xmls], [:segment_defs, segment_def_xmls], [:message_structures, message_structure_xmls], [:message_defs, message_xmls], [:acks => ac_xmls]] # , [:events => event_xmls], [:compositions, composition_xmls]]
    inputs.each { |type, paths| puts type.to_s; _reconstitute_elements(type, paths) }
  end
  
  def _reconstitute_elements(type, paths)
    paths.each do |path|
      # puts path
      f = File.open(path)
      begin
        xml = XmlSimple.xml_in(f)
      rescue
        puts "#{path} failed"
        raise
      end
      f.close
      registry[type][xml['url'].first['value']] = {:xml => xml, :file => path}
    end
    registry[type].each_key do |url|
      pp data unless url.to_s.strip[0]
      _reconstitute_element(type, url)
    end
  end
  
  def _reconstitute_element(type, url)
    data = registry[type][url]
    puts registry[type].keys.sort unless data
    obj_type = case type
               when :data_types
                 DataType
               when :data_elements
                 DataElement
               when :segment_defs
                 SegmentDefinition
               when :message_structures
                 MessageStructure
               when :message_defs
                 MessageDefinition
               when :acks
                 AcknowledgmentChoreography
               when :events
                 Event
               when :compositions
                 Composition
               else
                 raise
               end
    obj_type.new(data[:xml])
  end

end
