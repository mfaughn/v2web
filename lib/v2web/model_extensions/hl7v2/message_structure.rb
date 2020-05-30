require 'terminal-table'
module HL7
  class MessageStructure
    def local_url_name
      code.downcase.gsub(/[^a-z\d]/, '-')
    end
    
    def to_fsh
      fsh = []
      return fsh unless segments.any? # FIXME the QBP_Q21 message structure is bogus
      fsh << 'Instance: ' + local_url_name
      fsh << 'InstanceOf: MessageStructure'
      fsh << 'Title: ' + code.inspect
      fsh << 'Description: "Definition of the ' + code + 'Message Structure"'
      fsh << '* url  = "http://v2.hl7.org/fhir/MessageStructure/' + local_url_name + '"'
      fsh << '* code = #' + code
      segments.each_with_index do |seg, index|
        seg_fshs = seg.to_segment_entry_fsh
        seg_fshs.each do |seg_fsh|
          fsh << "* segmentEntry[#{index}].#{seg_fsh}"
        end
      end
      fsh << "\n"
      fsh.join("\n")
    end
        
    def to_resource
      xml = HL7.get_instance_template(:message_structure, 'base')
      xml.sub!('URL', local_url_name)
      [:code].each do |methd|
        xml.sub!(methd.to_s.upcase, send(methd).to_s)
      end
      segments_xml = []
      segments.each { |seg| segments_xml << seg.to_segment_entry }
      xml.sub!('SEGMENT_ENTRIES', segments_xml.join)
      Nokogiri::XML(xml,&:noblanks).to_s
    end
    
    def diff(other)
      segment_pairs = segments.zip(other.segments)
      segment_pairs.each do |a,b|
        a.diff(b)
      end
    end
    
    def simple_render
      puts "HL7::MessageStructure[#{id}] #{code}"
      puts Terminal::Table.new(:rows => _simple_render_segments)
    end
    
    def _simple_render_segments
      segs = []
      segments.each { |seg| segs += seg.simple_render }
      segs
    end
  end
end # module HL7
