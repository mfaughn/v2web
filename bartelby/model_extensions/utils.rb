# FIXME don't use any of this anymore
module FHIR2Obj
  module_function
  
  def output_dir
    File.expand_path(File.join(__dir__, '../../../fhir_output'))
  end
  
  def _fhir_resources_dir(dir_name)
    dir = File.join(output_dir, dir_name)
    Dir[File.join(dir, '*.xml')]
  end
  
  def ac_xmls
    _fhir_resources_dir('acknowledgment_choreographies')
  end
  
  def data_element_xmls
    _fhir_resources_dir('data_elements')
  end
  
  def segment_def_xmls
    _fhir_resources_dir('segments')
  end
  
  def data_type_xmls
    _fhir_resources_dir('data_types')
  end
  
  def message_structure_xmls
    _fhir_resources_dir('message_structures')
  end
  
  def message_xmls
    _fhir_resources_dir('messages')
  end

  def event_xmls
    _fhir_resources_dir('events')
  end

  def composition_xmls
    _fhir_resources_dir('compositions')
  end
  
end
