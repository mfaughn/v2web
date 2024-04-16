module HL7::V2
  class ExampleSegment < AbstractSegment
  
    def info
      "#{name} -- EXAMPLE SEGEMENT -- #{description}"
    end
  
    def to_message_row(is_last, icons = [])
      icon = is_last ? JOIN_END : JOIN
      locals = {
        :row_id      => row_id,
        :icon        => icon,
        :icons       => icons,
        :name        => name,
        :description => description
      }.merge(common_locals)
      row = V2Pub.render_with_locals(:message_structure, :example_segment, locals)
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
