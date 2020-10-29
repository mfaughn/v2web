module HL7
  module_function

  def write_fhir(output_dir = nil)
    if output_dir
      # FIXME
    else
      write_datatypes
      write_data_elements
      write_segments
      write_structures
      write_messages
      write_acs
      write_events
    end
  end
  
  def get_instance_template(kind, template)
    dir = '../../sd_instance_templates'
    dir = dir + '/' + kind.to_s
          # case kind
          # when :data_element
          #   '/data_element'
          # when :data_type
          #   '/data_type'
          # when :segment_def
          #   '/segment_def'
          # when :message
          #   '/message'
          # when :event
          #   '/event'
          # when :acknowledgment_choreography
          #   '/acknowledgment_choreography'
          # else
          #   raise
          # end
    file = File.join(__dir__, dir, template.to_s + '.xml')
    File.read(file)
  end
  
  def write_datatypes(output_dir = nil)
    output_dir ||= File.expand_path('~/projects/v2web/fhir_output/data_types')
    FileUtils.mkdir_p(output_dir)
    DataType.all do |dt|
      path = File.join(output_dir)
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
    msgs = Message.all
    # msgs = [Message.where(code:'ADT').first]
    msgs.each do |msg|
      path = File.join(output_dir, msg.local_url_name + '.xml')
      File.open(path, 'w') { |f| f.puts msg.to_resource }
    end
  end
  
  def fsh(output_dir = nil)
    output_dir ||= File.expand_path('~/projects/v2web/fsh')
    FileUtils.mkdir_p(output_dir)
    
    # path = File.join(output_dir, 'messages.fsh')
    # f = File.open(path, 'w')
    # msgs = Message.all
    # msgs.each do |msg|
    #   f.puts msg.to_fsh
    # end
    # f.close

    path = File.join(output_dir, 'message_structures.fsh')
    f = File.open(path, 'w')
    mss = MessageStructure.all
    mss.each do |ms|
      f.puts ms.to_fsh
      f.puts "\n"
    end
    f.close
  end
  
  def write_structures(output_dir = nil)
    output_dir ||= File.expand_path('~/projects/v2web/fhir_output/message_structures')
    FileUtils.mkdir_p(output_dir)
    ms = MessageStructure.all
    ms.each do |m|
      path = File.join(output_dir, m.local_url_name + '.xml')
      File.open(path, 'w') { |f| f.puts m.to_resource }
    end
  end
  
  def write_events(output_dir = nil)
    output_dir ||= File.expand_path('~/projects/v2web/fhir_output/events')
    FileUtils.mkdir_p(output_dir)
    Event.all do |ev|
      path = File.join(output_dir, ev.local_url_name + '.xml')
      File.open(path, 'w') { |f| f.puts ev.to_resource }
    end
  end
  
  def write_acs(output_dir = nil)
    output_dir ||= File.expand_path('~/projects/v2web/fhir_output/acknowledgment_choreographies')
    FileUtils.mkdir_p(output_dir)
    AcknowledgmentChoreography.all do |ac|
      path = File.join(output_dir, ac.local_url_name + '.xml')
      File.open(path, 'w') { |f| f.puts ac.to_resource }
    end
  end
end
