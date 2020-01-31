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
load File.join(__dir__, 'extractor_helpers.rb')
load File.join(__dir__, 'extract_datatypes.rb')
load File.join(__dir__, 'clear_tables.rb')
load File.join(__dir__, 'headers_footers.rb')
HL7::DataType.delete
HL7::Component.delete
# clear_tables
# node.display_structure
# puts; puts Rainbow(node.map_styles).green
sources = []
sources << ['../test_data/v2.9_Dec16/datatypes']
sources.each do |input|
  extractor = V2Web::DocXtractor.new
  docx_path = File.join(__dir__, input) + '.docx'
  html_path = File.join(__dir__, input) + '.html'
  stdout, stderr, status = Open3.capture3("pandoc -s #{docx_path} -o #{html_path}")
  puts stderr if stderr && !stderr =~ /WARNING/i  
  # extractor.extract_rels(path)
  # extractor.extract_headers(path)
  # extractor.extract_footers(path)
  doc = Docx::Document.open(docx_path)
  extractor.extract_datatypes(doc.doc, html_path)
end