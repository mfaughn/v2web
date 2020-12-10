module AbstractSegmentMethods
  def container
    structure || segment_sequence || segment_choice
  end
  
  def containing_structure
    c = container
    if c.class.name =~ /::MessageStructure/
      c
    else
      c.containing_structure
    end
  end
  
  def to_segment_entry
    xml = HL7.get_instance_template(:message_structure, 'segment_entry')
    [:repeat, :optional, :any_segment].each do |methd|
      xml.sub!(methd.to_s.upcase, send(methd).to_s)
    end
    xml.sub!('REPEAT',      repeat.to_s)
    xml.sub!('OPTIONAL',    optional.to_s)
    xml.sub!('ANY_SEGMENT', any_segment.to_s)
    xml.sub!('STATUS',      resource_status)
    xml.sub!('DESCRIPTION', resource_description)
    xml.sub!('SEGMENT',     to_resource)
    begin
      Nokogiri::XML(xml) { |config| config.strict.noblanks }.root.to_s
    rescue
      puts xml
      raise
    end
  end
  
  def to_segment_entry_fsh
    fsh = []
    fsh << "mayRepeat = #{!!repeat}"
    fsh << "optional = #{!!optional}"
    fsh << "anyHl7Segment = #{!!any_segment}"
    fsh << "status = '#{status}'" if status&.[](0)
    if respond_to?(:description) && description && description.strip[0]
      fsh << "description.status = #additional"
      fsh << "description.div = '<p>#{description.strip.gsub('&', '&#38;')}</p>'"
    end
    fsh += to_fsh
    fsh
  end
  
  def any_segment
    false
  end
  
  def resource_description
    ''
  end
  
  def resource_status
    if status && status.strip[0]
      HL7.get_instance_template(:common, 'status').sub('VALUE', status)
    else
      ''
    end
  end

end
