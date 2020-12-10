module V2Plus
  class Field
    attr_accessor :flags, :node # not defined in v2.9 so added here (because Frank has introduced it)
    
    def self.make(node)
      this = new
      this.node = node
      this.sequence_number = node.get_val('sequenceNumber')
      this.min_cardinality = node.get_val('minCardinality')
      this.max_cardinality = node.get_val('maxCardinality')
      this.must_support    = node.get_val('mustSupport').to_s == 'true'
      this.flags           = node.get_val('flags')&.strip
      de_url               = node.get_val('dataElement')
      if de_url && (de_url !~ /00000/) # Hack to rescue the ZL7 example segment definition
        this.data_element = DataElement.get(de_url)
        unless this.data_element
          puts "#{de_url} matches /00000.xml/ ? #{!(de_url !~ /00000.xml/)}"
          raise "No data element for #{de_url}"
        end
      else
        puts "No data element..."
      end
      this
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
        :must_implement   => must_implement,
        :cardinality      => cardinality_string,
        :flags            => flag_string(de),
        :length           => de.length_string,
        :c_length         => de.c_length_string,
        # :value_set_url    => de_table ? "http://www.hl7.eu/refactored/tab#{de.padded_table_id}.html" : '',
        :value_set_url    => data_element.table,
        # FIXME change to table.name
        :value_set        => table,
        :value_set_hover  => table_hover,
        :type_url         => (dtcode ? "/data-type/#{dtcode}.html" : ''),
        :type_code        => dtcode || '',
        :fat_row          => fatrow,
        :last             => last
      }
      table = V2Plus.render_with_locals(:field, :row, locals)
    end
    
    def table
      t = data_element.table
      return '' unless t && !t.empty?
      t.slice(/\d{4}/)
    end
    
    def table_hover
      t = data_element.table
      return '' unless t && !t.empty?
      name = V2Plus.vocab_name(t.slice(/\d{4}/))
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
        ttl << " (<a href='/data-type/#{dtcode}.html'>#{dtcode}</a>) #{data_element_id}"
      end
      locals = {
        :depth   => depth,
        :title   => ttl,
        :html_id => local_html_id,
        :content => de.definition.content
      }
      V2Plus.render_with_locals(:field, :definition, locals)
    end
    
    def local_html_id
      segment_definition.code + '-' + sequence_number.to_s
    end
    
    def local_url
      "/segment-definition/#{segment_definition.code}.html#" + local_html_id
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
        puts Rainbow("No Cardinality! Ch. #{HL7::SegmentDefinition.where(:code => segment_definition.code).first&.origin} #{segment_definition.code} #{sequence_number}").red
      end
    end
    
    def must_implement
      if flags =~ /C/
        return V2Plus.render_with_locals(:component, :may_implement, {})
      else
        return 'SHALL NOT' if flags =~ /W/
        must_support ? 'SHALL' : ''
      end
    end
  end # Field
end # V2Plus
