module V2Plus

  class MessageStructure  
    # attr_accessor :url, :code, :segments
    
    alias_method :name, :code
    
    def self.make(doc, identifier = nil)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      this = new
      # puts doc.to_s
      nodeset   = doc.css('MessageStructure')
      this.code = nodeset.get_val('messageType')
      this.url  = nodeset.get_val('url')
      # nodeset.each { |n| puts n.name }
      seg_nodes = nodeset.children.select { |n| n.name == 'segmentEntry' }
      segment_objects = seg_nodes.map do |entry|
        seg = V2Plus.make_segment(entry)
        unless seg
          pp doc['segmentEntry']
          raise "No seg for #{this.code}"
        end
        seg
      end
      this.segments = segment_objects
      # puts this.inspect
      this
    end
    
    def info
      str = [Rainbow("Message Structure: #{code} - #{url}").magenta, "Segments:"]
      segments.each { |seg| str << seg.info }
      str.join("\n")
    end
    
    def sequel
      self.class.sequel.where(:code => code).first
    end
    
    def to_web_pub
      # table = to_composition_content
      V2Plus.save_web_file("message-structure-#{code}.html", to_table)
    end
        
    def to_table
      # return @table if @table
      locals = {
        # FIXME
        :message_structure_page => 'http://www.hl7.eu/refactored/msg.html#msgstruct',
        :caption      => "HL7 MessageStructure Table - #{code}",
        :code         => code,
        :table_id     => table_id,
        :segment_rows => segment_rows
      }
      @table = V2Plus.render_with_locals(:message_structure, :table, locals)
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
  end
  
end
