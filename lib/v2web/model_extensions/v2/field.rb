module HL7::V2
  class Field
    def code
      "#{segment_definition.code}.#{sequence_number}"
    end
    
    def info
      "#{code}#{optionality&.value == 'W' ? ' WITHDRAWN' : ''} (Ch#{segment_definition.origin})"
    end

    def to_segment_definition_row(last)
      zl7 = segment_definition.code && segment_definition.fields.count == 2
      if zl7 == 'ZL7'
        # puts "#{zl7}-#{sequence_number} to_row:"
        # puts data_element.name
      end
      de       = data_element
      dtcode   = de.data_type&.code
      locals   = {
        :sequence_number  => sequence_number.to_s,
        :data_element_id  => data_element_id,
        :field_def_link   => '#' + local_html_id,
        :name             => de.name.to_s,
        :cardinality      => cardinality_string,
        :flags            => flag_string(de),
        :length           => de.length_string,
        :c_length         => de.c_length_string,
        :vocab_url        => vocab_url,
        :vocab_info       => vocab_info,
        :vocab_hover      => vocab_hover,
        :type_url         => (dtcode ? "data-type/#{dtcode}.html" : ''),
        :type_code        => dtcode || '',
        :fat_row          => fatrow,
        :last             => last,
        :usage            => usage
      }
      table = V2Pub.render_with_locals(:field, :row, locals)
    end
    
    def usage
      o = optionality&.value&.strip
      case 
      when o == 'R'
        'R'
      when o =~ /^C/
        'C'
      when 'O'
        o
      when 'X'
        'X FIXME'
      when 'RE'
        'RE FIXME'
      when 'B', 'W'
        o
      else
      end
    end
    
    def vocab_info
      cs = data_element.code_system
      return '' unless cs
      bt = cs.binding_type&.value
      if bt =~ /\(3\)/
        cs.padded_id + "(R)"
      elsif bt =~ /\(2|4\)/
        cs.padded_id + "(S)"
      else
        cs.padded_id
      end
    end
    
    def vocab_url
      data_element.vocab_url.to_s
    end
    
    def vocab_hover
      cs = data_element.code_system
      return '' unless cs
      bt = cs.binding_type&.value
      if bt =~ /\(3\)/
        cs.name + "(Required)"
      elsif bt =~ /\(2|4\)/
        cs.name + "(Suggested)"
      else
        cs.name
      end
      #
      # name = V2Pub.vocab_name(cs.table_id)# .slice(/\d{4}/)) # FIXME cs should know it's own name.  No need for lookup table
    end

    def legacy_tbl
      lt = data_element.vocab
      pp lt
    end
    
    def min_length
      data_element.min_length
    end
    
    def max_length
      data_element.max_length
    end
    
    def c_length
      data_element.c_length
    end
    
    def name
      data_element.name
    end

    def type
      data_element.data_type
    end
    
    def type_code
      type.code
    end
    
    def data_element_id
      item_num = data_element.item_number
      if item_num
        item_num.to_s.rjust(5, "0")
      else
        ''
      end
    end
    
    def to_web_definition(segment_def_sequence_id, depth = 4)
      de     = data_element
      dtcode = de.data_type&.code
      ttl    = "#{segment_def_sequence_id}: #{de.name}"
      unless flags =~ /W/
        # item_num = data_element_id unless (segment_definition.code == 'ZL7' && segment_definition.fields.count == 2 )# stupid hack for ZL7 example segment
        ttl << " (<a href='data-type/#{dtcode}.html'>#{dtcode}</a>) #{data_element_id}"
      end
      dfn = definition&.definition_content || ''
      locals = {
        :depth   => depth,
        :title   => ttl,
        :html_id => local_html_id,
        :content => dfn
      }
      V2Pub.render_with_locals(:field, :definition, locals)
    end
    
    def local_html_id
      segment_definition.code + '-' + sequence_number.to_s
    end
    
    def local_url
      "segment-definition/#{segment_definition.code}.html#" + local_html_id
    end
    
    def flag_string(de = nil)
      # ff = flags.to_s.dup # why do I have to dup this?
      de ||= data_element
      if de
        flags.to_s + de.flags
      else
        flags.to_s
      end
    end
    
    def fatrow
      flags =~ /C/ ? 2 : 0
    end
    
    def cardinality_string
      if flags =~ /C/
        '<br/>[1..1]<br/>[0..1]'
      elsif flags =~ /RE/
        '[0..1]'
      elsif flags =~ /W/
        '[0..0]'
      elsif min_cardinality && max_cardinality
        "[#{min_cardinality}..#{max_cardinality}]"
      elsif min_cardinality
        "[#{min_cardinality}..*]"
      else
        puts Rainbow("No Cardinality! Ch. #{HL7::V2::SegmentDefinition.where(:code => segment_definition.code).first&.origin} #{segment_definition.code} #{sequence_number}").red
      end
    end
    
    def definition
      dt = definition_text
      return dt if dt
      dedefs = data_element.definitions
      return dedefs.first if dedefs.size < 2
      return nil if segment_definition.code == 'ROL'
      puts "Don't know which definition for #{info}.  DataElement #{data_element.item_number} has #{dedefs.size} definitions:"
      puts dedefs.map(&:original_container).sort
      raise "Nope!"
    end
  end # Field
end # V2
