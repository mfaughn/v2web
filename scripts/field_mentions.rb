des = HL7::DataElement.all;
field_mentions = []
this_field_mentions = []
multi_usage = {}

total_defs = 0
des.each do |de|
  defs = de.definitions
  defs.each do |d|
    total_defs +=1
    field_mentions << "Ch. #{d.chapter} - #{d.original_container}" if d.definition_content =~ /field/i
    this_field_mentions << "Ch. #{d.chapter} - #{d.original_container}" if d.definition_content =~ /this field/i
  end
  multi_usage[de.item_number] = defs if defs.count > 1
end
# puts field_mentions.sort.inspect
puts "#{this_field_mentions.count} out of #{total_defs}"
puts "#{field_mentions.count} out of #{total_defs}"
puts "#{multi_usage.keys.count} - #{multi_usage.values.flatten.count}"
