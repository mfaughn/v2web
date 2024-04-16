module V291
  module_function
  
  def message_registry
    @mr ||= {}
  end
  
  def register_message(message)
    if message_registry[message.code]
      raise "#{message.code} is already registered!" unless message.code =~ /Znn/ #['RDY^Znn^RDY_K15'].include?(message)
    else
      message_registry[message.code] = message
    end
  end
  
  def register_messages
    v2.messages.each do |msg|
      register_message(msg)
    end
  end
  
  def translate_message_types
    ack_type = nil
    v2.message_types.values.each do |mt|
      if mt.code == 'ACK'
        ack_type = true 
        puts Rainbow("Creating ACK Sequel MessageType").plum
      end
      ctstart
      obj = HL7::V2::MessageType.new
      obj.code = mt.code
      obj.name = mt.name
      obj.save
      ctcommit
      mt.sequel = obj
    end
    raise "No ACK message type" unless ack_type
  end

  def create_v2_message_obj(msg, no_struct = false)
    struct = msg.message_structure&.sequel
    unless struct
      raise "#{msg.code} has no struct" unless no_struct
    end
    mt = msg.message_type&.sequel
    unless mt
      puts "There is no sequel for #{msg.message_type.code}. Section #{msg.section}"
      raise "#{msg.code} has no message type"
    end
    ctstart
    obj = HL7::V2::Message.new
    unless mt
      puts Rainbow("No message type for #{msg.code}").orange
    end
    obj.message_type = mt
    obj.structure = struct unless no_struct
    obj.save
    ctcommit
    msg.sequel = obj
    obj
  end

  def check_messages
    v2.messages.each do |msg|
      next if msg.sequel || msg.withdrawn?
      ec = msg.event_code
      create_v2_message_obj(msg) unless ['E30', 'E31'].include?(ec)
      puts Rainbow("Message without sequel obj: #{msg.code} from #{msg.section}").orange
    end
  end

  def find_ack_or_response_message(code, ac)
    type_code, event_code, structure_code = code.split('^').map(&:strip)
    message_type = HL7::V2::MessageType.where(code:type_code).first
    unless message_type
      puts "Can't find message type for #{code}"
    end
    begin
      messages = message_type.messages.select { |m| m.code == code }
    rescue
      puts Rainbow("No message type for #{type_code} in #{code} from section #{ac.section}").red
      return nil
    end
    if messages.size > 1
      raise "Multiple messages with code #{code}"
    end
    if messages.size < 1
      return nil if code =~ /ACK\^...\^ACK/ # Why? Because the caller will create a new message if this returns nil.
      puts "Ack Chor #{ac.for.map(&:section)}"
      puts ac.original_acks.inspect
      puts ac.msh15_acks.inspect
      puts ac.msh16_acks.inspect
      puts "Message Type: #{message_type.code} has messages: #{message_type.messages.map(&:code).sort}"
      puts
      if code == 'RTB^Znn^RTB_Knn'
        rtbznn = v2.messages.find { |m| m.code == code }
        if rtbznn
          # puts Rainbow('FOUND IT').orange
          # puts rtbznn.message_type.code
          rtbs = v2.message_types.select { |code, mt| mt.code == 'RTB' }
          rtbs.each do |code, mt|
            puts "Message Type: #{mt.code} has messages:"
            mt.messages.each do |msg|
              puts "#{msg.code} #{!!msg.sequel}"
            end
          end
        end
      end
      raise "No message with code #{code} for AC for #{ac.for.map { |msg| msg.code }}" unless code =~ /nn/
    end
    # normal case
    messages.first
  end
  
end
