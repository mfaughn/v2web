module SegmentMethods
  def to_resource
    xml = HL7.get_instance_template(:message_structure, 'segment')
    xml.sub!('URL', type.local_url_name)
    Nokogiri::XML(xml) { |config| config.strict.noblanks }.root.to_s
  end
  
  def to_fsh
    fsh = []
    fsh << "segment = \"https://v2.hl7.org/fhir/SegmentDefinition/#{type.local_url_name}\""
    fsh
  end
  
  def any_segment
    unless type
      puts inspect
      puts containing_structure.code.inspect
      puts containing_structure.origin.inspect
    end
    type.name == 'Hxx'
  end
  
  def resource_description
     if description && description.strip[0]
       xml = HL7.get_instance_template(:common, 'description').sub('VALUE', "<p>#{description.strip.hl7}</p>")
       begin
         Nokogiri::XML(xml) { |config| config.strict.noblanks }.root.to_s
       rescue
         puts xml
         raise
       end
     else
       ''
     end
  end
  
  def same_as?(other)
    other.class == self.class &&
    # other.description  == self.description &&
    other.type == self.type
  end
  
  def diff(other)    
    if same_as?(other)
      puts simple_render.pretty_inspect
    else
      puts Rainbow(simple_render.pretty_inspect).yellow
      if other
        puts Rainbow(other.simple_render.pretty_inspect).green
      else
        puts Rainbow('NO SEGMENT!').green
      end
    end
  end
  
  def simple_render(indent = 0)
    out = " #{type.code} "
    if repeat && optional
      out = "[{#{out}}]"
    elsif repeat
      out = "{ #{out} }"
    elsif optional
      out = "[ #{out} ]"
    else
      out = "  #{out}  "
    end
    out = "  "*indent + out
    [[out, description]]
  end
end
