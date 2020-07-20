Dir.glob(File.join(__dir__, '../lib/v2web/model_extensions', '**', '*.rb'), &method(:load))
require_relative 'make_gbp_file.rb'
require_relative 'snelick_helpers.rb'

V2Web.draft # comment out if this is not a draft

conformance = V2Web::Standard.where(Sequel.ilike(:title, '%Conformance Methodology%')).last
# conformance = V2Web::Standard.where(Sequel.ilike(:title, '%test%')).last
config_file = File.expand_path(File.join(__dir__, '../config/v2conformance_config.xml'))
config_dir = File.expand_path(File.join(__dir__, '../config/v2conformance'))
tab_files = {}
Dir["#{config_dir}/**/*"].select { |f| File.file?(f) }.each { |f| tab_files[f.split('/').last] = f }
# pp tab_files.keys.sort
puts 
# pp tab_files.values.sort
conformance.configure_site(config_file, tab_files)
indicate_page_linkages(conformance)
conformance.to_hl7_site

# datatypes   = V2Web::Standard.where(Sequel.ilike(:title, '%DataType Specializations%')).last
# indicate_page_linkages(datatypes)
# datatypes.to_hl7_site
