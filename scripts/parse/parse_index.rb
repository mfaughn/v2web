require_relative 'parse_common'
# load File.expand_path(File.join(__dir__, '../dt_comp_index.rb'))
# load File.expand_path(File.join(__dir__, '../seg_field_index.rb'))
sections = []
HL7Parse.data_sources([1,2,'2a']).each do |source|
  next if source == nil
  puts
  chapter = source.slice(/(?<=CH)\d\dA?/)
  chapter.delete!('0') if chapter[0] == '0' # get rid of leading zero
  
  puts Rainbow("## Parse Index from #{source} ##").magenta
  
  extractor = V2Web::DocXtractor.new(chapter)
  docx_path = HL7Parse.docx_path(source)
  doc = Docx::Document.open(docx_path)
  section = extractor.extract_index(doc.doc)
  section.to_json_index(chapter.to_s)
  # puts source
  # puts (chapter.to_s)
  # puts
  sections << section
end
