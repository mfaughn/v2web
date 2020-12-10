require_relative 'parse_common'

HL7::DataType.delete
HL7::Component.delete

HL7Parse.datatype_titles.clear

V2Web::DocXtractor.new.extract_datatypes('datatypes')

titles_path = File.join(__dir__, 'datatype_titles.txt')
File.open(titles_path, 'w+') { |f| HL7Parse.datatype_titles.sort.each { |t| f.puts t } }
titles_path = File.join(__dir__, 'datatype_titles.bin')
File.open(titles_path, 'wb+') { |f| f.write(Marshal.dump(HL7Parse.datatype_titles)) }

def link_value_sets_to_components
  HL7::Component.all.each do |c|
    if !c.legacy_tbl.empty? && !c.table
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
end