module SegmentChoiceMethods
  def to_resource
    xml = HL7.get_instance_template(:message_structure, 'choice')
    segments_xml = []
    segments.each { |seg| segments_xml << seg.to_segment_entry }
    xml.sub!('SEGMENT_ENTRIES', segments_xml.join)
    Nokogiri::XML(xml,&:noblanks).root.to_s
  end
  
  def to_fsh
    fsh = []
    segments.each_with_index do |seg, index|
      seg_fshs = seg.to_segment_entry_fsh
      seg_fshs.each do |seg_fsh|
        fsh << "choice.segmentEntry[#{index}].#{seg_fsh}"
      end
    end
    fsh
  end
  
  def same_as?(other)
    # puts Rainbow("A: #{self.class} / B: #{other.class}\nA: #{segments.count} / B: #{other.segments.count}").orange
    other.class == self.class &&
    other.segments.count == segments.count &&
    segments.zip(other.segments).all? do |a,b|
      # puts Rainbow(a.simple_render).cyan
      # puts Rainbow(b.simple_render).blue
      a.same_as?(b)
    end
  end
  
  def diff(other)    
    if same_as?(other)
      puts simple_render.pretty_inspect
    else
      segments.zip(other.segments).each { |a,b| a.diff(b) }
    end
  end
  
  def simple_render(indent = 0)
    out = []
    out += ['  '*indent + '<', ""]
    segments.each { |seg| out += seg.simple_render(indent + 1)}
    out += ['  '*indent + '>', ""]
  end
end
