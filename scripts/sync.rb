require 'rainbow'
require 'sequel'
require 'sqlite3'
require 'db_io'
load (relative 'schema_diff.rb')
verbose = false
source_db = File.expand_path("../database/bSQL.db", __dir__)
# dest_db   = File.expand_path("~/Prometheus/data/v2_web_generated/SQL.db")
source    = Sequel.sqlite(source_db)
target    = DB #Sequel.sqlite(dest_db)
tt = target.tables
st = source.tables
puts "source is #{source_db} with #{source.tables.count} tables"
puts "target is #{target.inspect} with #{target.tables.count} tables"
puts "While ignoring _deleted tables..."
source_only_tables = (st - tt).select{ |t| t.to_s !~ /_deleted/ }.sort
target_only_tables = (tt - st).select{ |t| t.to_s !~ /_deleted/ }.sort

require_relative 'excluded_tables'
excluded_tables = deleted_tables_no_sync + ct_tables_no_sync
# excluded_tables += [:rtm_unit_views, :rtm_term_views]
options = {:sync_type => 'overwrite', :verbose => true, :excluded_tables => excluded_tables }


old2new_table_map = {}
source_only_tables.each do |sot|
  renamed = target_only_tables.find   { |tot| tot.to_s == sot.to_s.sub('hl7_', 'hl7_v2_') }
  renamed ||= target_only_tables.find { |tot| tot.to_s == sot.to_s.sub('hl7_', 'hl7_vocab_') }
  if renamed
    old2new_table_map[sot] = renamed 
    # puts sot.to_s + ' --> ' + Rainbow(renamed.to_s).green
  else
    puts Rainbow('No renamed tables found.  Here are the source only tables.').cyan
    # puts Rainbow(sot.to_s).yellow
  end
end
# st.select { |t| t.to_s =~ /value/ }.each { |t| puts Rainbow(t).orange }
# old2new_table_map[:hl7_value_sets] = :hl7_vocab_code_systems
# old2new_table_map[:fhir_narative_statuses] = :fhir_narrative_statuses
# old2new_table_map[:fhir_narative_status_narratives_with_staus_narrative_staus] = :fhir_narrative_status_narrative_status_narratives_with_statuses

puts 'Source tables not present in target tables are' + Rainbow(' yellow.').yellow
puts 'Target tables not present in source tables are' + Rainbow(' green.').green
puts
all_tables = (tt + st - excluded_tables).uniq.reject { |n| n =~ /_deleted/ }
all_tables.sort.each do |tbl|
  if source_only_tables.include?(tbl)
    num = source[tbl.to_sym].count
    puts Rainbow(tbl).yellow + ' ' + num.to_s
  elsif target_only_tables.include?(tbl)
    puts Rainbow(tbl).green
  else
    next unless verbose
    num = source[tbl.to_sym].count
    puts tbl.to_s + ' ' + num.to_s
  end
end


all_tables.sort.each do |tbl|
  diff_schemas(source, target, tbl) if st.include?(tbl) && tt.include?(tbl)
  mapped = old2new_table_map[tbl.to_sym]
  diff_schemas(source, target, tbl, mapped) if mapped
end


# puts "source tables not present in target tables:"
# (source_only_tables - old2new_table_map.keys).each { |t| puts "    #{t}" }
# puts "target tables not present in source tables:"
# (target_only_tables - old2new_table_map.values).each { |t| puts "    #{t}" }

# puts "\n\nchanged table map"
# pp old2new_table_map
options[:renamed_tables] = old2new_table_map
# options[:renamed_columns] = {
#   :fhir_narative_status_narratives_with_staus_narrative_staus => {
#     :staus_id => :status_id,
#     :narratives_with_stau_id => :narratives_with_status_id
#   },
#   :fhir_narratives => {
#     :staus_id => :status_id
#   },
#   :hl7_vocab_code_systems => {
#     :cs_version => :version
#   }
# }

# puts;puts '______________Schema Changes________________'
# common_tables = (st & tt)
# common_tables.each do |t|
#   oldschema = source.schema(t)
#   # puts '************'
#   # puts oldschema.map { |e| e.map(&:class) }
#   # puts '+++++++++++++++++++'
#   newschema = target.schema(t)
#   diff_schemas(oldschema, newschema, Rainbow(t.to_s).orange)
# end
# old2new_table_map.each do |ot, nt|
#   oldschema = source.schema(ot)
#   newschema = target.schema(nt)
#   label = Rainbow(ot.to_s).green + ' --> ' +  Rainbow(nt.to_s).orange
#   diff_schemas(oldschema, newschema, label)
# end






# puts "Enter yes to continue with sync > "; answer = gets.chomp
#  ****************************************************************************
target.sync(source, options) #if answer =~ /Y(es)?/i
#  ****************************************************************************

