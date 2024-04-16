require 'docx'
load File.join(__dir__, 'nokogiri_extensions.rb')
load File.expand_path(File.join(__dir__, '../extract/extractor.rb'))
load File.expand_path(File.join(__dir__, '../extract/extract2c.rb'))
load File.join(__dir__, 'clear_tables.rb')
load File.join(__dir__, 'headers_footers.rb')

# clear_tables
# node.display_structure
# puts; puts Rainbow(node.map_styles).green
  # input = File.expand_path('../../vocab/Tables_291', __dir__)
  # input = File.expand_path('../../vocab/v291_CH02C_Tables_20220913_BALLOT_1_v2.9.1_tables_only', __dir__)
  input = File.expand_path('../../vocab/v291_CH02C_Tables_20230617_with_Jira_Updates_20230721_tables_only', __dir__)
  
  extractor = V2Web::DocXtractor.new
  docx_path = input + '.docx'
  html_path = input + '.html'
  
  # Uncomment 2 lines below if you need to re-convert docx tables to html
  # stdout, stderr, status = Open3.capture3("pandoc -s #{docx_path} -o #{html_path}")
  # puts stderr if stderr && !stderr =~ /WARNING/i
  
  # extractor.extract_rels(path)
  # extractor.extract_headers(path)
  # extractor.extract_footers(path)
  
  doc = Docx::Document.open(docx_path)
  extractor.extract2c(doc.doc, html_path)
