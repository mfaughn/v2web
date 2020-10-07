require 'sequel'
require 'sqlite3'
require 'db_io'

source_db = File.expand_path("~/Prometheus/data/v2_web_generated/bSQL.db")
dest_db   = File.expand_path("~/Prometheus/data/v2_web_generated/SQL.db")
$source   = Sequel.sqlite(source_db)
$target   = Sequel.sqlite(dest_db)
tt = $target.tables;nil
st = $source.tables;nil
puts "source has #{$source.tables.count} tables"
puts "target has #{$target.tables.count} tables"
puts "While ignoring _deleted tables..."
puts "source tables not present in target tables:\n  #{(st - tt).select{|t| t.to_s !~ /_deleted$/}.sort.inspect}"
puts "target tables not present in source tables:\n  #{(tt - st).select{|t| t.to_s !~ /_deleted$/}.sort.inspect}"

options = {:sync_type => 'overwrite', :verbose => true}


puts "press <Enter>"; gets
#  ****************************************************************************
$target.sync($source, options)
#  ****************************************************************************

