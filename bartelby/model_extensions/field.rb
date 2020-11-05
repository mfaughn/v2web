module V2Plus
  class Field
    attr_accessor :flags # not defined in v2.9 so added here (because Frank has introduced it)
    
    def self.make(nokogiri)
      this = new
      this.sequence_number = nokogiri.css('sequenceNumber').attribute('value')&.value
      this.min_cardinality = nokogiri.css('minCardinality').attribute('value')&.value
      this.max_cardinality = nokogiri.css('maxCardinality').attribute('value')&.value
      this.must_support    = nokogiri.css('mustSupport').attribute('value')&.value.to_s == 'true'
      this.flags           = nokogiri.css('flags').attribute('value')&.value
      de_url = nokogiri.css('dataElement').attribute('value')&.value
      if de_url
        de_local_url = de_url.split('/').last
        this.data_element = DataElement.get(de_local_url)
        raise "No data element for #{de_url}" unless this.data_element
      else
        puts "No data element..."
      end
      this
    end
    
    def to_segment_definition_row
      de = data_element
      de_table = de.table
      dtcode = de.data_type&.code
      locals = {
        :sequence_number  => sequence_number.to_s,
        :data_element_id  => de.item_number.to_s.rjust(5, "0"),
        :data_element_url => 'fixme', # FIXME de.local_url
        :name             => de.name.to_s,
        :must_support     => must_support ? 'Yes' : '',
        :cardinality      => cardinality_string,
        :flags            => flags.to_s,
        :length           => de.length_string,
        :c_length         => de.c_length_string,
        :value_set_url    => de_table ? "http://www.hl7.eu/refactored/tab#{de.padded_table_id}.html" : '',
        # FIXME change to table.name
        :value_set => de_table ? de.padded_table_id : '',
        :type_url => dtcode ? "data-type-#{dtcode}.html" : '',
        :type_code => dtcode || ''
      }
      table = V2Plus.render_with_locals(:component, :row, locals)
    end
    
    def cardinality_string
      if min_cardinality && max_cardinality
        "#{min_cardinality}..#{max_cardinality}"
      elsif min_cardinality
        "#{min_cardinality}..*"
      else
        puts Rainbow("No Cardinality! Ch. #{HL7::SegmentDefinition.where(:code => segment_definition.code).first.origin} #{segment_definition.code} #{sequence_number}").red
      end
    end
  end # Field
end # V2Plus
