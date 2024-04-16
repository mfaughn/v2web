module V291
  module_function
  
  def translate_data_element(de, sd, fd)
    may_truncate_inherit
    may_truncate_true
    voc = value_set_definition(de.table, "#{sd.code}-#{fd.seq} #{sd.section}")
    ctstart
    obj = HL7::V2::DataElement.new
    obj.item_number      = de.item_number
    obj.name             = de.name
    obj.min_length       = de.min_length
    obj.max_length       = de.max_length
    obj.c_length         = de.c_length
    obj.may_truncate     = translate_may_truncate(de.may_truncate)
    obj.data_type_varies = de.datatype_varies
    puts "No datatype for #{de.item_number} in #{sd.code} from section #{sd.section}" unless de.datatype || fd.opt == 'W'
    obj.data_type        = de.datatype.sequel if de.datatype
    obj.vocab            = voc
    obj.save
    ctcommit
    de.sequel = obj
    obj
  end

end
