# Docx::Document instance methods
# bookmarks
# doc
# document_properties
# each_paragraph
# font_size
# paragraphs
# replace_entry
# save
# styles
# tables
# text
# to_html
# to_s
# xml
# zip

require 'docx'
load File.join(__dir__, 'nokogiri_extensions.rb')
load File.join(__dir__, 'extractor.rb')
load File.join(__dir__, 'clear_tables.rb')
load File.join(__dir__, 'headers_footers.rb')
load File.join(__dir__, 'headers_hack.rb')

clear_tables
# node.display_structure
# puts; puts Rainbow(node.map_styles).green
sources = []
# sources << ['../test_data/HL7v2DataTypeSpecializationsBallot-May2018', 'HL7 v2 DataType Specializations Ballot-May2018']
sources << ['../test_data/V2_CONFORM_R1_O1_2019SEP', 'HL7v2 Conformance Methodology R1 O1 - September 2019']
sources.each do |docx, title|
  extractor = V2Web::DocXtractor.new
  path = File.join(__dir__, docx)
  extractor.extract_rels(path)
  extractor.extract_headers(path)
  extractor.extract_footers(path)
  file = path + '.docx'
  doc = Docx::Document.open(file)
  extractor.extract_document(doc.doc, title)
end
headers_hack