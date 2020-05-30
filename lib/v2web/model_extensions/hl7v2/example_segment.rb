module HL7
  class ExampleSegment
    def to_resource
      xml = HL7.get_instance_template(:message_structure, 'example_segment')
      xml.sub!('NAME', name)
      Nokogiri::XML(xml,&:noblanks).to_s
    end
    
    def to_fsh
      fsh = []
      fsh << "exampleSegment.name = #{name.inspect}"
      fsh
    end
    
    def resource_description
       if description && description.strip[0]
         xml = HL7.get_instance_template(:common, 'description').sub('VALUE', "<p>#{description.strip}</p>")
         Nokogiri::XML(xml,&:noblanks).root.to_s
       else
         ''
       end
    end
    
    def same_as?(other)
      other.class == self.class &&
      other.name == self.name && 
      other.description == self.description
    end
    
    def diff(other)    
      if same_as?(other)
        puts simple_render.pretty_inspect
      else
        puts Rainbow(simple_render.pretty_inspect).yellow
        puts Rainbow(other.simple_render.pretty_inspect).green
      end
    end
    
    def simple_render(indent = 0)
      out = " #{name} "
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
end
