module SectionMethods
  def to_composition_section
    xml = HL7.get_instance_template(:composition, 'section')
    [:title].each do |methd|
      xml.sub!(methd.to_s.upcase, send(methd).to_s)
    end
    xml.sub!('CODE', code)
    xml.sub!('TEXT', resource_text)
    xml.sub!('ENTRY', resource_entry) # FIXME do we actually need to put something here? When?
    xml.sub!('EMTPY_REASON', '') # FIXME do we actually need to put something here? When?
    sections_xml = []
    sections.each { |ss| sections_xml << ss.to_composition_section }
    xml.sub!('SECTIONS', sections_xml.join)
    # puts xml;puts '*********************************************************'
    nxml = Nokogiri::XML(xml,&:noblanks).root.to_s
    # puts nxml;puts '*********************************************************'
    nxml
  end
  
  def resource_entry
    return '' unless entry
    xml = HL7.get_instance_template(:composition, 'entry')
    xml.gsub('VALUE', entry)
  end
  
  def resource_text
    html = text&.div&.content
    return '' unless html&.[](0) # return empty string unless there is a non-empty narrative
    xml = HL7.get_instance_template(:composition, 'narrative')
    xml.sub('VALUE', html)
  end
end
