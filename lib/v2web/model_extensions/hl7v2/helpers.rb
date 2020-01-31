module HL7
  module_function
  
  def get_instance_template(kind, template)
    dir = '../../sd_instance_templates'
    dir = dir + case kind
          when :data_element
            '/data_element'
          when :data_type
            '/data_type'
          when :segment_def
            '/segment_def'
          else
            raise
          end
    file = File.join(__dir__, dir, template.to_s + '.xml')
    File.read(file)
  end
  
  def write_datatypes(output_dir = nil)
    output_dir ||= File.expand_path('~/projects/v2web/fhir_output/data_types')
    FileUtils.mkdir_p(output_dir)
    DataType.all do |dt|
      path = File.join(output_dir, dt.local_url_name + '.xml')
      File.open(path, 'w') { |f| f.puts dt.to_resource }
    end
  end
  
  def write_data_elements(output_dir = nil)
    output_dir ||= File.expand_path('~/projects/v2web/fhir_output/data_elements')
    FileUtils.mkdir_p(output_dir)
    DataElement.all do |de|
      path = File.join(output_dir, de.local_url_name + '.xml')
      File.open(path, 'w') { |f| f.puts de.to_resource }
    end
  end
  
  def write_segments(output_dir = nil)
    output_dir ||= File.expand_path('~/projects/v2web/fhir_output/segments')
    FileUtils.mkdir_p(output_dir)
    SegmentDefinition.all do |seg|
      path = File.join(output_dir, seg.local_url_name + '.xml')
      File.open(path, 'w') { |f| f.puts seg.to_resource }
    end
  end
  
  def write_messages(output_dir = nil)
    output_dir ||= File.expand_path('~/projects/v2web/fhir_output/messages')
    FileUtils.mkdir_p(output_dir)
    DataType.all do |msg|
      path = File.join(output_dir, msg.local_url_name + '.xml')
      File.open(path, 'w') { |f| f.puts msg.to_resource }
    end
  end
end
