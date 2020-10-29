module V2Plus

  class Event 
    # How distinguish b/w response and ack ? FIXME
    def self.make(data)
      this = new
      this.code = data['code'].first['value']
      this.url  = data['url'].first['value']
      this.name = data['name'].first['value']
      FHIR2Obj.registry[:events][this.url][:obj] = this
      this.trigger  = FHIR2Obj.get_message_definition(data['message'].first['value'])
      this.response = data['acknowledgment']&.map do |ack|
        msg_def = FHIR2Obj.get_message_definition(ack['value'])
        puts "No definition for #{ack['value']}" unless msg_def
        msg_def
      end
      puts info unless this.response
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
