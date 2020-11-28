module V2Plus

  class Event 
    # How distinguish b/w response and ack ? FIXME
    def self.make(doc, identifier = nil)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      this = new
      nodeset = doc.css('Event')
      this.code = nodeset.get_val('code')
      this.url  = nodeset.get_val('url')
      this.name = nodeset.get_val('name')
      # FIXME!!!!!!
      this
    end
    
    def info
      str = [Rainbow("Event: #{code} - #{name} - #{url}").magenta]
      str << "Msg: #{trigger.code} - #{trigger.name}"
      if acks
        ack_info = acks.map { |ack| "#{ack.code} - #{ack.name}" }.join('; ')
        str << "Ack: #{ack_info}"
      else
        str << Rainbow('NO ACKS!').red
      end
      str.join("\n")
    end
  end
  
end
