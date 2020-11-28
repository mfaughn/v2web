module V2Plus
  class Field
    attr_accessor :flags # not defined in v2.9 so added here (because Frank has introduced it)
    
    def self.make(node)
      this = new
      this.sequence_number = node.get_val('sequenceNumber')
      this.min_cardinality = node.get_val('minCardinality')
      this.max_cardinality = node.get_val('maxCardinality')
      this.must_support    = node.get_val('mustSupport').to_s == 'true'
      this.flags           = node.get_val('flags')
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
      de_table = de.table # ZL7 has fake data elements with no value set / table
      dtcode   = de.data_type&.code
      locals   = {
        :sequence_number  => sequence_number.to_s,
        :data_element_id  => de.item_number.to_s.rjust(5, "0"),
        :field_def_link   => '#' + local_html_id,
        :name             => de.name.to_s,
        :must_implement   => must_implement,
        :cardinality      => cardinality_string,
        :flags            => flag_string(de),
        :length           => de.length_string,
        :c_length         => de.c_length_string,
        :value_set_url    => de_table ? "http://www.hl7.eu/refactored/tab#{de.padded_table_id}.html" : '',
        # FIXME change to table.name
        :value_set => de_table ? de.padded_table_id : '',
        :type_url => dtcode ? "data-type-#{dtcode}.html" : '',
        :type_code => dtcode || '',
        :last => last
      }
      table = V2Plus.render_with_locals(:field, :row, locals)
    end
    
    def to_web_definition(segment_def_sequence_id, depth = 4)
      de     = data_element
      dtcode = de.data_type&.code
      ttl    = "#{segment_def_sequence_id}: #{de.name}"
      unless flags =~ /W/
        item_num = de.item_number.rjust(5, '0') unless (segment_definition.code && segment_definition.fields.count == 2 )# stupid hack for ZL7 example segment
        ttl << " (<a href='data-type-#{dtcode}.html'>#{dtcode}</a>) #{item_num}"
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
    
    def flag_string(de = nil)
      ff = flags.to_s
      de ||= data_element
      if de
        ff << de.flags
      end
      ff
    end
    
    def cardinality_string
      return '0..0' if flags =~ /W/
      if min_cardinality && max_cardinality
        "#{min_cardinality}..#{max_cardinality}"
      elsif min_cardinality
        "#{min_cardinality}..*"
      else
        puts Rainbow("No Cardinality! Ch. #{HL7::SegmentDefinition.where(:code => segment_definition.code).first&.origin} #{segment_definition.code} #{sequence_number}").red
      end
    end
    
    def must_implement
      return 'SHALL NOT' if flags =~ /W/
      must_support ? 'SHALL' : 'MAY'
    end
  end # Field
end # V2Plus
