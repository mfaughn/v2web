require_relative 'parse_common'

HL7Parse.data_sources.each do |source|
  next if source == nil
  puts Rainbow("## Parse Messages from #{source} ##").magenta
  chapter = source.slice(/(?<=CH)\d\dA?/)
  chapter.delete('0') if chapter[0] == '0' # get rid of leading zero
  extractor = V2Web::DocXtractor.new(chapter)
  docx_path = HL7Parse.docx_path(source)
  doc = Docx::Document.open(docx_path)
  extractor.extract_events(doc.doc)
end
