require 'json'
x = []
HL7::DataType.each do |dt|
  dt.components.each do |comp|
    x << "#{dt.code}-#{comp.sequence_number}"
  end
end;
base = '~/projects/v2web/test_data/dt_comp_index'
File.open(File.expand_path(base + '.json'), 'wb+') { |f| f.write(JSON.generate(x)) }
File.open(File.expand_path(base + '.txt'), 'wb+') { |f| x.sort.each { |s| f.puts s } }
nil