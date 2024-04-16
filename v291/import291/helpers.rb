def ctstart
  ChangeTracker.start
end
def ctcommit
  ChangeTracker.commit
end
def asciidoc_lang
  @asciidoc_lang ||= Gui_Builder_Profile::MarkupType.where(:value=>"Asciidoc").first
  unless @asciidoc_lang
    ctstart
    @asciidoc_lang = Gui_Builder_Profile::MarkupType.new(:value=>"Asciidoc")
    @asciidoc_lang.save
    ctcommit
  end
  @asciidoc_lang
end
asciidoc_lang

def v291original
  @v291original ||= V2Web::SectionRenderingType.where(value:'v2.9.1').first
  unless @v291original
    ctstart
    @v291original = V2Web::SectionRenderingType.new
    @v291original.value = 'v2.9.1'
    @v291original.save
    ctcommit
  end
  @v291original
end
v291original

def may_truncate_true
  @may_truncate_true ||= V2::MayTruncate.where(Sequel.ilike(:value,'true')).first
  unless @may_truncate_true
    ctstart
    @may_truncate_true = V2::MayTruncate.new
    @may_truncate_true.value = 'true'
    @may_truncate_true.save
    ctcommit
  end
  @may_truncate_true
end
may_truncate_true

def may_truncate_inherit
  @may_truncate_inherit ||= V2::MayTruncate.where(Sequel.ilike(:value,'inherit')).first
  unless @may_truncate_inherit
    ctstart
    @may_truncate_inherit = V2::MayTruncate.new
    @may_truncate_inherit.value = 'inherit'
    @may_truncate_inherit.save
    ctcommit
  end
  @may_truncate_inherit
end
may_truncate_inherit

def translate_may_truncate(str)
  return nil unless str
  if str.to_s =~ /inherit/i
    return may_truncate_inherit
  end
  if str.to_s =~ /true/i
    return may_truncate_true
  end
  raise "Can't translate #{str.inspect} into a MayTruncate value"
end

def create_rt(text)
  unless text.is_a?(String)
    puts caller[0..4]
    puts text.class.name
    raise "Not a string for a RichText"
  end
  rt = Gui_Builder_Profile::RichText.new(:content => (text))
  rt.markup_language = asciidoc_lang
  rt.save
  rt
end

=begin
UNUSED

def translate_data_elements
  v2.data_elements.each do |item_number, dt|
    pp dt.values.first
    raise
    ctstart
    obj = HL7::V2::DataElement.new
    obj.item_number = dt.item_number
    obj.name = dt.name
    obj.min_length = dt.min_length
    obj.max_length = dt.max_length
    obj.c_length   = dt.c_length
    obj.may_truncate = translate_may_truncate(dt.may_truncate)
    obj.datatype_varies = dt.datatype_varies
    obj.datatype = dt.datatype.sequel
    definition text #FIXME
    table = value_set_definition(dt.table)
  end
end
=end