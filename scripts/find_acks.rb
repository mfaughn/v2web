require_relative 'make_general_ack'
acks = []
HL7::Message.each do |msg|
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


# ChangeTracker.start
# ga.aliases = acks
# ChangeTracker.commit

HL7::AcknowledgmentChoreography.exclude(:msh15_id => nil).all

  