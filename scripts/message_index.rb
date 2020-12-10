require 'json'
x = []
HL7::MessageStructure.each do |ms|
  ms.each do |m|
    x << "#{ms.code} - #{ms.origin}"
  end
end;
x.uniq!
x.compact!
base = '~/projects/v2web/test_data/msg_struct_index'
File.open(File.expand_path(base + '.json'), 'wb+') { |f| f.write(JSON.generate(x)) }
File.open(File.expand_path(base + '.txt'), 'wb+') { |f| x.sort.each { |s| f.puts s } }
nil