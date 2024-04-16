module V291
  module_function

  # TODO IMPORTANT! Make sure that data structures have been consolidated properly before doing this for final production.
  def translate_message_structures
    v2.message_structures.each do |code, data|
      multiples = data.size > 1
      suffix = 'A'
      data.each do |section, struct|
        ack_k13 = nil
        if code == 'ACK'
          ack_k13 = struct.messages.find { |msg| msg.code == 'ACK^K13^ACK' }
          # puts Rainbow("Found ACK^K13^ACK").cyan if ack_k13
        end
        ctstart
        obj = HL7::V2::MessageStructure.new
        if multiples
          obj.code = struct.code + '-' + suffix
          suffix.succ!
        else
          obj.code = struct.code
        end
        obj.save
        ctcommit
        segs = struct.segments.map { |seg| create_segment_obj(seg) }
        ctstart
        segs.each { |s| obj.add_segment(s) }
        ctcommit
        struct.sequel = obj
        # raise "How'd it go?"
      end
    end
  end
  
end
