require 'docx'
load File.join(__dir__, 'nokogiri_extensions.rb')
load File.join(__dir__, 'extractor.rb')
load File.join(__dir__, 'extract_segements.rb')
load File.join(__dir__, 'clear_tables.rb')
load File.join(__dir__, 'headers_footers.rb')
load File.join(__dir__, 'extractor_helpers.rb')

HL7::SegmentDefinition.delete
HL7::DataElement.delete
sources = []
# sources << ['../test_data/v2.9_Dec16/Ch2_segments']
sources << ['../test_data/v2.9_Dec16/V29_CH02_Control']
sources.each do |input|
  extractor = V2Web::DocXtractor.new(2)
  docx_path = File.join(__dir__, input) + '.docx'
  html_path = File.join(__dir__, input) + '.html'
  stdout, stderr, status = Open3.capture3("pandoc -s #{docx_path} -o #{html_path}")
  puts stderr if stderr && !stderr =~ /WARNING/i
  doc = Docx::Document.open(docx_path)
  extractor.extract_segements(doc.doc, html_path)
end
