# HL7.classes(:no_imports => true).each do |c|
#   next unless c < Sequel::Model
#   next if c.enumeration?
#   if DB.tables.include?(c.table_name)
#     c.delete
#   end
# end
t = Time.now
load File.join(__dir__, 'parse/parse_common.rb')
# load File.join(__dir__, 'parse/parse_references.rb')
# load File.join(__dir__, 'parse/parse_index.rb')
    # load File.join(__dir__, 'parse_value_sets.rb')
# load File.join(__dir__, 'parse/parse_datatypes.rb');# link_value_sets_to_components
# load File.join(__dir__, 'parse/parse_segments.rb')
# load File.join(__dir__, 'parse/parse_messages.rb')
load File.join(__dir__, 'parse/parse_text.rb')

# load File.join(__dir__, 'parse/parse_conformance.rb')
# load File.join(__dir__, 'build_snelick.rb')

puts "That took #{Time.now - t} seconds"


# comps = HL7::Component.all;
# typeless = comps.select { |comp| comp.type.nil? };
# owners = {}
# typeless.each do |comp|
#   owners[comp.owner.code] ||= [comp.owner.components_count]
#   owners[comp.owner.code] << comp
# end;
# pp owners
  #