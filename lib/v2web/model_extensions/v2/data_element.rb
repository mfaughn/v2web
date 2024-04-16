module HL7::V2
  class DataElement
    
    def type
      data_type
    end
    
    def to_web_pub
      return unless item_number.to_s == '664'
      return unless item_number
      puts definition.content if item_number.to_s == '664'
      dc  = data_type&.code || 'Null'
      ttl = "Data Element (<a href='data-type/#{dc}.html'>#{dc}</a>) #{item_number}"
      locals = {
        :title      => ttl,
        :definition => definition.content,
        :fields     => used_by_fields
      }
      page = V2Pub.render_with_locals(:data_element, :page, locals)
      V2Pub.save_web_file("data-element/#{item_number.rjust(4,'0')}.html", page)
    end
    
    # FIXME remove this once the model has changed
    alias_method :vocab, :value_set_definition if self.instance_methods.include?(:value_set_definition)
  
    def code_system
      vocab&.code_systems&.first
    end
  
    def local_url_name
      # name.downcase.gsub(/[^A-Za-z\d]/, '-') + item_number.to_s.rjust(5,'0')
      item_number.to_s.rjust(5,'0')
    end
  
    def field_info
      fields.map(&:info).uniq.join('; ')
    end
    
    def vocab_url
      cs = code_system
      if cs
        'vocab/' + cs.url_name + '.html'
      else
        nil
      end
    end
    
    def length_string
      if min_length && max_length
        "[#{min_length}..#{max_length}]"
      elsif min_length
        "[#{min_length}..*]"
      else
        ''
      end
    end
    
    def c_length_string
      # return '' unless c_length&.[](0)
      c_length.to_s
      # may_truncate ? "#{c_length}#" : "#{c_length}="
      # may_truncate ? "#{c_length}#" : "#{c_length}="
    end
    
    def used_by_fields
      fields.uniq { |f| f.local_html_id }.sort_by { |f| f.local_html_id }
    end
    
    # No table objects in use
    # def padded_table_id
    #   table.table_id.to_s.rjust(4, "0")
    # end
    
    def flags
      ff = ''
      if c_length&.[](0)
        ff << (may_truncate ? '#' : '=')
      end
      ff
    end
    
  end
end
