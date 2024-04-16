module HL7::V2
  class Component
    # FIXME remove this once the model has changed
    alias_method :vocab, :value_set_definition if self.instance_methods.include?(:value_set_definition)

    def code_system
      vocab&.code_systems&.first
    end
  
    def withdrawn
      optionality&.value == 'W'
    end

    def html_sn
      sn = sequence_number.to_s.strip
      sn = '1' if sn.empty? 
      sn
    end
    
    def local_html_id
      "#{owner.code}-#{html_sn}"
    end
    
    def to_datatype_row(last = false)
      dtcode = type&.code
      locals = {
        :sequence_number     => html_sn,
        :sequence_number_url => '#' + local_html_id,
        :name                => name,
        :flags               => html_table_flags,
        :usage               => usage,
        # :cardinality         => cardinality,
        :length              => length_string,
        :c_length            => c_length_string,
        # :value_set_url       => table ? "http://www.hl7.eu/refactored/tab#{padded_table_id}.html" : '',
        :vocab_url           => vocab_url,
        :vocab_info          => vocab_info,
        :vocab_hover         => vocab_hover,
        :type_url            => dtcode ? "data-type/#{dtcode}.html" : '',
        :type_code           => dtcode || '',
        :fat_row             => fatrow,
        :last                => last
      }
      V2Pub.render_with_locals(:component, :row, locals)
    end
    
    def to_web_definition(datatype_sequence_id)
      locals = {
        :title => linked_web_def_title(datatype_sequence_id),
        :html_id => local_html_id,
        :content => definition&.content.to_s
      }
      V2Pub.render_with_locals(:component, :definition, locals)
    end
    
    def linked_web_def_title(datatype_sequence_id)
      dtcode = type&.code || owner.code
      "#{datatype_sequence_id}: #{name} (<a href='data-type/#{dtcode}.html'>#{dtcode}</a>)"
    end
    
    def length_string
      if min_length && max_length
        "[#{min_length}..#{max_length}]"
      elsif min_length
        "[#{min_length}..]"
      else
        ''
      end
    end
    
    def c_length_string
      return '' unless c_length
      ('&nbsp;'*(3 - c_length.size)) + c_length
      # return '' unless c_length
      # may_truncate ? "#{c_length}#" : "#{c_length}="
    end

    def html_table_flags
      # flags = []
      # if c_length && !c_length.empty?
      #   flags << (may_truncate ? "#" : "=")
      # end
      flags.to_s
    end
    
    def implement_html
      if flags&.include?('C')
        V2Pub.render_with_locals(:component, :may_implement, {})
      else
        if flags&.include?('RE') || min_length.to_i > 0
          'SHALL'
        end
      end
    end
    
    def fatrow
      flags&.include?('C') ? 2 : 0
    end
    
    def cardinality
      if flags&.include?('C')
        '<br/>[1..1]<br/>[0..1]'
      elsif flags&.include?('RE')
        '[0..1]'
      else
        "[#{must_support ? '1' : '0'}..1]"
      end
    end
    
    def padded_table_id
      return nil unless table
      table.table_id.to_s.rjust(4, "0")
    end
    
    # FIXME consolidate with method on Field
    def vocab_info
      cs = code_system
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
      cs = code_system
      cs ? ('vocab/' + cs.url_name + '.html') : nil
    end
    
    def vocab_hover
      cs = code_system
      return '' unless cs
      bt = cs.binding_type&.value
      if bt =~ /\(3\)/
        cs.name + "(Required)"
      elsif bt =~ /\(2|4\)/
        cs.name + "(Suggested)"
      else
        cs.name
      end
    end
    
    # FIXME consolidate with method on Field ???
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
    
  end # Component
end
