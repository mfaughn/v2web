module HL7
  class AcknowledgmentChoreography
    def local_url_name
      self.for.local_url_name
    end
    
    def url_name
      'http://v2.hl7.org/fhir/AcknowledgmentChoreography/' + local_url_name
    end
    
    def to_resource
      xml = HL7.get_instance_template(:acknowledgment_choreography, 'base')
      xml.sub!('URL'              , local_url_name)
      xml.sub!('SUBJECT_URL'      , self.for.local_url_name)
      xml.sub!('ORIGINAL_ACK_TYPE', resource_original_ack_type)
      xml.sub!('ORIGINAL_ACK'     , resource_original_ack)
      xml.sub!('MSH15VALUES'      , resource_msh15values)
      xml.sub!('IMMEDIATE_ACKS'   , resource_enhanced_imm_ack)
      xml.sub!('MSH16VALUES'      , resource_msh16values)
      xml.sub!('APPLICATION_ACKS' , resource_enhanced_app_ack)
      Nokogiri::XML(xml,&:noblanks).to_s
    end
    
    def resource_original_ack_type
      if original_acks.any?
        'none'
      else
        ack_immediate ? 'immediate' : 'application'
      end
    end
    
    def resource_msh15values
      vals = []
      ack_type = msh15&.value
      if ack_type == 'Never'
        vals << 'NE'
      elsif ack_type == 'Always'
        vals << 'AL'
      else
        vals = ['NE', 'AL', 'ER', 'SU']
      end
      xml = []
      vals.each do |val|
        xml << HL7.get_instance_template(:acknowledgment_choreography, 'msh15val').sub('VALUE', val)
      end
      xml.join("\n")
    end
    
    def resource_msh16values
      vals = []
      ack_type = msh16&.value
      if ack_type == 'Never'
        vals << 'NE'
      elsif ack_type == 'Always'
        vals << 'AL'
      else
        vals = ['NE', 'AL', 'ER', 'SU']
      end
      xml = []
      vals.each do |val|
        xml << HL7.get_instance_template(:acknowledgment_choreography, 'msh16val').sub('VALUE', val)
      end
      xml.join("\n")
    end
    
    def resource_original_ack
      if original_acks.any?
        HL7.get_instance_template(:acknowledgment_choreography, 'original_ack').sub('MESSAGE_URL', original_acks.first.local_url_name)
      else
        ''
      end
    end
    
    def resource_enhanced_imm_ack
      if msh15_acks.any?
        xml = []
        msh15_acks.each do |msg|
          xml << HL7.get_instance_template(:acknowledgment_choreography, 'enhanced_imm_ack').sub('MESSAGE_URL', msg.local_url_name)
        end
        xml.join("\n")
      else
        ''
      end
    end
    
    def resource_enhanced_app_ack
      if msh16_acks.any?
        xml = []
        msh16_acks.each do |msg|
          xml << HL7.get_instance_template(:acknowledgment_choreography, 'enhanced_app_ack').sub('MESSAGE_URL', msg.local_url_name)
        end
        xml.join("\n")
      else
        ''
      end
    end
    
  end
end # module HL7
