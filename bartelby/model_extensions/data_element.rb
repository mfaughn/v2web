module V2Plus
  class DataElement  
    
    def self.make(data)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      this = new
      this.name         = data['name'].first['value']
      this.item_number  = data['itemNumber']&.first&.[]('value')
      this.min_length   = data['minLength']&.first&.[]('value')
      this.max_length   = data['maxLength']&.first&.[]('value')
      this.c_length     = data['confLength']&.first&.[]('value')
      this.may_truncate = data['mayTruncate']&.first&.[]('value')
      this.description  = data['description']
      this.url          = data['url'].first['value']
      dt_url = data['dataType']&.first&.[]('value')
      if dt_url
        dt_local_url = dt_url.split('/').last
        this.data_type = V2Plus::DataType.get(dt_local_url)
        this.data_type_varies = false # FIXME
        unless this.data_type
          puts Rainbow("DataElement with no DataType: #{this.item_number}").red
          puts HL7::DataElement.where(:item_number => this.item_number.to_i).first.field_info
          this.data_type_varies = true
        end
      end
      this
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
    
  end
end
