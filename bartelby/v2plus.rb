require_relative 'v2plus_toc'
module V2Plus
  module_function
  def build_site
    home_page
    # dt_toc
    # seg_toc
    # msg_struct_toc
    domains_toc
    # V2Plus::DataType.all { |e| e.to_web_pub }
    # V2Plus::SegmentDefinition.all { |e| e.to_web_pub }
    # V2Plus::MessageStructure.all { |e| e.to_web_pub }
    # V2Plus::Composition.all { |e| e.to_web_pub }
  end

  def web_output_dir
    File.expand_path('~/projects/v2demo/views')
  end
  def web_templates
    File.expand_path('~/projects/v2web/a_v2templates')
  end
  def get_web_template(type,name)
    File.expand_path(File.join(web_templates, type.to_s, name.to_s + '.haml'))
  end
  def read_web_template(type,name)
    File.read(get_web_template(type,name))
  end
  def render_with_locals(type, name, locals)
    # locals[:draft] = @@draft ? true : false
    engine = Haml::Engine.new(read_web_template(type,name))
    output = engine.render(Object.new, locals)
  end
  
  # for debugging
  def raw_html(type, name)
    # locals[:draft] = @@draft ? true : false
    read_web_template(type,name)
  end
  
  def save_web_file(url, content)
    page = render_v2plus_page(content)
    File.open(File.join(web_output_dir, url), 'w+') {|f| f.puts page }
  end
  def render_v2plus_page(content)
    locals = {
      :content      => content,
      :navbar_items => navbar_items,
      :draft        => true
    }
    render_with_locals(:v2plus, :main, locals)
  end
  
  def navbar_items
    {
      'Home'               => 'index.html',
      'Domains'            => 'domains.html',
      'Message Structures' => 'message-structures.html',
      'Segments'           => 'segment-definitions.html',
      'Data Types'         => 'data-types.html',
      'Data Type Flavors'  => 'dt_flav.html',
      'Vocabulary'         => 'https://www.hl7.org/fhir/terminologies-valuesets.html#tabs-v2',
      'Control'            => 'chapter-control.html',
      'Conformance'        => 'http://v2.hl7.org/conformance/',
      'Encoding'           => 'chapter-control.html#Control-12',
      'Transport'          => 'transport.html',
      'v2.x'               => 'v2x.html'  
    }   
  end
  
  def conformance_chapter_links
    ccl = {
      'Introduction.html' => 'Introduction',
      'Profile-Levels.html' => 'Profile Levels',
      'HL7-v2-Implementation-Guides.html' => 'HL7 v2 Implementation Guides',
      'Message-Profiles.html' => 'Message Profiles',
      'Constraints.html' => 'Constraints',
      'Vocabulary-Constraints.html' => 'Vocabulary Constraints',
      'Profile-Construction.html' => 'Profile Construction',
      'Pairing-Sender-and-Receiver-Profile-for-Use-.html' => 'Pairing Sender and Receiver Profile for Use ',
      'Profile-Documentation.html' => 'Profile Documentation',
      'Computable-Document-Definitions.html' => 'Computable Document Definitions',
      'Glossary.html' => 'Glossary',
      'Appendix-A-Predicate-Definition-Language.html' => 'Appendix A: Predicate Definition Language',
      'Appendix-B-Conformance-Statement-Definition-Language.html' => 'Appendix B: Conformance Statement Definition Language'
    }
  end
  
  def home_page_links
    navbar_items.merge({
      :linked_data_module => '',
      :toc            => '', #'toc.html',
      :intro          => 'chapter-Introduction.html',
      :foundation     => '',
      :ams            => 'http://www.hl7.eu/refactored/downloads.html',
      :encoding_rules => 'http://www.hl7.eu/refactored/encoding01er7.html',
      :xml_encoding   => 'http://www.hl7.eu/refactored/encoding02xml.html',
      :transport      => 'http://www.hl7.eu/refactored/transport.html',
      :hllp           => 'http://www.hl7.eu/refactored/transport01hllp.html',
      :mllp           => 'http://www.hl7.eu/refactored/transport01hllp.html',
      :http           => 'http://www.hl7.eu/refactored/transport02http.html',
      :terminology    => 'https://www.hl7.org/fhir/terminologies-valuesets.html#tabs-v2',
      :code_system    => 'https://www.hl7.org/fhir/terminologies-systems.html#tabs-v2',
      :claims         => 'chapter-Claims-and-Reimbursement.html',
      :mandm          => 'chapter-Materials-Management.html',
      :personnel      => 'chapter-Personnel-Management.html',
      :p_care         => 'chapter-Patient-Care.html',
      :app_mgmt       => 'chapter-Application-Management.html',
      :order_entry1   => 'chapter-Order-Entry-General-Laboratory-Dietary-Supply-Blood-Transfusion.html',
      :control        => 'chapter-Control.html',
      :lab_auto       => 'chapter-Clinical-Laboratory-Automation.html',
      :obr            => 'chapter-Observation-Reporting.html',
      :master         => 'chapter-Master-Files.html',
      :p_admin        => 'chapter-Patient-Administration.html',
      :order_entry2   => 'chapter-Order-Entry-Pharmacy-Treatment-Vaccination.html',
      :billing        => 'chapter-Financial-Management.html',
      :data_type      => 'chapter-Data-Type.html',
      :p_referral     => 'chapter-Patient-Referral.html',
      :query          => 'chapter-Query.html',
      :records        => 'chapter-Medical-Records-Information-Management-Document-Management-.html',
      :scheduling     => 'chapter-Scheduling.html',
      :admin          => 'domains.html',
      :patient        => 'domains.html',
      :financial      => 'domains.html',
      :clinical       => 'domains.html',
      :medical        => 'domains.html',
      :dt_flavors     => '',
      :ig_registry    => ''
    })
  end
  
  def home_page
    locals = {
      :conformance_chapter_links => conformance_chapter_links,
      :links => home_page_links
    }
    content = render_with_locals(:v2plus, :homepage, locals)
    save_web_file('index.html', content) 
  end
end
