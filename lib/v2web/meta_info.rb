# must not have the word m-o-d-u-l-e above the next line (so that a Regexp can figure out the m-o-d-u-l-e name)
require 'Foundation/conventions'
module V2Web
  
  # For more information about meta_info.rb, please see project MM, lib/mm/meta_info.rb

  # Required
  GEM_NAME = 'v2web'
  VERSION  = '0.0.0'
  SUMMARY  = 'Companion project for v2_web_generated.'
  AUTHORS  = ['Michael Faughn']
  EMAILS   = ['m.faughn@prometheuscomputing.com']
  LANGUAGE = :ruby
  LANGUAGE_VERSION = ['>= 2.3']
  RUNTIME_VERSIONS = {
    :mri => ['>= 2.3', '< 3'],
  }
  
  LAUNCHER = 'v2web_start_gui_server'
  
  DEPENDENCIES_RUBY = {
    :v2_web_generated => '~> 0.0', 
    :gui_site => '~> 7.0'#, 
  }
  DEVELOPMENT_DEPENDENCIES_RUBY  = { } 

  # An Array of strings that YARD will interpret as regular expressions of files to be excluded.
  YARD_EXCLUDE = []
    
  # ==========================================================
  # Additional meta-information for apps
  extend App_MetaInfo_Behaviors
    
  DEFAULT_APP_OPTIONS = {
    :spec_name        => 'v2_web_generated.rb',
    :spec_module      => 'V2WebGenerated',
    :spec_title       => 'V2 Web Editor',
    
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
    :favicon                      => '/images/hl7.ico',
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
