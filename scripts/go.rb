# HL7.classes(:no_imports => true).each do |c|
#   next unless c < Sequel::Model
#   next if c.enumeration?
#   if DB.tables.include?(c.table_name)
#     c.delete
#   end
# end
t = Time.now
# load File.join(__dir__, 'parse_value_sets.rb')
load File.join(__dir__, 'parse_datatypes.rb')
load File.join(__dir__, 'parse_segments.rb')
load File.join(__dir__, 'parse_msgs.rb')
load File.join(__dir__, 'parse_acs.rb')
# load File.join(__dir__, 'parse_text.rb')

HL7::Component.all.each do |c|
  if c.legacy_tbl
    vs = HL7::ValueSet.where(:table_id => c.legacy_tbl.to_i).first
    if vs
      ChangeTracker.start
      c.table = vs
      ChangeTracker.commit
    else
      puts "Could not find table #{c.legacy_tbl} for #{c.owner.name}.#{c.name}"
    end
  end
end

# load File.join(__dir__, 'parse_snelick.rb')
# load File.join(__dir__, 'build_snelick.rb')

puts "That took #{Time.now - t} seconds"


comps = HL7::Component.all;
typeless = comps.select { |comp| comp.type.nil? };
owners = {}
typeless.each do |comp|
  owners[comp.owner.code] ||= [comp.owner.components_count]
  owners[comp.owner.code] << comp
end;
pp owners
  