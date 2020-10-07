require_relative 'parse_common'

HL7::DataType.delete
HL7::Component.delete
# clear_tables
# node.display_structure
# puts; puts Rainbow(node.map_styles).green

sources = ['datatypes']
sources.each do |source|
  extractor = V2Web::DocXtractor.new
  docx_path = HL7Parse.docx_path(source)
  html_path = HL7Parse.html_path(source)
  stdout, stderr, status = Open3.capture3("pandoc -s #{docx_path} -o #{html_path}")
  puts stderr if stderr && !stderr =~ /WARNING/i  
  # extractor.extract_rels(path)
  # extractor.extract_headers(path)
  # extractor.extract_footers(path)
  doc = Docx::Document.open(docx_path)
  extractor.extract_datatypes(doc.doc, html_path)
end