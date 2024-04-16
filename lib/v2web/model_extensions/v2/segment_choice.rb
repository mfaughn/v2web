module HL7::V2
  class SegmentChoice < AbstractSegment
  
    def info
      segs_info = segments.map { |seg| seg.info }.join("\n")
      "< -- #{name} begin\n#{segs_info}\n> -- #{name} end"
    end
  
    def to_message_row(is_last, icons = [])
      # puts
      # puts Rainbow(info).green
      icon = is_last ? JOIN_END : JOIN
      or_row_locals = {:icon => (is_last ? BLANK : LINE), :icons => icons, :row_id => row_id+'or'}
      locals = {
        :row_id       => row_id,
        :icon         => icon,
        :icons        => icons,
        :name         => name,
        :segment_rows => segment_rows(is_last, icons).join(or_row(or_row_locals))
      }.merge(common_locals)
      row = V2Pub.render_with_locals(:message_structure, :segment_choice, locals)
    end
  
    def or_row(locals)
      "\n" + V2Pub.render_with_locals(:message_structure, :or_row, locals) + "\n"
    end
  
    def same_as?(other)
      # puts Rainbow("A: #{self.class} / B: #{other.class}\nA: #{segments.count} / B: #{other.segments.count}").orange
      other.class == self.class &&
      other.segments.count == segments.count &&
      segments.zip(other.segments).all? do |a,b|
        # puts Rainbow(a.simple_render).cyan
        # puts Rainbow(b.simple_render).blue
        a.same_as?(b)
      end
    end
  
    def diff(other)    
      if same_as?(other)
        puts simple_render.pretty_inspect
      else
        segments.zip(other.segments).each { |a,b| a.diff(b) }
      end
    end
  
    def simple_render(indent = 0)
      out = []
      out += ['  '*indent + '<', ""]
      segments.each { |seg| out += seg.simple_render(indent + 1)}
      out += ['  '*indent + '>', ""]
    end
  
  end
end
