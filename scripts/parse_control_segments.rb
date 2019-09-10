require 'docx'
load File.join(__dir__, 'nokogiri_extensions.rb')
load File.join(__dir__, 'extractor.rb')
load File.join(__dir__, 'extract_control_segements.rb')
load File.join(__dir__, 'clear_tables.rb')
load File.join(__dir__, 'headers_footers.rb')
# clear_tables
# node.display_structure
# puts; puts Rainbow(node.map_styles).green
sources = []
sources << ['../test_data/V29_CH02_Control_message_defs']
# sources << ['../test_data/HL7v2ConformanceMethodology_14052019_accepted_changes', 'test']
sources.each do |input|
  extractor = SDoc::DocXtractor.new
  docx_path = File.join(__dir__, input) + '.docx'
  html_path = File.join(__dir__, input) + '.html'
  # stdout, stderr, status = Open3.capture3("pandoc -s #{docx_path} -o #{html_path}")
  # puts stderr if stderr && !stderr =~ /WARNING/i
  doc = Docx::Document.open(docx_path)
  extractor.extract_control_segements(doc.doc, html_path)
end
