module V291
  module_function
  
  def translate_texts
    v2.texts.each do |t|
      lines    = remove_structure_tables(t.lines)
      puts '---------------------'
      puts lines
      puts '^^^^^^^^^^^^^^^^^^^^^'
      t.sequel = create_text_with_asciidoc_richtext(eliminate_extra_blank_lines(lines.join("\n")))
    end
  end
  
  def eliminate_extra_blank_lines(str)
    # str.gsub!(/^(\s*\n){2,}$/, "\n")
    str.gsub!(/^(\s*\n){2,}$/, "")
  end

  def create_definition_text(def_text, desc_text)
    ctstart
    obj = HL7::V2::DefinitionText.new
    obj.definition  = create_rt(def_text) if def_text
    obj.description = create_rt(desc_text) if desc_text
    obj.save
    ctcommit
    obj
  end
  
  def remove_structure_tables(input, ref = nil)
    output   = []
    table    = []
    in_table = 0
    keep     = true
    type     = :no_table
    
    input.each do |line|
      in_table = 1 if line.strip =~ /^\[width=/
      if in_table > 0
        table << line.chomp
        in_table += 1 if line.strip =~ /^\|===/
        
        if keep
          type = table_type(line)
          if [:msg_struct, :segdef, :datatype, :ack_chor].include?(type)
            keep = false
          end
        end
        
        if in_table == 3
          if keep
            output = output + table
          else
            if type
              output << '[insert, ' + type.to_s + ']'
            else
              output << '[insert, appropriate_table]'
            end
          end
          table = []
          keep  = true
          in_table = 0
        end
      else
        output << line.chomp
      end
    end
    unless type == :no_table
      # puts Rainbow(type.to_s).lime
      # puts input
      # output.each { |l| puts Rainbow(l).magenta }
      # puts "***"
    end
    output
  end

  def table_type(line)
    # puts Rainbow(line.chomp).cornflower
    ret = _table_type(line)
    # puts ret.to_s
    ret
  end
  
  def _table_type(line)

    # MessageStructure Header
    return :msg_struct if line.strip =~ V2AD.message_structure_table_regex
    # SegmentDefinition Header
    return :segdef if line.strip =~ V2AD.segment_table_header_regex
    # AckChor Header
    return :datatype if line.strip =~ V2AD.datatype_table_header_regex
    # AckChor Header
    return :ack_chor if line.strip =~ V2AD.ack_chor_table_regex
    return :other
  end
    

end
