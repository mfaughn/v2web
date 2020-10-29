module MessageMethods
  def local_url_name
    url_name = code.dup
    url_name << "-#{event_code}" if event_code
    url_name.downcase.gsub(/[^a-z\d]/, '-')
  end
  
  def url_name
    'http://v2.hl7.org/fhir/MessageDefinition/' + local_url_name
  end
  
  def event_code
    (trigger_for || response_to.first || ack_to.first)&.code
  end
  
  def to_fsh
    unless self.structure
      structure_code = name.split('^').last.split(/\s/).first
      ChangeTracker.start
      self.structure = HL7::MessageStructure.where(:code => structure_code).first
      ChangeTracker.commit
    end
    fsh = []
    fsh << 'Instance: ' + local_url_name
    fsh << 'InstanceOf: MessageDefinition'
    fsh << 'Title: ' + name.gsub("\n", ' ').inspect
    fsh << 'Description: ' + resource_description_content.inspect
    fsh << '* url  = "http://v2.hl7.org/fhir/MessageDefinition/' + local_url_name + '"'
    fsh << '* name = ' + name.gsub("\n", ' ').inspect
    fsh << '* code = #' + code
    fsh << '* structure = "http://v2.hl7.org/fhir/MessageStructure/' + structure.local_url_name + '"'
    fsh << "\n"
    fsh.join("\n")
  end
  
  def to_resource
    xml = HL7.get_instance_template(:message, 'base')
    xml.sub!('URL', local_url_name)
    [:name, :code].each do |methd|
      xml.sub!(methd.to_s.upcase, send(methd).to_s)
    end
    unless self.structure
      structure_code = name.split('^').last.split(/\s/).first
      ChangeTracker.start
      self.structure = HL7::MessageStructure.where(:code => structure_code).first
      ChangeTracker.commit
    end
    puts name unless self.structure
    xml.sub!('MESSAGE_STRUCTURE_URL', structure.local_url_name)
    xml.sub!('DESCRIPTION', resource_description_content)
    Nokogiri::XML(xml,&:noblanks).to_s
  end
  
  def resource_description_content
     if description_content && description_content.strip[0]
       xml = HL7.get_instance_template(:common, 'description').sub('VALUE', description_content)
       Nokogiri::XML(xml,&:noblanks).root.to_s
     else
       ''
     end
  end
end
