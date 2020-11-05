module V2Plus
  class DataElement
    def definitions=(value)
      @definitions = value
    end
    alias_method :definition, :definitions
    alias_method :definition=, :definitions=
    def self.make(nokogiri_doc)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      this = new
      nokogiri = nokogiri_doc.css('DataElementDefinition')
      this.name         = nokogiri.css('itemNumber').attribute('value')&.value
      this.item_number  = nokogiri.css('minLength').attribute('value')&.value
      this.min_length   = nokogiri.css('maxLength').attribute('value')&.value
      this.max_length   = nokogiri.css('confLength').attribute('value')&.value
      this.c_length     = nokogiri.css('mayTruncate').attribute('value')&.value
      this.may_truncate = nokogiri.css('description').attribute('value')&.value
      this.url          = nokogiri.css('url').attribute('value')&.value
      this.definition   = Gui_Builder_Profile::RichText.create(:content => nokogiri.css('description div')&.to_html) # gets the entire div
 
      dt_url = nokogiri.css('dataType').attribute('value')&.value
      if dt_url
        dt_url = dt_url.split(/\//).last
        this.data_type = DataType.get(dt_url)
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
