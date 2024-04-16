module HL7::V2
  class AcknowledgmentChoreography

    def to_composition_tab_entry
      to_composition_entry(4)
    end
  
    def to_composition_entry(depth)
      locals = {
        :html_id   => html_id,
        :msg_code  => code,
        :depth     => depth,
        :o_ack     => o_ack,
        :for_msg   => get_msg_code(self.for),
        :imm_ack   => msh15.to_s !~ /NE|Never/,
        :imm_acks  => msh15_acks.map { |msg| get_msg_code(msg) }.join(' or '),
        :msh15vals => _msh_vals(msh15),
        :neg15     => neg15,
        :app_ack   => msh16.to_s !~ /NE|Never/,
        :app_acks  => msh16_acks.map { |msg| get_msg_code(msg) }.join(' or '),
        :msh16vals => _msh_vals(msh16),
        :neg16     => neg16
      }
      html = V2Pub.render_with_locals(:acknowledgment_choreography, :entry, locals)
      html
    end
  
    def _msh_vals(ack_type)
      _msh_val(ack_type) || 'AL or ER or SU'
    end
  
    def _msh_val(ack_type)
      ack_type&.value&.sub('Always', 'AL')&.sub('Never', 'NE')
    end
  
    def e_mode_table
      locals = {
        :for_msg   => get_msg_code(self.for),
        :imm_ack   => msh15 != ['NE'],
        :imm_acks  => msh15_acks.map { |msg| get_msg_code(msg) }.join(' or '),
        :msh15vals => msh15.join(' or '),
        :neg15     => neg15,
        :app_ack   => msh16 != ['NE'],
        :app_acks  => msh16_acks.map { |msg| get_msg_code(msg) }.join(' or '),
        :msh16vals => msh16.join(' or '),
        :neg16     => neg16,
        :html_id   => html_id
      }
      html = V2Pub.render_with_locals(:acknowledgment_choreography, :e_table, locals)
      html
    
    end
  
    def neg15
      negs = ['NE', 'AL', 'ER', 'SU'] - [_msh_val(msh15)]
      if negs.any?
        negs.join(' or ')
      else
        nil
      end
    end
  
    def neg16
      negs = ['NE', 'AL', 'ER', 'SU'] - [_msh_val(msh16)]
      if negs.any?
        negs.join(' or ')
      else
        nil
      end
    end
  
    def o_ack
      return 'An Acknowlegment is never sent in original mode.' unless original_acks_count > 0
      # puts "OACK: #{ack_immediate.to_s.inspect}"
      if ack_immediate == true
        "Immediate Ack: #{original_acks.map { |msg| get_msg_code(msg) }.join(' or ')}"
      else
        "Application Ack: #{original_acks.map { |msg| get_msg_code(msg) }.join(' or ')}"
      end
    end
  
    def get_msg_code(msg)
      msg.name.slice(/^[A-Z0-9_\^]+/)
    end
  
    def code
      # @code ||= "#{self.for.code}_#{self.for.event_code}" # FIXME this should work!
      return @code if @code
      x = self.for.name.slice(/^[A-Z0-9]{3}\^([A-Z0-9]{3}|(Q|Z)nn)\^[A-Z0-9]{3}_([A-Z0-9]{3}|(Q|Z|K)nn)/)
      # x ||= self.for.name.slice(/^[A-Z0-9]{3}\^[A-Z0-9]{3}\^[A-Z0-9]{3}_(Q|Z)nn/)
      x ||= self.for.name.slice(/^ACK\^[A-Z0-9]{3}\^ACK/)
      puts self.for.name.inspect unless x
      @code = x
    end
  
    def html_id
      "#{code.downcase}-acknowledgment-choreography"
    end

    def local_url_name
      unless self.for
        # puts Rainbow(self.inspect).cyan
        return nil
      end
      self.for.local_url_name
    end

  end
end
