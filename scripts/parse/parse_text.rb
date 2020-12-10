require 'zip'
require 'fileutils'
load File.expand_path(File.join(__dir__, 'parse_common.rb'))

FHIR::Composition.delete
FHIR::Section.delete
FHIR::Narrative.delete
FHIR::Basic.delete

sources = HL7Parse.data_sources(['1','2','2a'])
# sources = ['V29_CH02_Control']
# sources = ['V29_CH01_Intro']
# sources = ['v29_CH04_Orders']

sources.compact.each { |source| V2Web::DocXtractor.new.extract_chapter(source) }

