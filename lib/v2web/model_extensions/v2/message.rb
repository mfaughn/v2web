module HL7::V2
  class Message

    alias_method :trigger, :trigger_for
    alias_method :ack_for, :ack_to
    alias_method :response_to, :response_for

    def code
      "#{message_type&.code}^#{event_code}^#{structure&.code.to_s.gsub(/-.*/, '')}" # The gsub shouldn't be necessary after message structures are consolidated (i.e. all of the message structures that are supposed to be identical actually are identical)
    end
        
    def local_url_name
      url_name = code.dup
      url_name << "-#{event_code}" if event_code
      url_name.downcase.gsub(/[^a-z\d]/, '-')
    end
  
    def event_code
      (trigger_for || response_for.first&.trigger_for || ack_for.first&.trigger_for)&.code
    end

    def ack_chor
      self.acknowledgment_choreography
    end
    
    def z_messages
      ['QSB^Z83^QSB_Q16', 'RDR^RDR^RDR_RDR', 'RSP^Z82^RSP_Z82', 'RSP^Z86^RSP_Z86', 'QBP^Z87^QBP_Q11', 'RSP^Z88^RSP_Z88', 'QBP^Z89^QBP_Q11', 'RSP^Z90^RSP_Z90', 'RTB^Z92^RTB_K13', 'RTB^Z94^RTB_K13', 'RTB^Z96^RTB_K13', 'RDY^Z98^RDY_K15', 'RDY^Z80^RDY_Z80', 'RTB^Z78^RTB_K13', 'RTB^Z76^RTB_K13', 'UDM^Q05^UDM_Q05', 'ACK^Q05^ACK'
      ]
    end
    
    def to_tabs
      return '' if code =~ /ACK/
      tabset = V2Pub::TabSet.new(tabset_id)
      tabset.add_tab(V2Pub::Tab.new('Message Structure', structure.to_table))
      # Dirty hack to deal with example message
      begin
        tabset.add_tab(V2Pub::Tab.new('Acknowlegment Choreography', ack_chor_html))
      rescue
        raise unless name =~ /#{z_messages.map { |zm| Regexp.escape(zm) }.join('|')}/
      end
      
      # TODO do we have to hard-code location of XSD directory?
      xsd_file_name = complete_code.split('^').last.upcase + '.xsd'
      xsd_file = File.join(V2Pub.xsd_dir, xsd_file_name)
      if File.exist?(xsd_file)
        # puts xsd_file_name
        tabset.add_tab(V2Pub::Tab.new('v2.xml XSD', File.read(xsd_file), :file => 'v2xsd/' + xsd_file_name))
      else
        puts Rainbow("Missing #{xsd_file}").yellow
      end
      locals = {
        :tabs_caption => name,
        :tabs_content => tabset.to_pub
      }
      V2Pub.render_with_locals(:message, :tabs_wrapper, locals)
    end
  
    def ack_chor_html
      if ack_chor.nil?
        puts Rainbow("Message '#{self.code} - #{self.name}' does not have an acknowledgment_choreography!").orange
        return ''
      end
      ack_chor.to_composition_tab_entry
    end
  
    # FIXME this should be driven by event and message structure instead of name
    def complete_code
      name.slice(/^[A-Z0-9\^_]+/)
    end
  
    def html_id
      complete_code.downcase.gsub('^', '-')
    end
      
    def tabset_id
      'tabs-' + html_id
    end
    
  end
end
