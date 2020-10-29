module V2Plus
  class DataType
    
    # NOTE Be very careful about calling this.  The returned object should normally be cached so you'd normally want to call #make_and_cache
    def self.make(data)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      # array_type ? FIXME
      this = new
      this.name         = data['name'].first['value']
      this.code         = data['abbreviation'].first['value']
      this.withdrawn    = data['withdrawn'].first['value']
      this.description  = Gui_Builder_Profile::RichText.create(:content => data['description'])
      this.url          = data['url'].first['value']
      this.components   = data['component']&.map { |c| V2Plus::Component.make(c, this) } # components are contained and are persisted with the DataType so there is no need to cache them
      # puts comps.map { |x| x.class }.uniq.inspect
      # this.components = comps
      # puts 'GOODBYE'
      this
    end
    
    def to_web_pub
      locals = {
        :caption => "HL7 Component Table - #{code} - #{name}",
        # FIXME
        :datatype_control_page => "http://www.hl7.eu/refactored/dt.html",
        :code => code,
        :component_rows => component_rows
      }
      table = V2Plus.render_with_locals(:datatype, :table, locals)
      V2Plus.save_web_file("data-type-#{code}.html", table)
    end
    
    def component_rows
      components.collect { |comp| comp.to_datatype_row }.join("\n")
    end
    
  end
end
