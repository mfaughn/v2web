module V2Web
      
  DEFAULT_APP_OPTIONS = {
    :log_dir          => File.expand_path('../../log', __dir__),
    :developer_email  => 'michael.faughn@nist.gov',
    :admin_email      => 'michael.faughn@nist.gov',
    
    :port             => 7000,
    # :puma_ctl_port    => 9295,
    :spec_name        => 'v2_web_generated.rb',
    :spec_module      => 'V2WebGenerated',
    :spec_title       => 'V2+ Web Editor',
    
    :mode             => :dev,
    # :default_text_language  => :Markdown,
    # :spec_title       => 'HL7 v2+ Document Manager Prototype',
    :clear_view_selection_page    => false,
    :tree_view                    => {:enabled => true, :show_roles => false, :no_open_all => true},
    # :custom_page_root             => relative('pages'),
    :login_or_register_blurb_path => File.join(File.expand_path(File.dirname(__FILE__)), "pages/view/blurb.haml"),
    :license_agreement_path       => File.join(File.expand_path(File.dirname(__FILE__)), "pages/view/agreement.haml"),
    # :text_languages               => ['Markdown', 'HTML'],
    :show_text_languages          => true,
    :default_text_language        => :Plain,
    :text_always_collapsed        => true,
    # :custom_home_page             => {:url => '/hl7v2/prototype', :name => 'Documents'},
    :load_all_controllers         => true,
    :show_advanced_view           => false,
    :policy_active                => false,
    :favicon                      => '/images/new_v2.ico',
    :custom_page_root             => File.join(File.expand_path(__dir__), "pages"),
    :layout                       => 'v2_layout',
    :csrf_protection              => false,
    # :custom_pages => {
    #   # :proto => {
    #   #   :name => "Document Components",
    #   #   :url => "/hl7v2/components",
    #   #   :show_in_nav_bar => true
    #   # },
    #   :proto => {
    #     :name => "Generate Documents",
    #     :url => "hl7v2/prototype",
    #     :show_in_nav_bar => true
    :nothing => nil
  }
  
end
  