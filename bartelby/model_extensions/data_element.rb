module V2Plus
  class DataElement
    def definitions=(value)
      @definitions = value
    end
    alias_method :definition, :definitions
    alias_method :definition=, :definitions=
    def self.make(doc, identifier = nil)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      this = new
      nodeset = doc.css('DataElementDefinition')
      this.name         = nodeset.get_val('name')
      this.item_number  = nodeset.get_val('itemNumber')
      this.min_length   = nodeset.get_val('minLength')
      this.max_length   = nodeset.get_val('maxLength')
      this.c_length     = nodeset.get_val('confLength')
      this.may_truncate = nodeset.get_val('mayTruncate').to_s == 'true'
      this.table        = nodeset.get_val('table')
      this.url          = nodeset.get_val('url')
      this.definition   = Gui_Builder_Profile::RichText.create(:content => nodeset.css('description > div')&.to_html) # gets the entire div
 
      dt_url = nodeset.get_val('dataType')
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
    
    
    def to_web_pub
      return unless item_number.to_s == '664'
      return unless item_number
      puts definition.content if item_number.to_s == '664'
      dc  = data_type&.code || 'Null'
      ttl = "Data Element (<a href='/data-type/#{dc}.html'>#{dc}</a>) #{item_number}"
      locals = {
        :title      => ttl,
        :definition => definition.content,
        :fields     => used_by_fields
      }
      page = V2Plus.render_with_locals(:data_element, :page, locals)
      V2Plus.save_web_file("data-element/#{item_number.rjust(4,'0')}.html", page)
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
