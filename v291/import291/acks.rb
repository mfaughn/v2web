module V291
  module_function

  def translate_ack_chors
    msgs = v2.messages
    acs  = {}
    msgs.each do |msg|
      acs[msg] = msg.ack_chor
    end
    acs.each do |msg, ac|
      next if msg.withdrawn?
      if ac
        translate_ack_chor(msg, ac)
      else
        puts "No AC for #{msg.code} from section #{msg.section}" unless msg.code =~ /Z\d\d/
      end
    end
  end
  
  def translate_ack_chor(for_msg, ac)
    sequel_for_msg = for_msg.sequel
    raise "No sequel msg for #{for_msg.code} in section #{for_msg.section}" unless sequel_for_msg
    attrs = [:ack_immediate, :imm_ack, :app_ack, :notes, :msh15, :msh16]#, :original_acks, :msh15_acks, :msh16_acks, :sequel]
    # puts Rainbow("AckChor for #{ac.for.map(&:code).join(' | ')}").gold if ac.ack_immediate
    # attrs.each do |a|
    #   puts "#{a} -- #{ac.send(a)}"
    # end
    ctstart
    obj = HL7::V2::AcknowledgmentChoreography.new
    obj.save
    ctcommit
    
    translate_original_acks(for_msg, sequel_for_msg, ac, obj)
    translate_msh15_acks(for_msg, sequel_for_msg, ac, obj)
    translate_msh16_acks(for_msg, sequel_for_msg, ac, obj)
    # FIXME add other +attributes+ [:ack_immediate, :imm_ack, :app_ack, :notes, :msh15, :msh16]
  end
    
  def translate_msh15_acks(for_msg, sequel_for_msg, ac, obj)
    msg_responses = (for_msg.responses + [for_msg.ack]).compact # V291
    # puts "#{for_msg.code} has #{msg_responses.size} responses."
    ac.msh15_acks.each do |code|
      msg = nil
      
      code = get_specific_code(code, for_msg) if code =~ /\^([A-Z][A-Z0-9]{2}(-|,))+[A-Z][A-Z0-9]{2}\^/
          
      puts Rainbow("AC for #{ac.for.first.code} covers multiple").yellow if code =~ /,|-/
      
      found_response = msg_responses.find { |r| r.code == code }
      # check if msg_responses is correct
      if found_response
        msg = found_response
        msg = msg.sequel if msg.is_a?(V2AD::Message)
        if msg
          ctstart
          obj.add_msh15_ack(msg)
          ctcommit
          next
        else
          raise "It appears that #{found_response.code} does not have a Sequel counterpart.  AC in section #{ac.section}"
        end          
      # else
      #   if code =~ /ACK/
      #     # just fall through and hope it works...we shall see
      #   else
      #     raise "msg_response codes #{msg_responses.map(&:code)} do not include #{code} from the AC in #{ac.section}"
      #   end
      end
      
      msg ||= message_registry[code]
      msg = msg.sequel if msg.is_a?(V2AD::Message)
      # puts "found #{code}" if msg
      
      if msg
        ctstart
        obj.add_msh15_ack(msg)
        ctcommit
        next
      else
        if code =~ /ACK\^...\^ACK/
          # FIXME created a new ack message.  Do we need to create an AckChor for this also or anything else??
          msg = create_v2_message_obj(V2AD.create_ack_message(for_msg)) # create a V291 ack message and from that a sequel obj ack message
          ctstart
          obj.add_msh15_ack(msg)
          ctcommit
          next
        else
          puts Rainbow("There was no message for #{code} that is specified for MSH-15 in the AC for #{for_msg.code} in section #{ac.section}").cornflower
        end
      end
    end
  end

  def translate_msh16_acks(for_msg, sequel_for_msg, ac, obj)
    msg_responses = (for_msg.responses + [for_msg.ack]).compact # V291
    
    ac.msh16_acks.each do |code|
      msg = nil
      
      code = get_specific_code(code, for_msg) if code =~ /\^([A-Z][A-Z0-9]{2}(-|,))+[A-Z][A-Z0-9]{2}\^/
          
      puts Rainbow("AC for #{ac.for.first.code} covers multiple").yellow if code =~ /,|-/
      
      found_response = msg_responses.find { |r| r.code == code }
      # check if msg_responses is correct
      if found_response
        msg = found_response
        msg = msg.sequel if msg.is_a?(V2AD::Message)
        if msg
          ctstart
          obj.add_msh16_ack(msg)
          ctcommit
          next
        else
          raise "It appears that #{found_response.code} does not have a Sequel counterpart.  AC in section #{ac.section}"
        end          
      # else
      #   if code =~ /ACK/
      #
      #     # just fall through and hope it works...we shall see
      #   else
      #     raise "msg_response codes #{msg_responses.map(&:code)} do not include #{code} from the AC in #{ac.section}"
      #   end
      end
      
      msg ||= message_registry[code]
      msg = msg.sequel if msg.is_a?(V2AD::Message)
      # puts "found #{code}" if msg
      
      if msg
        ctstart
        obj.add_msh16_ack(msg)
        ctcommit
        next
      else
        if code =~ /ACK\^...\^ACK/
          # FIXME created a new ack message.  Do we need to create an AckChor for this also or anything else??
          msg = create_v2_message_obj(V2AD.create_ack_message(for_msg)) # create a V291 ack message and from that a sequel obj ack message
          ctstart
          obj.add_msh16_ack(msg)
          ctcommit
          next
        else
          puts Rainbow("There was no message for #{code} that is specified for MSH-16 in the AC for #{for_msg.code} in section #{ac.section}").cornflower
        end
      end
    end
  end

  def translate_original_acks(for_msg, sequel_for_msg, ac, obj)
    # Hack fixes for instances where the ACK message in the chapter isn't used in original mode
    for_msg.ack = message_registry['ESU^U01^ESU_U01'] if ac.section == '13.2.2'
    for_msg.ack = message_registry['SSU^U03^SSU_U03'] if ac.section == '13.2.4'
    for_msg.ack = message_registry['INU^U05^INU_U05'] if ac.section == '13.2.6'
    for_msg.ack = message_registry['EAR^U08^EAR_U08'] if ac.section == '13.2.7'
    for_msg.ack = message_registry['TCU^U10^TCU_U10'] if ac.section == '13.2.11'
    for_msg.ack = message_registry['LSU^U12^LSU_U12'] if ac.section == '13.2.13'
    for_msg.ack = message_registry['INU^U05^INU_U05'] if ac.section == '13.2.14'
    for_msg.ack = message_registry['SLS^S28^SLR_S28'] if ac.section == '17.6.1'
    for_msg.ack = message_registry['SLS^S29^SLR_S28'] if ac.section == '17.6.2'
    for_msg.ack = message_registry['STS^S30^SLR_S28'] if ac.section == '17.6.3'
    for_msg.ack = message_registry['SDS^S31^SDR_S31'] if ac.section == '17.6.4'
    for_msg.ack = message_registry['SMS^S32^SDR_S32'] if ac.section == '17.6.5'
    
    msg_ack = for_msg.ack       # V291
    
    multi_original_acks = ac.original_acks.size > 1
    ac.original_acks.each do |code|
      msg = nil
      
      # Hack for Ch3 ADT issues
      if code =~ /ADT\^A(\d\d)\^ADT_A\d\d/
        correct = "ACK^A#{$1}^ACK"
        # puts "Replacing Ch3 original Ack mistake #{code} with #{correct}" # FIXME just be aware of this.  Should go away as we fix the source and / or confirm that this is a mistake in 2.9.1
        code = correct
      end
      
      # Hack to fix error in 11.5.1
      if code == 'RPI^I12-I15^RPI_I12'
        correct = 'RRI^I12-I15^RRI_I12'
        # FIXME just be aware of this.  Should go away as we fix the source and / or confirm that this is a mistake in 2.9.1
        code = correct
      end
      
      code = get_specific_code(code, for_msg) if code =~ /\^([A-Z][A-Z0-9]{2}(-|,))+[A-Z][A-Z0-9]{2}\^/
          
      puts Rainbow("AC for #{ac.for.first.code} covers multiple").yellow if code =~ /,|-/

      # check if msg_ack is correct
      if msg_ack
        # FIXME verify that this correction is what I should be doing
        code = 'ACK^R30^ACK' if code == 'ACK^R33^ACK' && msg_ack.code == 'ACK^R30^ACK'
          
        if code == msg_ack.code
          # puts "msg_ack matches.  adding."
          msg = msg_ack
          msg = msg.sequel if msg.is_a?(V2AD::Message)
          if msg
            ctstart
            obj.add_original_ack(msg)
            ctcommit
            next
          else
            raise "It appears that #{msg_ack.code} does not have a Sequel counterpart.  AC in section #{ac.section}"
          end          
        else
          if code == 'ORA^R33^ORA_R33'
            # just fall through and hope it works...we shall see
          else
            raise "msg_ack code #{msg_ack.code} is not the same as #{code} from the AC in #{ac.section}"
          end
        end
      end
      
      msg ||= message_registry[code]
      msg = msg.sequel if msg.is_a?(V2AD::Message)
      # puts "found #{code}" if msg
      
      if msg
        ctstart
        obj.add_original_ack(msg)
        ctcommit
        next
      else
        if code =~ /ACK\^...\^ACK/
          # FIXME created a new ack message.  Do we need to create an AckChor for this also or anything else??
          msg = create_v2_message_obj(V2AD.create_ack_message(for_msg)) # create a V291 ack message and from that a sequel obj ack message
          ctstart
          obj.add_original_ack(msg)
          ctcommit
          next
        else
          puts Rainbow("There was no message for #{code} that is specified in the AC for #{for_msg.code} in section #{ac.section}").cornflower
        end
      end
    end
    # if multi_original_acks
    #   puts "original_acks for #{for_msg.code} in section #{ac.section} has multiple codes: " + Rainbow("#{ac.original_acks}.").plum
    #   ooacks = obj.original_acks
    #   puts "Sequel AC now has #{ooacks.size} original acks: #{ooacks.map(&:code)}"
    # end
      # puts "original_acks for #{for_msg.code} in section #{ac.section} has codes: " + Rainbow("#{ac.original_acks}.").gold
      # ooacks = obj.original_acks
      # puts "Sequel AC now has #{ooacks.size} original acks: #{ooacks.map(&:code)}"
    
  end

  def create_missing_ack_message(code, ack_chor)
    struct = V291.general_ack_struct.sequel
    unless struct
      raise "No general ACK struct sequel obj :-("
    end
    mt = HL7::V2::MessageType.where(code:'ACK').first
    raise "No ACK MessageType" unless mt
    ctstart
    obj = HL7::V2::Message.new
    obj.message_type = mt
    obj.structure    = struct
    ctcommit
    fors = ack_chor.for
    if fors.size == 1
      first_for = fors.first
      if first_for.ack
        raise "Created an ack for #{first_for.code} but it already had an Ack - #{first_for.ack.code}.  See section #{first_for.section}."
      else
        ctstart
        fors.first.ack = obj
        ctcommit
        puts Rainbow("Created missing ACK message #{obj.code} referenced in AckChor for #{ack_chor.for.map(&:code)} is sections #{ack_chor.for.map(&:section)}").gold
      end
    else
      raise "Created an ack for an ack_chor with multiple fors.  Not sure what even to assign to Ack message.  Fors: #{fors.map(&:code)}"
    end
    obj
  end

  def get_specific_code(code, for_msg)
    eventcode = for_msg.code.split('^')[1]
    raise "Bad event code for #{msg.code} from section #{msg.section}" unless eventcode =~ /^...$/
    code_parts = code.split('^')
    ret = [code_parts.first, eventcode, code_parts.last].join('^')
    # puts "Get specific code for #{code} from #{for_msg.code}(#{eventcode}) --> #{ret}"
    ret
  end
  
end
