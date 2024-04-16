require 'terminal-table'
module HL7::V2
  class MessageStructure  
    # attr_accessor :url, :code, :segments
    
    alias_method :name, :code
    alias_attribute(:name, :code)
    # alias_column(:name, :code)
    
    def info
      str = [Rainbow("Message Structure: #{code} - #{url}").magenta, "Segments:"]
      segments.each { |seg| str << seg.info }
      str.join("\n")
    end
    
    def local_url_name
      code.downcase.gsub(/[^a-z\d]/, '-')
    end
    
    def to_web_pub
      # table = to_pub
      V2Pub.save_web_file("message-structure/#{code}.html", to_table)
    end
        
    def to_table
      locals = {
        # FIXME
        :message_structure_page => 'message-structures.html',
        :caption      => "HL7 MessageStructure Table - #{code}",
        :code         => code,
        :table_id     => table_id,
        :segment_rows => segment_rows
      }
      @table = V2Pub.render_with_locals(:message_structure, :table, locals)
    end
    
    def segment_rows
      rows = []
      segments.each_with_index do |seg, i|
        rows << seg.to_message_row(i == segments.size - 1)
      end
      rows.join("\n")
    end
    
    def table_id
      code.downcase + '-table'
    end
    
    def row_id
      code.downcase
    end
    
    def diff(other)
      segment_pairs = segments.zip(other.segments)
      segment_pairs.each do |a,b|
        a.diff(b)
      end
    end
  
    def simple_render
      puts "#{self.class} #{code}"
      puts Terminal::Table.new(:rows => _simple_render_segments)
    end
  
    def _simple_render_segments
      segs = []
      segments.each { |seg| segs += seg.simple_render }
      segs
    end
    
  end  
end
