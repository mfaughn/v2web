require 'terminal-table'
module HL7
  class SegmentSequence
    def to_resource
      xml = HL7.get_instance_template(:message_structure, 'sequence')
      xml.sub!('NAME', resource_name)
      segments_xml = []
      segments.each { |seg| segments_xml << seg.to_segment_entry }
      xml.sub!('SEGMENT_ENTRIES', segments_xml.join)
      Nokogiri::XML(xml) { |config| config.strict.noblanks }.root.to_s
    end
    
    def to_fsh
      fsh = []
      fsh << "sequence.name = #{name.inspect}" if name && !name.strip.empty?
      segments.each_with_index do |seg, index|
        seg_fshs = seg.to_segment_entry_fsh
        seg_fshs.each do |seg_fsh|
          fsh << "sequence.segmentEntry[#{index}].#{seg_fsh}"
        end
      end
      fsh
    end
    
    def resource_name
      if name && name.strip[0]
        HL7.get_instance_template(:common, 'name').sub('VALUE', name)
      else
        ''
      end
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
end # module HL7
