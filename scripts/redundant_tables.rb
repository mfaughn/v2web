
module HL7
  class DataElement
    def report
      "#{item_number} (#{data_type.code}): Found in #{fields.map { |f| f.segment_definition.code + '-' + f.sequence_number.to_s}.join(', ')}"
    end
  end
  
  module_function
  def blah
    @blah ||= dets.reject { |de| ["CWE", "ID"].include?(de.data_type.code) }
  end
  
  def all_segs
    @all_segs ||= HL7::SegmentDefinition.all;
  end
  
  def dets
    @dets ||= HL7.all_segs.map(&:fields).flatten.select {|f| f.data_element.table && f.optionality.value != 'W' }.map(&:data_element)
  end
 
  def all_data_types
    @all_data_types ||= HL7::DataType.all;
  end
 
  def resetx
    @dt_tables = {}
    @first_fields = {}
  end
   
  def dt_tables
    return @dt_tables unless @dt_tables.empty?
    all_data_types.reject { |dt| dt.withdrawn }.each do |dt|
      comps = dt.components
      if comps.any?
        comp = comps.find { |c| c.table }
        if comp.nil?
          # puts "DataType #{dt.code} has no tables."
          entry = {seq:dt.code}
        else
          # entry = { comp:comp, comp_dt:comp.type, seq:comp.sequence_number, table: comp.table, table_num:comp.table.table_id }
          entry = { seq:"#{dt.code}-#{comp.sequence_number}", comp_code:comp.type.code, table_num:comp.table.table_id }
        end
      else
        next
        puts "#{dt.code} has no comps!"
        entry = {:fart => dt.code}
      end
      @dt_tables[dt.code] = entry
    end
    @dt_tables
  end
 
  def first_fields
    return @first_fields unless @first_fields.empty?
    all_segs.each do |seg|
      field = seg.fields.find { |f| f.data_element.table }
      if field.nil?
        # puts "Segment #{seg.code} has no tables."
        next
      end
      de    = field.data_element
      table = de.table
      dtcode = de.data_type.code
      dt_entry = dt_tables[dtcode]
      cwe_direct = 'CWE' == dtcode
      cwe_comp = 'CWE' == dt_entry[:comp_code]
      id_direct = 'ID' == dtcode 
      id_comp = 'ID' == dt_entry[:comp_code] && !cwe_direct
      is_direct = 'IS' == dtcode
      is_comp = 'IS' == dt_entry[:comp_code]
      # entry = { :field => field, :data_element => field.data_element, :seq => field.sequence_number, :table => table, :num => table.table_id, :dt => dt_tables[de.data_type]  }
      entry = { :seq => "#{seg.code}-#{field.sequence_number}", :item_number => de.item_number, :table_num => table.table_id, :dt => dt_entry, :cwe_direct => cwe_direct, cwe_comp:cwe_comp, id_direct:id_direct, id_comp:id_comp, is_direct:is_direct, is_comp:is_comp}
      
      @first_fields[seg.code] = entry
    end
    @first_fields
  end
end

def gogo
  HL7.resetx
  ffs = HL7.first_fields
  # pp ffs
  # pp HL7.all_data_types;puts

  sames = ffs.select { |k,v| v[:table_num] == v.dig(:dt, :table_num) && !v[:cwe_direct] && !v[:id_direct] && !v[:is_direct] && !v[:cwe_comp] && !v[:is_comp] && !v[:id_comp] }
  diffs = ffs.select { |k,v| v[:table_num] != v.dig(:dt, :num) && !v[:cwe_direct] && !v[:id_direct] && !v[:is_direct] && !v[:cwe_comp] && !v[:is_comp] && !v[:id_comp] }
  cwed = ffs.select { |k,v| v[:cwe_direct] }
  cwec = ffs.select { |k,v| v[:cwe_comp] }
  isd = ffs.select { |k,v| v[:is_direct] }
  isc = ffs.select { |k,v| v[:is_comp] }
  idd = ffs.select { |k,v| v[:id_direct] }
  idc = ffs.select { |k,v| v[:id_comp] }


  # puts Rainbow("Sames:").green
  # pp sames;puts
  # puts Rainbow("CWE Direct:").green
  # pp cwed;puts
  puts Rainbow("CWE Indirect:").green
  pp cwec;puts
  # puts Rainbow("ID Direct:").green
  # pp idd;puts
  puts Rainbow("ID Indirect:").green
  pp idc;puts
  puts Rainbow("IS Direct:").green
  pp isd;puts
  puts Rainbow("IS Indirect:").green
  pp isc;puts
  puts Rainbow("Diffs:").green
  pp diffs;puts

  des = {}
  ffs.each do |k,v|
    des[v[:item_number]] ||= 0
    des[v[:item_number]] += 1
  end
  puts Rainbow('DUPES:').orange
  multides = []
  des.each do |k,v| 
    multides << k if v > 1
  end 
end

# HL7.dets.each do |de|
#   unless de.data_type
#     puts de.item_number
#     de.fields.each do |f|
#       puts "#{f.segment_definition.code}-#{f.sequence_number}"
#     end
#   end
# end

stuff = {}
HL7.blah.each do |de|
  dt = de.data_type
  next if dt.code =~ /CWE|ID/
  comp = dt.components.find { |c| c.table }
  next if comp&.type&.code.to_s =~ /CWE|ID/
  if comp
    key = "#{dt.code}-#{comp.sequence_number}: #{comp.type.code}"
  else
    
    key = dt.code# Rainbow(dt.code).orange
  end
  stuff[key] ||= []
  report = de.report
  stuff[key] << report unless stuff[key].include?(report)
end
pp stuff
# dts = blah.map(&:data_type).uniq.map do |dt|
#   comp = dt.components.find { |c| c.table }
#   if comp
#     "#{dt.code}-#{comp.sequence_number}: #{comp.type.code}"
#   else
#     Rainbow(dt.code).orange
#   end
# end
# puts dts
# blah.each do |de|
#   puts "#{de.item}"
# pp ffs.select { |k,v| multides.include?(v[:item_number]) }

