module V2Web
  # Required
  GEM_NAME = 'v2web'
  VERSION  = '0.0.0'
  SUMMARY  = 'Companion project for v2_web_generated.'
  AUTHORS  = ['Michael Faughn']
  HOMEPAGE = 'homeless' # FIXME
  
  # Optional Strings
  DESCRIPTION = "V2+ Manager, Editor, and Publisher"
  
  # Optional Strings OR Array of Strings
  EMAILS   = ['michael.faughn@nist.gov']
  
  LANGUAGE = :ruby
  
  LANGUAGE_VERSION = ['>= 2.7']
  
  RUNTIME_VERSIONS = {
    :mri => ['>= 2.7', '< 3'],
  }
    
  DEPENDENCIES_RUBY = {
    :v2_web_generated => '~> 3.0.0', 
    :gui_site => '~> 8.0'#, 
  }
  DEVELOPMENT_DEPENDENCIES_RUBY  = { } 
end
