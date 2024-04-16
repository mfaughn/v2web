hash = {}
klasses = HL7.classes + FHIR.classes
klasses.select { |c| c.instance_methods.include?(:url_name) }.each do |klass|
  key = klass.name.demodulize
  hash[key] = {}
  klass.each do |instance|
    hash[key][instance.local_url_name] = instance
  end
end
hash.each do |k,v|
  puts Rainbow(k).orange
  v.each { |x,y| puts "#{x} => #{y.class}[#{y.id}]"}
end
    