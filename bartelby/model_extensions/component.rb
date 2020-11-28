module V2Plus
  class Component
    # attr_accessor :name, :sequence_number, :min_length, :conf_length, :may_truncate, :data_type, :table
    attr_accessor :withdrawn
    def self.make(node, base = nil)
      this = new
      # puts nodeset.children.map(&:name)
      this.name            = node.get_val('name')
      this.sequence_number = node.get_val('sequenceNumber')
      this.min_length      = node.get_val('minLength')
      this.max_length      = node.get_val('maxLength')
      this.c_length        = node.get_val('confLength')
      this.may_truncate    = node.get_val('mayTruncate').to_s == 'true'
      this.withdrawn       = node.get_val('withdrawn').to_s == 'true'
      this.definition      = Gui_Builder_Profile::RichText.create(:content => node.at_css('definition div')&.to_html) # gets the entire div
      table_url            = node.get_val('binding')
      this.table           = get_value_set(table_url) if table_url
      dt_url = node.get_val('dataType')
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
    
    def html_sn
      sn = sequence_number.to_s.strip
      sn = '1' if sn.empty? 
      sn
    end
    
    def local_html_id
      "#{owner.local_url_name}-#{html_sn}"
    end
    
    def to_datatype_row(last = false)
      dtcode = type&.code
      locals = {
        :sequence_number => html_sn,
        :sequence_number_url => '#' + local_html_id,
        :name => name,
        :implement => must_support&.value.to_s =~ /R|C/ ? 'Yes' : '',
        :flags => html_table_flags,
        :cardinality => cardinality,
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
        :title => linked_web_def_title(datatype_sequence_id),
        :html_id => local_html_id,
        :content => definition.content
      }
      V2Plus.render_with_locals(:component, :definition, locals)
    end
    
    def linked_web_def_title(datatype_sequence_id)
      dtcode = type&.code || owner.code
      "#{datatype_sequence_id}: #{name} (<a href='data-type-#{dtcode}.html'>#{dtcode}</a>)"
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
      flags = []
      if c_length && !c_length.empty?
        flags << (may_truncate ? "#" : "=")
      end
      flags.join(' ')
    end
    
    def cardinality
      "[#{must_support ? '1' : '0'}..1]"
    end
    
    def padded_table_id
      return nil unless table
      table.table_id.to_s.rjust(4, "0")
    end
        
  end # Component
end
