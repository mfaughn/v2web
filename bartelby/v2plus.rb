require_relative 'v2plus_toc'
require_relative 'vocab_names'
module V2Plus
  module_function
  def build_site
    home_page
    # history
    # license
    # dt_toc
    # seg_toc
    # msg_struct_toc
    # domains_toc
    llp
    # V2Plus::DataType.all { |e| e.to_web_pub }
    # V2Plus::DataElement.all { |e| e.to_web_pub }
    # V2Plus::SegmentDefinition.all { |e| e.to_web_pub }
    # V2Plus::MessageStructure.all { |e| e.to_web_pub }
    # # V2Plus::Composition.all { |e| puts e.title; next unless e.title =~ /hl7 over/i; e.to_web_pub }
    # V2Plus::Composition.all { |e| e.to_web_pub }
    
    copy_demo_files
  end
  
  def copy_demo_files
    FileUtils.rm_r(web_output_dir)
    FileUtils.cp_r(demo_output_dir, web_output_dir)
  end

  def web_output_dir
    File.expand_path('~/projects/v2plus/views')
  end
  def demo_output_dir
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
  
  def history
    locals = {
      :prior_v2_versions => prior_versions
    }
    page = render_with_locals(:v2plus, :history, locals)
    save_web_file('history.html', page) 
  end
  
  def prior_versions
    {
      '2.2'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=139',
      '2.3'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=140',
      '2.3.1' => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=141',
      '2.4'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=142',
      '2.5'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=143',
      '2.5.1' => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=144',
      '2.6'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=145',
      '2.7'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=146',
      '2.7.1' => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=277',
      '2.8'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=356',
      '2.8.1' => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=365',
      '2.8.2' => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=403',
      '2.9'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=516'
    }
  end
  
  def license
    locals = {}
    page = render_with_locals(:v2plus, :license, locals)
    save_web_file('license.html', page) 
  end
  
  # for debugging
  def raw_html(type, name)
    # locals[:draft] = @@draft ? true : false
    read_web_template(type,name)
  end
  
  def save_web_file(url, content)
    page = render_v2plus_page(content)
    path = File.join(demo_output_dir, url)
    FileUtils.mkdir_p(File.dirname(path))
    File.open(path, 'w+') {|f| f.puts page }
  end
  
  def render_v2plus_page(content)
    locals = {
      :content      => content,
      :navbar_items => navbar_items,
      :draft        => true
    }
    render_with_locals(:v2plus, :main_layout, locals)
  end
  
  def navbar_items
    {
      'Home'               => '/index.html',
      'Domains'            => '/domains.html',
      'Message Structures' => '/message-structures.html',
      'Segments'           => '/segment-definitions.html',
      'Data Types'         => '/data-types.html',
      'Data Type Flavors'  => '',
      'Vocabulary'         => 'https://www.hl7.org/fhir/terminologies-valuesets.html#tabs-v2',
      'Control'            => '/composition/control.html',
      'Conformance'        => 'http://v2.hl7.org/conformance/',
      'Encoding'           => '/composition/control.html#Control-12',
      'Transport'          => '/transport.html',
      'v2.x'               => '/history.html'  
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
      :intro          => '/composition/Introduction.html',
      :foundation     => '',
      :ams            => 'http://www.hl7.eu/refactored/downloads.html',
      :encoding_rules => 'http://www.hl7.eu/refactored/encoding01er7.html',
      # :xml_encoding   => 'http://www.hl7.eu/refactored/encoding02xml.html',
      :xml_encoding   => '/xml-encoding-rules.html',
      :transport      => 'http://www.hl7.eu/refactored/transport.html',
      # :hllp           => 'http://www.hl7.eu/refactored/transport01hllp.html',
      # :mllp           => 'http://www.hl7.eu/refactored/transport01hllp.html',
      # :http           => 'http://www.hl7.eu/refactored/transport02http.html',
      :hllp           => '/lower-layer-protocol.html',
      :mllp           => '/lower-layer-protocol.html',
      :http           => '/hl7-over-http.html',
      :terminology    => 'https://www.hl7.org/fhir/terminologies-valuesets.html#tabs-v2',
      :code_system    => 'https://www.hl7.org/fhir/terminologies-systems.html#tabs-v2',
      :claims         => '/composition/Claims-and-Reimbursement.html',
      :mandm          => '/composition/Materials-Management.html',
      :personnel      => '/composition/Personnel-Management.html',
      :p_care         => '/composition/Patient-Care.html',
      :app_mgmt       => '/composition/Application-Management.html',
      :order_entry1   => '/composition/Order-Entry-General-Laboratory-Dietary-Supply-Blood-Transfusion.html',
      :control        => '/composition/Control.html',
      :lab_auto       => '/composition/Clinical-Laboratory-Automation.html',
      :obr            => '/composition/Observation-Reporting.html',
      :master         => '/composition/Master-Files.html',
      :p_admin        => '/composition/Patient-Administration.html',
      :order_entry2   => '/composition/Order-Entry-Pharmacy-Treatment-Vaccination.html',
      :billing        => '/composition/Financial-Management.html',
      :data_type      => '/composition/Data-Type.html',
      :p_referral     => '/composition/Patient-Referral.html',
      :queries        => '/composition/Query.html',
      :records        => '/composition/Medical-Records-Information-Management-Document-Management-.html',
      :scheduling     => '/composition/Scheduling.html',
      :admin          => '/domains.html',
      :patient        => '/domains.html',
      :financial      => '/domains.html',
      :clinical       => '/domains.html',
      :medical        => '/domains.html',
      :dt_flavors     => '/',
      :ig_registry    => '/'
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
  
  def llp
    path = File.expand_path(File.join(__dir__, '../test_data/v2plus_extras/llp_inner.html'))
    save_web_file('lower-layer-protocol.html', File.read(path))
  end
  
  def xsd_dir
    File.expand_path(File.join(__dir__, '../test_data/v2plus_extras/v2xsd'))
  end
end
