Sequel::Model.descendants.sort_by { |x| x.to_s }.each do |klass|
  next if klass.to_s =~ /ChangeTracker/
  next unless klass.is_a?(Class)
  next unless DB.tables.include?(klass.table_name.to_sym)

  count = klass.count
  puts Rainbow("#{klass} - #{count}").cyan if count > 0
end

# HL7::Message.all.each do |msg|
#   next if msg.code == 'ACK'
#   puts "#{msg.code} - #{msg.structure&.code}"
# end