module HL7::V2
  class Segment < AbstractSegment

    def info
      if repeat && optional
        "[{ #{type.code} }]"
      elsif optional
        "[ #{type.code} ]"
      elsif repeat
        "{ #{type.code} }"
      else
        type.code
      end
    end
  
    def any_segment
      unless type
        puts inspect
        puts containing_structure.code.inspect
        puts containing_structure.origin.inspect
      end
      type.name == 'Hxx'
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
  
    def to_message_row(is_last, icons = [])
      icon = is_last ? JOIN_END : JOIN
      locals = {
        :row_id  => row_id,
        :icon    => icon,
        :icons   => icons,
        :code    => type.code,
        :seg_url => "segment-definition/#{type.code}.html"
      }.merge(common_locals)
      puts caller if icons == false
      row = V2Pub.render_with_locals(:message_structure, :segment, locals)
    end
  
  end
end
