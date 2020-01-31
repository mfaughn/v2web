module HL7
  class DataType
    def local_url_name
      name.downcase.gsub(/[^A-Za-z\d]/, '-')
    end
    
    def to_resource
      xml = HL7.get_instance_template(:data_type, 'base')
      xml.sub!('URL', local_url_name)
      [:name, :withdrawn, :abbreviation].each do |property|
        xml.sub!(property.to_s.upcase, send(property).to_s)
      end
      xml.sub!('DESCRIPTION', description_content)
      xml.sub!('ARRAY_TYPE', array_type.to_s)
      xml.sub!('NOTES', resource_notes)
      comps = []
      components.each { |c| comps << c.to_resource }
      xml.sub!('COMPONENTS', comps.join)
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
end # module HL7
