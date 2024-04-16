require 'zip'
require 'fileutils'
load File.expand_path(File.join(__dir__, 'parse_common.rb'))

FHIR::Composition.delete
FHIR::Section.delete
FHIR::Narrative.delete
FHIR::Basic.delete

source = 
V2Web::DocXtractor.new.extract_generic(source)
