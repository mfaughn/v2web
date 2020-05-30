
def find_acks(msgs)
  acks = []
   msgs.each do |msg|
    segs = msg.segments
    next unless segs[0].is_a?(HL7::Segment)
    next unless segs[1].is_a?(HL7::Segment)
    next unless segs[2].is_a?(HL7::Segment)
    next unless segs[3].is_a?(HL7::Segment)
    next unless segs[4].is_a?(HL7::Segment)
    next unless segs[0].type.code == 'MSH'
    next unless segs[1].type.code == 'SFT'
    next unless segs[2].type.code == 'UAC'
    next unless segs[3].type.code == 'MSA'
    next unless segs[4].type.code == 'ERR'
    next unless segs[0].optional == false
    next unless segs[1].optional == true
    next unless segs[2].optional == true
    next unless segs[3].optional == false
    next unless segs[4].optional == true
    next unless segs[0].repeat == false
    next unless segs[1].repeat == true
    # next unless segs[2].repeat == true
    next unless segs[3].repeat == false
    # next unless segs[4].repeat == true
    next if segs[5]
    acks << msg
  end
  acks
end
def ackprobs(msgs)
  found_acks = find_acks(msgs)
  puts found_acks.count

  acs = HL7::AcknowledgmentChoreography.all;

  # ackacs = found_acks.map(&:acknowledgment_choreography).compact
  ackacs = acs.select { |ac| ac.for.name =~ /ACK|Response|Acknowledg/ } - found_acks.map(&:acknowledgment_choreography).compact ;

  puts ackacs.count

  weirdos = ackacs.select { |ac| ac.msh15_acks.count > 0 }
  weirdos.map {|w| "Ch. #{w.for.origin} -- #{w.for.name}"}.sort
end
def acksforapp(msgs)
  acks = find_acks(msgs)
  acs = HL7::AcknowledgmentChoreography.all;
  app_acks = []
  acs.each do |ac|
    app_acks << ac.for if ac.msh16_acks.find do |msg|
      acks.include?(msg)
    end
  end
  app_acks
end

def find_response_msgs(msgs = nil)
  msgs ||= HL7::Message.all;
  ackmsgs = find_acks(msgs)
  # puts "Found #{ackmsgs.count} ack messages"
  responses = (msgs - ackmsgs).select { |m| m.as_msh16_count > 0 && m.segments_count > 0 }
  report = []
  responses.each { |r| report << "#{r.origin} - #{r.name}" }
  puts report.sort
  responses
end

def responses_with_application_acks(responses = nil)
  responses ||= find_response_msgs
  report = []
  rwaa = []
  no_ac = []
  responses.each do |r|
    ac = r.acknowledgment_choreography
    if ac
      # if ac.msh16_acks_count > 0
      unless ac.ack_immediate
        if ac.original_acks_count > 0
          rwaa << r
          # report << "#{r.origin} - #{r.name} --> #{ac.msh16_acks.map(&:name) }"
          report << "#{r.origin} - #{r.name} --> #{ac.original_acks.map(&:name) }" 
        end
      end
    else
      no_ac << Rainbow("#{r.origin} - #{r.name}").orange
    end
  end
  puts no_ac.sort
  puts report.sort
  rwaa
end

def acksforapp2(msgs)
  
  app_acks = []
  msgs.each do |msg|
    app_acks << msg if msg.as_msh16.any?
  end
  app_acks
end

def acksforapp3(msgs)
  acs = HL7::AcknowledgmentChoreography.all;
  app_acks = []
  acs.each do |ac|
    app_acks << ac.msh16_acks
  end
  app_acks.flatten.uniq.compact
end

def orig_vs_enhanced
  odd = []
  acs = HL7::AcknowledgmentChoreography.all;
  acs.each do |ac|
    # odd << "#{ac.for.origin} - #{ac.for.name} - #{ac.msh15_acks.map(&:name).join(', ')}" if ac.ack_immediate == true
    odd << "#{ac.for.origin} - #{ac.for.name}" if ac.ack_immediate == true && ac.msh15_acks_count == 0
  end
  puts odd
end
      
