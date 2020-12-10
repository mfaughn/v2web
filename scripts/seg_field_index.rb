require 'json'
x = []
HL7::SegmentDefinition.each do |sd|
  sd.fields.each do |field|
    x << "#{sd.code}-#{field.sequence_number}"
  end
end;
base = '~/projects/v2web/test_data/seg_field_index'
File.open(File.expand_path(base + '.json'), 'wb+') { |f| f.write(JSON.generate(x)) }
File.open(File.expand_path(base + '.txt'), 'wb+') { |f| x.sort.each { |s| f.puts s } }
nil