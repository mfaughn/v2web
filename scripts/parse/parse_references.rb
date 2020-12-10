require_relative 'parse_common'

HL7Parse.segment_titles.clear
HL7Parse.datatype_titles.clear

HL7Parse.data_sources(['2']).each do |source|
  extractor = V2Web::DocXtractor.new
  docx_path = HL7Parse.docx_path(source)
  doc = Docx::Document.open(docx_path)
  extractor.create_segment_list(doc.doc)
end

titles_path = File.join(__dir__, 'segment_titles.txt')
File.open(titles_path, 'w+') { |f| HL7Parse.segment_titles.sort.each { |t| f.puts t } }
titles_path = File.join(__dir__, 'segment_titles.bin')
File.open(titles_path, 'wb+') {|f| f.write(Marshal.dump(HL7Parse.segment_titles))}
titles_path = File.join(__dir__, 'segment_titles.json')
File.open(titles_path, 'wb+') {|f| f.write(JSON.dump(HL7Parse.segment_titles))}


extractor = V2Web::DocXtractor.new('2A')
docx_path = HL7Parse.docx_path('datatypes')
doc = Docx::Document.open(docx_path)
extractor.create_datatype_list(doc.doc)

titles_path = File.join(__dir__, 'datatype_titles.txt')
File.open(titles_path, 'w+') { |f| HL7Parse.datatype_titles.sort.each { |t| f.puts t } }
titles_path = File.join(__dir__, 'datatype_titles.bin')
File.open(titles_path, 'wb+') {|f| f.write(Marshal.dump(HL7Parse.datatype_titles))}
titles_path = File.join(__dir__, 'datatype_titles.json')
File.open(titles_path, 'wb+') {|f| f.write(JSON.dump(HL7Parse.datatype_titles))}
