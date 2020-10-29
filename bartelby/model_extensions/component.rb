module V2Plus
  class Component
    # attr_accessor :name, :sequence_number, :min_length, :conf_length, :may_truncate, :data_type, :table
    def self.make(data, base = nil)
      this = new
      this.name            = data['name'].first['value']
      this.sequence_number = data['sequenceNumber'].first['value']
      this.min_length      = data['minLength'].first['value'] if data['minLength']
      this.max_length      = data['maxLength'].first['value'] if data['maxLength'] # where is max length ?? not in XML ??
      this.c_length        = data['confLength'].first['value'] if data['confLength']
      this.may_truncate    = (data['mayTruncate'].first['value'] == 'true').to_s
      dt_url = data['dataType']&.first&.[]('value')&.split(/\//)&.last
      if dt_url
        this.type = DataType.get(dt_url) unless dt_url == base.local_url_name
        # this.data_type = FHIR2Obj.get_data_type(dt_url) || FHIR2Obj._reconstitute_element(:data_types, dt_url)
      end
      # FIXME -- get ValueSet obj
      # this.table = FIXME
      this.legacy_dt = data['dataType']&.first&.[]('binding')&.first&.[]('value')
      this
    end
    
    def to_datatype_row
      dtcode = type&.code
      locals = {
        :sequence_number => sequence_number.to_s,
        :name => name,
        :must_support => must_support&.value.to_s =~ /R|C/ ? 'Yes' : '',
        :length => length_string,
        :c_length => c_length_string,
        :value_set_url => table ? "http://www.hl7.eu/refactored/tab#{padded_table_id}.html" : '',
        # FIXME change to table.name
        :value_set => table ? table.table_id : '',
        :type_url => dtcode ? "data-type-#{dtcode}.html" : '',
        :type_code => dtcode || ''
      }
      table = V2Plus.render_with_locals(:component, :row, locals)
    end
    
    def length_string
      if min_length && max_length
        "#{min_length}..#{max_length}"
      elsif min_length
        "#{min_length}.."
      else
        ''
      end
    end
    
    def c_length_string
      return '' unless c_length
      may_truncate ? "#{c_length}#" : "#{c_length}="
    end
    
    def padded_table_id
      table.table_id.to_s.rjust(4, "0")
    end
        
  end # Component
end
