module BasicMethods
  def local_url_name
    url_name = 'FIXME'
  end
  
  def url_name
    'http://v2.hl7.org/fhir/Basic/' + local_url_name
  end
  
  def to_resource
    xml = HL7.get_instance_template(:basic, 'base')
    xml.sub!('URL', local_url_name)
    Nokogiri::XML(xml,&:noblanks).to_s
  end
  
end
