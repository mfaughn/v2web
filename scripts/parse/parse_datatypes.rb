require_relative 'parse_common'

HL7::DataType.delete
HL7::Component.delete

# clear_tables
# node.display_structure
# puts; puts Rainbow(node.map_styles).green

HL7Parse.datatype_titles.clear

extractor = V2Web::DocXtractor.new('2A')
docx_path = HL7Parse.docx_path('datatypes')
doc = Docx::Document.open(docx_path)
extractor.extract_datatypes(doc.doc, html_path)

titles_path = File.join(__dir__, 'datatype_titles.txt')
File.open(titles_path, 'w+') { |f| HL7Parse.datatype_titles.sort.each { |t| f.puts t } }
titles_path = File.join(__dir__, 'datatype_titles.bin')
File.open(titles_path, 'wb+') {|f| f.write(Marshal.dump(HL7Parse.datatype_titles))}

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