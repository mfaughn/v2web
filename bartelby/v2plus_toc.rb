module V2Plus
  module_function
  def dt_list
    V2Plus::DataType.all.sort_by { |dt| dt.code }.map { |dt| render_with_locals(:datatype, :toc_entry, {:dt => dt}) }
  end
  
  def seg_list
    V2Plus::SegmentDefinition.all.sort_by { |seg| seg.code }.map { |seg| render_with_locals(:segment_definition, :toc_entry, {:seg => seg}) }
  end
  
  def ms_list
    V2Plus::MessageStructure.all.sort_by { |ms| ms.code }.map { |ms| render_with_locals(:message_structure, :toc_entry, {:ms => ms}) }
  end
  
  def domains_list
    comps = V2Plus::Composition.all
    ordered_comps = []
    domain_names.each { |ttl, entry| ordered_comps << [comps.find { |comp| comp.title == ttl }.local_url_name, entry] }
    ordered_comps.map { |url, entry| render_with_locals(:composition, :toc_entry, {:url => url, :entry => entry}) }
  end
  
  def dt_toc
    locals = {
      :rows => dt_list
    }
    content = render_with_locals(:datatype, :toc, locals)
    save_web_file('data-types.html', content)
  end
  
  def seg_toc
    locals = {
      :rows => seg_list
    }
    content = render_with_locals(:segment_definition, :toc, locals)
    save_web_file('segment-definitions.html', content)
  end
  
  def msg_struct_toc
    locals = {
      :rows => ms_list
    }
    content = render_with_locals(:message_structure, :toc, locals)
    save_web_file('message-structures.html', content)
  end
  
  def domains_toc
    locals = {
      :rows => domains_list
    }
    content = render_with_locals(:composition, :toc, locals)
    save_web_file('domains.html', content)
  end
  
  def domain_names
    domain_names = {
    'Patient Administration'  => 'ADT - Admission, Discharge, Transfer',
    'Financial Management'  => 'Financial Management',
    'Order Entry: General, Laboratory, Dietary, Supply, Blood Transfusion'  => 'Order Entry: General, Laboratory, Dietary, Supply,',
    'Order Entry: Pharmacy/Treatment, Vaccination' => 'Order Entry: Pharmacy/Treatment, Vaccination',
    'Query'  => 'Query',
    'Observation Reporting'  => 'Observation Reporting',
    'Master Files'  => 'Master Files',
    'Medical Records/Information Management (Document Management)'  => 'Medical Records/Information Management (Document',
    'Scheduling'  => 'Scheduling',
    'Patient Referral'  => 'Patient Referral',
    'Patient Care'  => 'Patient Care',
    'Clinical Laboratory Automation'  => 'Clinical Laboratory Automation',
    'Application Management'  => 'Application Management',
    'Personnel Management'  => 'Personnel Management',
    'Claims and Reimbursement'  => 'Claims and Reimbursement',
    'Materials Management'  => 'Materials Management'
    }
  end
end
