module V2Plus

  class AcknowledgmentChoreography
    
    # FIXME imm_ack_name, app_ack_name ?
    def self.make(doc, identifier)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      # array_type ? FIXME
      this = new
      node = doc.at_css('AcknowledgmentChoreography')
      subj = node.get_val('subject')
      # this.for = 'FIXME' if subj  # should get populated by reciprocal adder method
      # unless this.for
      #   puts "No definition for #{subj}" unless this.subject
      # end
      
      # FIXME ack_immediate is a Boolean
      this.ack_immediate = node.get_val('originalModeAckType')
      # omas = node.css('originalModeAcknowledgement')
      #            .map { |n| n['value'] }
      #            .map { |ack| get_msg_def(ack) }
      this.original_acks = get_ack_messages(node, 'originalModeAcknowledgement')
      
      this.msh15 = node.css('msh15AllowedValue').map { |v| v['value'] } # array of strings represented enums
      # emias = node.css('enhancedModeImmediateAcknowledgment').map { |v| v['value'] }.map { |ack| get_msg_def(ack) }
      this.msh15_acks = get_ack_messages(node, 'enhancedModeImmediateAcknowledgment')
      
      this.msh16 = node.css('msh16AllowedValue').map { |v| v['value'] }
      # emaas = node.css('enhancedModeApplicationAcknowledgment').map { |v| v['value'] }.map { |ack| get_msg_def(ack) }
      this.msh16_acks = get_ack_messages(node, 'enhancedModeApplicationAcknowledgment')
      # if this.msh16_acks.empty? && this.msh15_acks.empty? && this.original_acks.empty?
      #   puts doc
      #   puts Rainbow(this.original_acks).cyan
      #   puts Rainbow(this.msh15).green
      #   puts Rainbow(this.msh16).orange
      #   raise
      # end
      this
    end
    
    def self.get_ack_messages(node, type)
      node.css(type).map { |n| n['value'] }.map { |ack| get_msg_def(ack) }.compact
    end
    
    def self.get_msg_def(url)
      msg_def = V2Plus::Message.get(url)
      puts "No Message Definition for #{url['value']}" unless msg_def
      msg_def
    end
    
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
        :imm_ack   => msh15 != ['NE'],
        :imm_acks  => msh15_acks.map { |msg| get_msg_code(msg) }.join(' or '),
        :msh15vals => msh15.join(' or '),
        :neg15     => neg15,
        :app_ack   => msh16 != ['NE'],
        :app_acks  => msh16_acks.map { |msg| get_msg_code(msg) }.join(' or '),
        :msh16vals => msh16.join(' or '),
        :neg16     => neg16
      }
      html = V2Plus.render_with_locals(:acknowledgment_choreography, :entry, locals)
      html
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
      html = V2Plus.render_with_locals(:acknowledgment_choreography, :e_table, locals)
      html
      
    end
    
    def neg15
      negs = ['NE', 'AL', 'ER', 'SU'] - msh15
      if negs.any?
        negs.join(' or ')
      else
        nil
      end
    end
    
    def neg16
      negs = ['NE', 'AL', 'ER', 'SU'] - msh16
      if negs.any?
        negs.join(' or ')
      else
        nil
      end
    end
    
    def o_ack
      # puts "OACK: #{ack_immediate.to_s.inspect}"
      case ack_immediate.to_s.strip
      when 'none'
        return 'An Acknowlegment is never sent in original mode.'
      when 'immediate', ''
        return "Immediate Ack: #{original_acks.map { |msg| get_msg_code(msg) }.join(' or ')}"
      when 'application'
        return "Application Ack: #{original_acks.map { |msg| get_msg_code(msg) }.join(' or ')}"
      else
        raise ack_immediate.inspect
      end
    end
    
    def get_msg_code(msg)
      msg.name.slice(/^[A-Z0-9_\^]+/)
    end
    
    def code
      # @code ||= "#{self.for.code}_#{self.for.event_code}" # FIXME this should work!
      return @code if @code
      x = self.for.name.slice(/^[A-Z0-9]{3}\^[A-Z0-9]{3}\^[A-Z0-9]{3}_[A-Z0-9]{3}/)
      x ||= self.for.name.slice(/^ACK\^[A-Z0-9]{3}\^ACK/)
      puts self.for.name unless x
      @code = x
    end
    
    def html_id
      "#{code.downcase}-acknowledgment-choreography"
    end

  end
end
