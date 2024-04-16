module V291
  module_function

  def translate_events
    v2.events.each do |key,arr|
      if arr.size != 1 && !(key == 'O59' || key == 'Znn') # FIXME deal with these correctly!
        raise "Too many events for #{key}"
      end
      suffix = nil
      suffix = 'A' if arr.size > 1
      arr.each do |ev|
        ctstart
        obj = HL7::V2::Event.new
        obj.name = ev.name
        if suffix
          # NOTE This should be subject to change based on input from V2MGMT
          obj.code = ev.code + '_' + suffix
          suffix.succ!
        else
          obj.code = ev.code
        end
        # puts ev._display + ' ' + ev.status if ev.status
        obj.withdrawn  = ev.status == 'W'
        obj.deprecated = ev.status == 'Deprecated'
        obj.save
        ctcommit
        ev.sequel = obj
      end
    end

    v2.events.values.each do |arr|
      if arr.size > 1
        puts "Event #{arr.first.code} has multiple instances."
      end
      arr.each do |ev|
        withdrawn = ev.status == 'W'
        undefined = (ev.code == 'E30' || ev.code == 'E31')
        next if undefined
        msg = ev.message
        mobj = create_v2_message_obj(msg, withdrawn)
        ctstart
        ev.sequel.message = mobj
        ctcommit

        next if withdrawn

        msg.responses.each do |respmsg|
          x = create_v2_message_obj(respmsg)
          ctstart
          mobj.add_response(x)
          ctcommit
        end

        if msg.ack
          x = create_v2_message_obj(msg.ack)
          ctstart
          mobj.ack = x
          ctcommit
        end
      end
    end
  end

end
