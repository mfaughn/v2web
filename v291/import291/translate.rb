module V291
  module_function
  
  def translate(no_reset = false)
    reset_v2 unless no_reset
    # extract(true) # This shouldn't be here?
    puts Rainbow("Translating v2.9.1").plum
    translate_texts
    puts Rainbow("Texts done").cornflower
    # translate_sections
    # FIXME need to translate all V2AD::Text into a RichText .... or just use a RichText to begin with
    translate_datatypes
    puts Rainbow("Datatypes done").cornflower
    # dt2 = HL7::V2::DataType.all;
    # puts "And now there are #{dt2.size} data types of type #{dt2.first.class}"
    translate_seg_defs
    puts Rainbow("Seg Defs done").cornflower
    translate_message_types
    puts Rainbow("MessageTypes done").cornflower
    translate_message_structures
    puts Rainbow("MessageStructures done").cornflower
    translate_events
    puts Rainbow("Events done").cornflower
    check_messages
    puts Rainbow("Messages checked").cornflower

    register_messages
    
    translate_ack_chors
    # translate_ack_chors_old
    puts Rainbow("Ack Chors done").cornflower
    puts Rainbow("FINISHED Translating v2.9.1").plum
  end
  
  def extract(reset = false)
    load '/Users/mrf/repos/v2-base/V2.9.1/Normative2/2023SEP_for_ballot/adoc/extract.rb' if  !(defined?(V291)) || reset
  end
  
  def reset_v2
    HL7::V2.classes.each do |klass|
      next unless klass.to_s =~ /HL7::V2::/
      DB[klass.table_name.to_sym].delete if DB.tables.include?(klass.table_name.to_sym)
    end
  end

end
