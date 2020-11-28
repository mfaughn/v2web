module V2Plus
  class Message    
    def self.make(doc, identifier = nil)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      this = new
      nodeset   = doc.css('MessageDefinition')
      this.name = nodeset.get_val('name')
      this.code = nodeset.get_val('code')
      this.url  = nodeset.get_val('url')
      structure_url  = nodeset.get_val('structure')
      begin
        this.structure = V2Plus::MessageStructure.get(structure_url)
      rescue
        puts doc
        raise
      end
      this
    end
    
    def ack_chor
      ac_id = url.split('/').last
      ac = V2Plus::AcknowledgmentChoreography.get(ac_id)
      self.acknowledgment_choreography = ac
      # puts "#{name} got ack_chor? #{!!ac}.  AC got msg? #{!!(ac&.for)}"
      ac
    end
    
    def z_messages
      ['QSB^Z83^QSB_Q16', 'RDR^RDR^RDR_RDR', 'RSP^Z82^RSP_Z82', 'RSP^Z86^RSP_Z86', 'QBP^Z87^QBP_Q11', 'RSP^Z88^RSP_Z88', 'QBP^Z89^QBP_Q11', 'RSP^Z90^RSP_Z90', 'RTB^Z92^RTB_K13', 'RTB^Z94^RTB_K13', 'RTB^Z96^RTB_K13', 'RDY^Z98^RDY_K15', 'RDY^Z80^RDY_Z80', 'RTB^Z78^RTB_K13', 'RTB^Z76^RTB_K13', 'UDM^Q05^UDM_Q05', 'ACK^Q05^ACK'
      ]
    end
    
    def to_tabs
      tabset = V2Plus::TabSet.new(tabs1_id)
      tabset.add_tab(V2Plus::Tab.new('Message Structure', structure.to_table))
      # Dirty hack to deal with example message
      begin
        tabset.add_tab(V2Plus::Tab.new('Acknowlegment Choreography', ack_chor_html))
      rescue
        raise unless name =~ /#{z_messages.map { |zm| Regexp.escape(zm) }.join('|')}/
      end
      tabset.to_composition_content
      # locals = {
      #   :tabs1_id => ,
      #   :message_structure => structure.to_table,
      #   :ack_chor => ack_chor_html
      # }
      # tabs = V2Plus.render_with_locals(:message, :tabs1, locals)
    end
  
    def ack_chor_html
      ack_chor.to_composition_tab_entry
    end
  
    # FIXME this should be driven by event and message structure instead of name
    def complete_code
      name.slice(/^[A-Z0-9\^_]+/)
    end
  
    def html_id
      complete_code.downcase.gsub('^', '-')
    end
      
    def tabs1_id
      'tabs-' + html_id
    end
  end
end

