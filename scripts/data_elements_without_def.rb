des = HL7::DataElement.all;
x = []
des.each do |de|
  next if de.definitions_count > 0
  de.fields.each do |f|
    seg = f.segment_definition
    x << "Ch.#{seg.origin} - #{seg.code}-#{f.sequence_number}"
  end
end

puts x
puts x.count
