module HL7::V2
  class Event
    
    def local_url_name
      code.downcase.gsub(/[^a-z\d]/, '-')
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
