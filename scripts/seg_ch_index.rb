defs = []
HL7::SegmentDefinition.each do |sd|
  defs << "#{sd.code} - Chapter #{sd.origin}"
end;
puts defs.sort
nil