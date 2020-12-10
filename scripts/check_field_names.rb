xx = {}
HL7::SegmentDefinition.all do |sd|
  x = {}
  sd.fields.each do |f|
    n = f.data_element&.name&.strip
    next unless n
    x[n] ||= []
    x[n] << f.sequence_number
  end
  if x.any? { |k,v| v.count > 1 }
    xx[sd.code] = x.reject { |k,v| v.count < 2 }
  end
end

pp xx


def get_seg_names(seg)
  return [] unless seg.is_a?(HL7::SegmentSequence) || seg.is_a?(HL7::SegmentChoice)
  return [seg.name] + seg.segments.map { |sseg| get_seg_names(sseg) }
end

xx = {}
HL7::MessageStructure.all do |msg|
  names = msg.segments.map { |seg| get_seg_names(seg) }
  names.flatten!
  dupes = names.find_all { |e| names.count(e) > 1 }
  xx[msg.origin+msg.code] = dupes if dupes.any?
end
pp xx

