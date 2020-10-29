module V2Plus

  class AcknowledgmentChoreography
    
    # FIXME imm_ack_name, app_ack_name ?
    def self.make(data)
      this = new
      this.url     = data['url'].first['value']
      FHIR2Obj.registry[:acks][this.url][:obj] = this
      subj = data['subject']&.first&.[]('value')
      this.for = FHIR2Obj.get_message_definition(subj) if subj
      unless this.for
        puts "No definition for #{subj}" unless this.subject
      end
      
      # FIXME ack_immediate is a Boolean
      this.ack_immediate = data['originalModeAckType']&.map { |v| v['value'] }
      omas = data['originalModeAcknowledgement']&.map { |ack| get_msg_def(ack) }
      this.original_acks = [omas].flatten.compact
      
      this.msh15 = data['msh15AllowedValue']&.map { |v| v['value'] }.first
      emias = data['enhancedModeImmediateAcknowledgment']&.map { |ack| get_msg_def(ack) }
      this.msh15_acks = [emias].flatten.compact
      
      this.msh16 = data['msh16AllowedValue']&.map { |v| v['value'] }.first
      emaas = data['enhancedModeApplicationAcknowledgment']&.map { |ack| get_msg_def(ack) }
      this.msh16_acks = [emaas].flatten.compact
      this
    end
    
    def self.get_msg_def(url)
      msg_def = FHIR2Obj.get_message_definition(url['value'])
      puts "No Message Definition for #{url['value']}" unless msg_def
      msg_def
    end

  end
end
