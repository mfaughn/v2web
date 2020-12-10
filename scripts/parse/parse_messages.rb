require_relative 'parse_common'

HL7::Message.delete
HL7::MessageStructure.delete
HL7::Event.delete
HL7::SegmentSequence.delete
HL7::SegmentChoice.delete
HL7::Segment.delete
HL7::AcknowledgmentChoreography.delete

sources = HL7Parse.data_sources
sources.compact.each { |source| V2Web::DocXtractor.new.extract_messages(source) }

if HL7Parse.data_sources.count > 15
  ChangeTracker.start
  obrsegempty = HL7::SegmentDefinition.where(name:'Observation Request Segment').all.select { |seg| seg.segments_count == 0 }.each { |x| x.destroy }
  ChangeTracker.commit
end
