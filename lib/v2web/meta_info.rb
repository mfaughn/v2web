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
    :spec_title       => 'V2 Web'
  }
  
end
