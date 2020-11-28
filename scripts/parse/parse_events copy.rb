require_relative 'parse_common'

HL7::Message.delete
HL7::MessageStructure.delete
HL7::Event.delete
HL7::SegmentSequence.delete
HL7::SegmentChoice.delete
HL7::Segment.delete

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
if HL7Parse.data_sources.count > 15
  ChangeTracker.start
  obrsegempty = HL7::SegmentDefinition.where(name:'Observation Request Segment').all.select { |seg| seg.segments_count == 0 }.each { |x| x.destroy }
  ChangeTracker.commit
end
