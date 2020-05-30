obrsegs = HL7::SegmentDefinition.where(name:'Observation Request Segment').all
one = obrsegs.first.fields
two = obrsegs.last.fields
merge = one.zip two
merge.each do |a,b|
  raise if a.sequence_number != b.sequence_number
  raise if a.must_support    != b.must_support
  raise if a.min_cardinality != b.min_cardinality
  raise if a.max_cardinality != b.max_cardinality
  raise if a.optionality&.value != b.optionality&.value
  raise if a.repetition      != b.repetition
  raise if a.addendum_type   != b.addendum_type
  raise if a.data_element    != b.data_element
end
segs1 = obrsegs.first.segments.map(&:id)
segs2 = obrsegs.last.segments.map(&:id)
puts segs1.count
puts segs2.count
# puts (segs1 - segs2).sort.inspect
# puts (segs2 - segs1).sort.inspect
