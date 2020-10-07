require_relative 'parse_common'

HL7::SegmentDefinition.delete
HL7::DataElement.delete

sources = HL7Parse.data_sources + ['V29_CH02_Control']
sources.each do |source|
  next if source == nil
  puts Rainbow('#####################################').orange
  puts Rainbow(source).orange
  chapter = source.slice(/(?<=CH)\d\dA?/)
  chapter.delete('0') if chapter[0] == '0' # get rid of leading zero
  extractor = V2Web::DocXtractor.new(chapter)
  docx_path = HL7Parse.docx_path(source)
  html_path = HL7Parse.html_path(source)
  stdout, stderr, status = Open3.capture3("pandoc -s #{docx_path} -o #{html_path}")
  puts stderr if stderr && !stderr =~ /WARNING/i
  doc = Docx::Document.open(docx_path)
  extractor.extract_segements(doc.doc, html_path)
end
ChangeTracker.start
HL7::SegmentDefinition.all.select { |sd| sd.fields_count == 0 }.each do |sd|
  sd.destroy
end
ChangeTracker.commit
