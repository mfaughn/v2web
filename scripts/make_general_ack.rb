ga = HL7::Message.where(:name => 'General Acknowledgment').first
unless ga
  ChangeTracker.start
  ga = HL7::Message.create(:name => 'General Acknowledgment')
  s1 = HL7::Segment.create
  s1.type = HL7::SegmentDefinition.where(:code => 'MSH').first
  s2 = HL7::Segment.create
  s2.optional = true
  s2.repeat = true
  s2.type = HL7::SegmentDefinition.where(:code => 'SFT').first
  s3 = HL7::Segment.create
  s3.type = HL7::SegmentDefinition.where(:code => 'UAC').first
  s3.optional = true
  s4 = HL7::Segment.create
  s4.type = HL7::SegmentDefinition.where(:code => 'MSA').first
  s5 = HL7::Segment.create
  s5.type = HL7::SegmentDefinition.where(:code => 'ERR').first
  s5.optional = true
  s5.repeat = true
  s1.save; s2.save; s3.save; s4.save; s5.save
  ga.segments = [s1, s2, s3, s4, s5]
  ga.origin = '02'
  ga.save
  ChangeTracker.commit
end
