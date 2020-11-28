module CompositionMethods
  def local_url_name
    url_name = title.gsub(/\s+|:|\(|\)|\/|,/, '-').gsub(/-+/, '-').sub(/-$/, '')
  end
  
  def url_name
    'http://v2.hl7.org/fhir/Composition/' + local_url_name
  end
    
  def to_resource
    xml = HL7.get_instance_template(:composition, 'base')
    xml.sub!('URL', local_url_name)
    xml.sub!('YYYY-MM-DD', Time.now.strftime("%F"))
    xml.sub!('TITLE', title)
    xml.sub!('SECTIONS', sections_xml)
    Nokogiri::XML(xml,&:noblanks).to_s
  end
  
  def sections_xml
    ss = sections
    ss.delete_at(1) if ss[1].title =~ /Chapter.*contents/i # TOC should be built dynamically, not stored statically
    ss.map { |s| s.to_composition_section }.join
  end
  
end
