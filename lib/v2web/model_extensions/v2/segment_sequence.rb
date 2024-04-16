require 'terminal-table'
module HL7::V2
  class SegmentSequence < AbstractSegment
    
    def info
      segs_info = segments.map { |seg| seg.info }.join("\n")
      if repeat && optional
        "[{ -- #{name} begin\n#{segs_info}\n}] -- #{name} end"
      elsif optional
        "[ -- #{name} begin\n#{segs_info}\n] -- #{name} end"
      elsif repeat
        "{ -- #{name} begin\n#{segs_info}\n} -- #{name} end"
      else
        raise "What's going on here?"
      end
    end

    def to_message_row(is_last, icons = [])
      icon = is_last ? JOIN_END_OPEN : JOIN_OPEN
      locals = {
        :row_id       => row_id,
        :icon         => icon,
        :icons        => icons,
        :name         => name,
        :segment_rows => segment_rows(is_last, icons).join("\n")
      }.merge(common_locals)
      row = V2Pub.render_with_locals(:message_structure, :segment_sequence, locals)
    end
  
    def same_as?(other)
      other.class == self.class &&
      # other.name.to_s.downcase.strip == name.to_s.downcase.strip &&
      other.segments.count == segments.count &&
      segments.zip(other.segments).all? { |a,b| a.same_as?(b) }
    end
  
    def diff(other)    
      if same_as?(other)
        puts simple_render.pretty_inspect
      else
        if name == other.name
          puts _diff_start
          segments.zip(other.segments).each { |a,b| a.diff(b) }
          puts _diff_end
        else
          puts Rainbow(_diff_start).yellow
          puts Rainbow(other._diff_start).green
          segments.zip(other.segments).each { |a,b| a.diff(b) }
          puts Rainbow(_diff_end).yellow
          puts Rainbow(other._diff_end).green
        end
      end
    end
  
    def _diff_start
      first = ''
      if repeat && optional
        first = '[{'
      elsif repeat
        first = '{'
      elsif optional
        first = '['
      else
        raise "How can a SegmentSequence not repeat or be optional?"
      end
      [[first, "--- #{name} begin"]]
    end
  
    def _diff_end
      last  = ''
      if repeat && optional
        last  = '}]'
      elsif repeat
        last = '}'
      elsif optional
        last = ']'
      end
      [[last, "--- #{name} end"]]
    end
  
    def simple_render(indent = 0)
      out   = []
      middle = []
      segments.each { |seg| middle += seg.simple_render(indent + 1)}
      first = ''
      last  = ''
      if repeat && optional
        first = '[{'
        last  = '}]'
      elsif repeat
        first = '{'
        last  = '}'
      elsif optional
        first = '['
        last  = ']'
      else
        puts Terminal::Table.new(:rows => middle)
        raise "How can a SegmentSequence not repeat or be optional?"
      end
      out += [['  '*indent + first, "--- #{name} begin"]]
      out += middle
      out += [['  '*indent + last, "--- #{name} end"]]
    end
  end
end
