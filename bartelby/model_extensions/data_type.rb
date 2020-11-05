module V2Plus
  class DataType
    
    # NOTE Be very careful about calling this.  The returned object should normally be cached so you'd normally want to call #make_and_cache
    def self.make(nokogiri_doc)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      # array_type ? FIXME
      this = new
      nokogiri = nokogiri_doc.css('DataTypeDefinition')
      this.name         = nokogiri.css('name').attribute('value')&.value
      this.code         = nokogiri.css('abbreviation').attribute('value')&.value
      this.withdrawn    = nokogiri.css('withdrawn').attribute('value')&.value
      this.url          = nokogiri.css('url').attribute('value')&.value
      this.description  = Gui_Builder_Profile::RichText.create(:content => nokogiri.css('description div')&.to_html) # gets the entire div
      this.components   = nokogiri.css('component').map { |c| V2Plus::Component.make(c, this) } # components 
      this
    end
    
    def to_web_pub
      locals = {
        :caption => "HL7 Component Table - #{code} - #{name}",
        :datatype_control_page => "http://www.hl7.eu/refactored/dt.html", # FIXME
        :code => code,
        :component_rows => component_rows,
        :component_definitions => component_definitions_html,
        :title => "#{code} - #{name}",
        :before_table => description&.content || '', # FIXME
        :after_table => '' # FIXME
      }
      table = V2Plus.render_with_locals(:datatype, :table, locals)
      locals[:table] = table
      page = V2Plus.render_with_locals(:datatype, :page, locals)
      V2Plus.save_web_file("data-type-#{code}.html", page)
    end
    
    def component_rows
      html = []
      cc = components
      cc.each_with_index { |comp, i| html << comp.to_datatype_row((i + 1) == cc.size) }
      html.join("\n")
    end
    
    def component_definitions_html
      html = []
      cc = components
      cc.each_with_index { |comp, i| html << comp.to_web_definition("#{code}-#{i+1}") }
      html.join("\n")
    end
    
  end
end
