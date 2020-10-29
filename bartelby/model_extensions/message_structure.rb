module V2Plus

  class MessageStructure  
    # attr_accessor :url, :code, :segments
    
    alias_method :name, :code
    
    def self.make(data)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      this = new
      this.code = data['messageType'].first['value']
      this.url  = data['url'].first['value']
      this.segments = data['segmentEntry']&.map do |entry|
        seg = V2Plus.make_segment(entry)
        unless seg
          pp data['segmentEntry']
          raise "No seg for #{this.code}"
        end
        seg
      end
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
      locals = {
        # FIXME
        :message_structure_page => 'http://www.hl7.eu/refactored/msg.html#msgstruct',
        :caption      => "HL7 MessageStructure Table - #{code}",
        :code         => code,
        :segment_rows => segment_rows
      }
      table = V2Plus.render_with_locals(:message_structure, :table, locals)
      V2Plus.save_web_file("message-structure-#{code}.html", table)
    end
    
    def segment_rows
      rows = []
      segments.each_with_index do |seg, i|
        rows << seg.to_message_row(i == segments.size - 1)
      end
      rows.join("\n")
    end
  end
  
end
