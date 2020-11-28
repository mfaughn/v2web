module DataTypeMethods
  def local_url_name
    unless name
      # FIXME do better than this...
      puts "Datatype without name\n#{pretty_inspect}"
      puts
      return ''
    end
    name.downcase.gsub(/[^A-Za-z\d]/, '-')
  end
  
  def url_name
    'http://v2.hl7.org/fhir/DataTypeDefinition/' + local_url_name
  end
  
  def to_resource
    xml = HL7.get_instance_template(:data_type, 'base')
    xml.sub!('URL', local_url_name)
    [:name, :withdrawn, :code].each do |property|
      xml.sub!(property.to_s.upcase, send(property).to_s)
    end
    xml.sub!('DESCRIPTION', description_content.to_s)
    xml.sub!('ARRAY_TYPE', array_type.to_s)
    xml.sub!('NOTES', resource_notes)
    comps = []
    components.each { |c| comps << c.to_resource }
    xml.sub!('COMPONENTS', comps.join("\n"))
    Nokogiri::XML(xml,&:noblanks).to_s
  end
  
  def resource_notes
    return '' if notes.empty?
    output = notes.each do |c|
      HL7.get_instance_template(:data_type, 'usageNotes').sub('VALUE', c)
    end
    output
  end
end
