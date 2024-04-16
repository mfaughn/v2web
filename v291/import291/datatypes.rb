module V291
  module_function
  def translate_datatypes
    created_dts = []
    dts = v2.datatypes
    puts "There are #{dts.size} Data Type definitions."
    dts.each do |code, dt|
      ctstart
      obj = HL7::V2::DataType.new
      obj.code   = dt.code
      obj.name   = dt.name
      obj.origin = dt.section
      obj.array_type = dt.array_type
      obj.save
      ctcommit
      dt.sequel = obj
      created_dts << obj
    end
    dts.each do |code, dt|
      obj   = dt.sequel
      comps = translate_components(dt.components, obj)
      ctstart
      obj.components = comps
      ctcommit
    end
    # puts "Created #{created_dts.size} Data Types of type #{created_dts.first.class}: #{created_dts.map(&:code).sort}"
    # puts "Yet there are #{created_dts.first.class.count} instances of #{created_dts.first.class}"
    # puts "WTF?!?"
  end

  def translate_components(comps, owner)
    objs = comps.map { |c| translate_component(c, owner) }
  end

  def translate_component(comp, owner)
    voc = value_set_definition(comp.table, "#{owner.code}-#{comp.seq} #{owner.origin}")
    ctstart
    obj = HL7::V2::Component.new
    obj.origin = comp.section
    obj.vocab = voc
    clen = comp.clen&.slice(/\d+/)
    obj.c_length = clen if clen
    obj.may_truncate = "false"   if comp.clen =~ /=/
    obj.may_truncate = "inherit" if comp.clen =~ /#/
    if comp.len
      obj.min_length = comp.len.strip.slice(/^\d+/)
      obj.max_length = comp.len.strip.slice(/\d+$/)
    end
    obj.name = comp.name
    obj.sequence_number = comp.seq
    if comp.datatype
      obj.type = HL7::V2::DataType.where(code:comp.datatype).first
    else
      obj.type = owner
    end
    obj.optionality = comp.opt
    obj.legacy_tbl  = comp.table
    if comp.text
      rt = Gui_Builder_Profile::RichText.new(:content => comp.text.lines.join("\n"))
      rt.markup_language = asciidoc_lang
      rt.save
      obj.definition = rt
    else

    end
    obj.save
    ctcommit
    comp.sequel = obj
    obj
  end

end
