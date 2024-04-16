require_relative 'v2plus_toc'
require_relative 'vocab_names'
module V2Pub
  module_function
  def build_site(demo = false)
    @demo = demo
    # map_v2
    # home_page
    # toc
    # history
    # license
    # dt_toc
    # seg_toc
    # msg_struct_toc
    # domains_toc
    # vocab_toc
    # llp
    # hl7_over_html
    # xml_encoding_rules
    # Vocab::CodeSystem.all { |e| e.to_web_pub }
    # HL7::V2::DataType.all { |e| e.to_web_pub }
    # HL7::V2::DataElement.all { |e| e.to_web_pub } # FIXME I'm borked
    HL7::V2::SegmentDefinition.all { |e| e.to_web_pub }
return
    HL7::V2::MessageStructure.all { |e| e.to_web_pub }
    # # FHIR::Composition.all { |e| puts e.title; next unless e.title =~ /hl7 over/i; e.to_web_pub }
    V2Web::Domain.reset_process
    V2Web::Domain.all { |e| e.to_web_pub }
    
    # copy_demo_files
  end
  
  def domains
    V2Web::SectionRenderingType.where(value:'v2+ domain').first.sections_with_render_as
    # V2Web::Standard.all.select { |d| d.render_as&.value == 'v2+ domain' }
  end
  
  def copy_demo_files
    # FileUtils.rm_r(web_output_dir)
    # FileUtils.cp_r(demo_output_dir, web_output_dir)
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
    locals[:demo]       = @demo
    locals[:production] = !@demo
    locals[:demo_output_dir] = demo_output_dir
    locals[:production_url]  = 'FIXME'
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
      '2.9'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=516',
      '2.8.2' => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=403',
      '2.8.1' => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=365',
      '2.8'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=356',
      '2.7.1' => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=277',
      '2.7'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=146',
      '2.6'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=145',
      '2.5.1' => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=144',
      '2.5'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=143',
      '2.4'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=142',
      '2.3.1' => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=141',
      '2.3'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=140',
      '2.2'   => 'https://www.hl7.org/implement/standards/product_brief.cfm?product_id=139'

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
  
  def save_web_file(url, content, opts = {})
    page = render_v2plus_page(content, opts)
    path = File.join(demo_output_dir, url)
    FileUtils.mkdir_p(File.dirname(path))
    File.open(path, 'w+') {|f| f.puts page }
  end
  
  def render_v2plus_page(content, opts = {})
    locals = {
      :head_extras  => opts[:head_extras],
      :content      => content,
      :navbar_items => navbar_items,
      :draft        => true
    }
    render_with_locals(:v2plus, :main_layout, locals)
  end
  
  def navbar_items
    {
      'Home'               => 'index.html',
      'Domains'            => 'domains.html',
      'Message Structures' => 'message-structures.html',
      'Segments'           => 'segment-definitions.html',
      'Data Types'         => 'data-types.html',
      'Data Type Flavors'  => '',
      'Vocabulary'         => 'vocab.html',
      'Control'            => 'domain/Control.html',
      'Conformance'        => 'http://v2.hl7.org/conformance/',
      'Encoding'           => 'domain/Control.html#Control-12',
      'Transport'          => '#transport', #'/transport.html',
      'v2.x'               => 'history.html'  
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
      :toc            => 'toc.html',
      :intro          => 'domain/Introduction.html',
      :foundation     => '',
      :ams            => 'domain/Control.html#Control-5',
      :encoding_rules => 'domain/Control.html#Control-6',
      # :xml_encoding   => 'http://www.hl7.eu/refactored/encoding02xml.html',
      :xml_encoding   => 'xml-encoding-rules.html',
      :transport      => '#transport',
      # :hllp           => 'http://www.hl7.eu/refactored/transport01hllp.html',
      # :mllp           => 'http://www.hl7.eu/refactored/transport01hllp.html',
      # :http           => 'http://www.hl7.eu/refactored/transport02http.html',
      :hllp           => 'lower-layer-protocol.html#Heading3',
      :mllp           => 'lower-layer-protocol.html#Heading45',
      :http           => 'hl7-over-http.html',
      :terminology    => 'https://www.hl7.org/fhir/terminologies-valuesets.html#tabs-v2',
      :code_system    => 'https://www.hl7.org/fhir/terminologies-systems.html#tabs-v2',
      :claims         => 'domain/Claims-and-Reimbursement.html',
      :mandm          => 'domain/Materials-Management.html',
      :personnel      => 'domain/Personnel-Management.html',
      :p_care         => 'domain/Patient-Care.html',
      :app_mgmt       => 'domain/Application-Management.html',
      :order_entry1   => 'domain/Order-Entry-General-Laboratory-Dietary-Supply-Blood-Transfusion.html',
      :control        => 'domain/Control.html',
      :lab_auto       => 'domain/Clinical-Laboratory-Automation.html',
      :obr            => 'domain/Observation-Reporting.html',
      :master         => 'domain/Master-Files.html',
      :p_admin        => 'domain/Patient-Administration.html',
      :order_entry2   => 'domain/Order-Entry-Pharmacy-Treatment-Vaccination.html',
      :billing        => 'domain/Financial-Management.html',
      :data_type      => 'domain/Data-Type.html',
      :p_referral     => 'domain/Patient-Referral.html',
      :queries        => 'domain/Query.html',
      :records        => 'domain/Medical-Records-Information-Management-Document-Management-.html',
      :scheduling     => 'domain/Scheduling.html',
      :admin          => 'domains.html',
      :patient        => 'domains.html',
      :financial      => 'domains.html',
      :clinical       => 'domains.html',
      :medical        => 'domains.html',
      :dt_flavors     => '/',
      :ig_registry    => '/'
    })
  end
  
  def home_page
    locals = {
      :notes_to_balloters => notes_to_balloters,
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
  
  def hl7_over_html
    path = File.expand_path(File.join(__dir__, '../test_data/v2plus_extras/hl7-over-http_inner.html'))
    he   = File.expand_path(File.join(__dir__, '../test_data/v2plus_extras/hl7-over-http_head.html'))
    save_web_file('hl7-over-http.html', File.read(path), :head_extras => File.read(he))
  end
  
  def xml_encoding_rules
    path = File.expand_path(File.join(__dir__, '../test_data/v2plus_extras/xml-encoding-rules_inner.html'))
    he   = File.expand_path(File.join(__dir__, '../test_data/v2plus_extras/xml-encoding-rules_head.html'))
    save_web_file('xml-encoding-rules.html', File.read(path), :head_extras => File.read(he))
  end
  
  def xsd_dir
    File.expand_path(File.join(__dir__, '../test_data/v2plus_extras/v2xsd'))
  end
  
  def notes_to_balloters
    locals = {}
    render_with_locals(:v2plus, :notes_to_balloters, locals)
  end
end
