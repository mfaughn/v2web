module V2Plus
  class Component
    # attr_accessor :name, :sequence_number, :min_length, :conf_length, :may_truncate, :data_type, :table
    def self.make(nokogiri, base = nil)
      this = new
      # puts nokogiri.children.map(&:name)
      this.name      = nokogiri.css('name').attribute('value')&.value
      this.sequence_number = nokogiri.css('sequenceNumber').attribute('value')&.value
      this.min_length      = nokogiri.css('minLength').attribute('value')&.value
      this.max_length      = nokogiri.css('maxLength').attribute('value')&.value
      this.c_length        = nokogiri.css('confLength').attribute('value')&.value
      this.may_truncate    = nokogiri.css('mayTruncate').attribute('value')&.value.to_s == 'true'
      this.definition      = Gui_Builder_Profile::RichText.create(:content => nokogiri.css('definition div')&.to_html) # gets the entire div
      table_url            = nokogiri.css('binding').attribute('value')&.value
      this.table           = get_value_set(table_url) if table_url
      dt_url = nokogiri.css('dataType').attribute('value')&.value
      if dt_url
        dt_url = dt_url.split(/\//).last
        this.type = DataType.get(dt_url) unless dt_url == base.local_url_name
        # FIXME insert FHIR datatype url for primitive V2 types as component base type ??
      end
      this
    end
    
    def self.get_value_set(table_url)
      table_id = table_url.slice(/(?<=\/)\d+(?=\/)/).rjust(4, '0')
      vs = Bartelby.get(self, table_id)
      return vs if vs
      vs = V2Plus::ValueSet.new
      vs.table_id = table_id
      vs.cache
      vs
    end
      
    
    def to_datatype_row(last = false)
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
        :type_code => dtcode || '',
        :last => last
      }
      V2Plus.render_with_locals(:component, :row, locals)
    end
    
    def to_web_definition(datatype_sequence_id)
      locals = {
        :title => "#{datatype_sequence_id}: #{name} (#{type&.code || owner.code})",
        :content => definition.content
      }
      V2Plus.render_with_locals(:component, :definition, locals)
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
      return nil unless table
      table.table_id.to_s.rjust(4, "0")
    end
        
  end # Component
end
