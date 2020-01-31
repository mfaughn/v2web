def dup_segs
  segs = {}
  HL7::SegmentDefinition.each do |seg|
    segs[seg.abbreviation] ||= []
    segs[seg.abbreviation] << seg.origin
  end
  multis = segs.select {|seg, oris| oris.count > 1}
  pp multis
end