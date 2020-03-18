acks = []
HL7::MessageDefinition.each do |msg|
  segs = msg.segments
  next unless segs[0].is_a?(HL7::Segment)
  next unless segs[1].is_a?(HL7::Segment)
  next unless segs[2].is_a?(HL7::Segment)
  next unless segs[3].is_a?(HL7::Segment)
  next unless segs[4].is_a?(HL7::Segment)
  next unless segs[0].type.id == 9
  next unless segs[1].type.id == 12
  next unless segs[2].type.id == 15
  next unless segs[3].type.id == 8
  next unless segs[4].type.id == 5
  next unless segs[0].optional == false
  next unless segs[1].optional == true
  next unless segs[2].optional == true
  next unless segs[3].optional == false
  next unless segs[4].optional == true
  next unless segs[0].repeat == false
  next unless segs[1].repeat == true
  next unless segs[2].repeat == false
  next unless segs[3].repeat == false
  next unless segs[4].repeat == true
  next if segs[5]
  acks << msg
end
# acks.each {|a| puts a.name}
# puts acks.count


ga = HL7::MessageDefinition.where(:name => 'General Acknowledgment').first
unless ga
  ChangeTracker.start
  ga = HL7::MessageDefinition.create(:name => 'General Acknowledgment')
  s1 = HL7::Segment.create
  s1.type = HL7::SegmentDefinitions.where(:abbreviation => 'MSH').first
  s2 = HL7::Segment.create
  s2.optional = true
  s2.repeat = true
  s2.type = HL7::SegmentDefinitions.where(:abbreviation => 'SFT').first
  s3 = HL7::Segment.creat3
  s3.type = HL7::SegmentDefinitions.where(:abbreviation => 'UAC').first
  s3.optional = true
  s4 = HL7::Segment.create
  s4.type = HL7::SegmentDefinitions.where(:abbreviation => 'MSA').first
  s5 = HL7::Segment.create
  s5.type = HL7::SegmentDefinitions.where(:abbreviation => 'ERR').first
  s5.optional = true
  s5.repeat = true
  s1.save; s2.save; s3.save; s4.save; s5.save
  ga.segments = [s1, s2, s3, s4, s5]
  ga.save
  ChangeTracker.commit
end
ChangeTracker.start
ga.aliases = acks
ChangeTracker.commit
  

  