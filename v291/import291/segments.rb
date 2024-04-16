module V291
  module_function

  def translate_seg_defs
    v2.segment_defs.each do |code, sd|
      ctstart
      obj = HL7::V2::SegmentDefinition.new
      obj.name = sd.name
      obj.code = sd.code
      obj.withdrawn = sd.withdrawn
      obj.save
      ctcommit
      sd.sequel = obj
      fieldobjs = sd.fields.map { |f| translate_field(f, sd) }
      ctstart
      obj.fields = fieldobjs
      obj.save
      ctcommit
    end
  end

  def get_seg_def_obj(type)
    sd = type.sequel
    raise "No seg def for #{type.code}" unless sd
    sd
  end

  def translate_field(fd, sd)
    def_txt = (fd.definition_text || fd.description) ? create_definition_text(fd.definition_text, fd.description) : nil
    ctstart
    obj = HL7::V2::Field.new
    obj.sequence_number = fd.seq
    obj.optionality     = fd.opt
    obj.repetition      = fd.repetition
    obj.must_support    = fd.must_support
    obj.min_cardinality = fd.min_card
    obj.max_cardinality = fd.max_card
    obj.flags           = fd.flags
    # obj.description = create_rt(fd.description) if fd.description # carried by the DefinitionText object
    # addendum_type # FIXME what does this mean?
    obj.save
    ctcommit
    # puts sd.section
    de = translate_data_element(fd.data_element, sd, fd)
    ctstart
    obj.data_element = de
    obj.definition_text = def_txt
    de.add_definition(def_txt)
    obj.save
    de.save
    ctcommit
    fd.sequel = obj
    obj
  end
  
  # What about Footnotes!! TODO
  def create_segment_obj(seg)
    obj = case seg
    when V2AD::Segment
      _create_segment_obj(seg)
    when V2AD::SegmentSequence
      _create_segment_sequence_obj(seg)
    when V2AD::SegmentChoice
      _create_segment_choice_obj(seg)
    when V2AD::SegmentGroup
      _create_segment_group_obj(seg)
    when V2AD::ExampleSegment
      _create_example_segment_obj(seg)
    else
      raise "I don't know what to do with a #{seg.class}"
    end
    seg.sequel = obj
    obj
  end

  def __create_segment_obj(klass, seg)
    ctstart
    obj = klass.new
    obj.repeat = seg.repeat
    obj.optional = seg.optional
    obj.status = seg.status if seg.status
    obj.save
    ctcommit
    obj
  end

  def __create_segment_obj_with_name(klass, seg)
    obj = __create_segment_obj(klass, seg)
    ctstart
    obj.name = seg.name
    ctcommit
    obj
  end

  def _create_segment_obj(seg)
    obj = __create_segment_obj(HL7::V2::Segment, seg)
    ctstart
    obj.description = seg.name
    obj.type = get_seg_def_obj(seg.type)
    obj.save
    ctcommit
    obj
  end

  def _create_segment_sequence_obj(seg)
    obj = __create_segment_obj_with_name(HL7::V2::SegmentSequence, seg)
    segs = seg.segments.map { |s| create_segment_obj(s) }
    ctstart
    segs.each { |s| obj.add_segment(s) }
    ctcommit
    obj
  end

  def _create_segment_choice_obj(seg)
    obj = __create_segment_obj_with_name(HL7::V2::SegmentChoice, seg)
    groups = seg.groups.map { |s| create_segment_obj(s) }
    ctstart
    groups.each { |g| obj.add_group(g) }
    ctcommit
    obj
  end

  def _create_example_segment_obj(seg)
    obj = __create_segment_obj(HL7::V2::ExampleSegment, seg)
    ctstart
    obj.description = seg.description
    ctcommit
    obj
  end

  # FIXME don't we need ct and save??
  def _create_segment_group_obj(group)
    ctstart
    obj = HL7::V2::SegmentGroup.new
    obj.save
    ctcommit
    segs = group.segments.map { |s| create_segment_obj(s) }
    ctstart
    segs.each { |s| obj.add_segment(s) }
    ctcommit
    obj
  end

end
