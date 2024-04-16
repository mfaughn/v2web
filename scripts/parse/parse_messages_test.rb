require_relative 'parse_common'

HL7::Message.delete
HL7::MessageStructure.delete
HL7::Event.delete
HL7::SegmentSequence.delete
HL7::SegmentChoice.delete
HL7::Segment.delete
HL7::AcknowledgmentChoreography.delete

V2Web::DocXtractor.new.extract_messages('V29_CH07_Observations')
