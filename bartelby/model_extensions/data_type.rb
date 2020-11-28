module V2Plus
  class DataType
    
    # NOTE Be very careful about calling this.  The returned object should normally be cached so you'd normally want to call #make_and_cache
    def self.make(doc, identifier = nil)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      # array_type ? FIXME
      this = new
      nodeset = doc.css('DataTypeDefinition')
      this.name         = nodeset.get_val('name')
      this.code         = nodeset.get_val('abbreviation')
      this.withdrawn    = nodeset.get_val('withdrawn')
      this.url          = nodeset.get_val('url')
      this.description  = Gui_Builder_Profile::RichText.create(:content => nodeset.css('description > div')&.to_html) # gets the entire div
      this.components   = nodeset.css('component').map { |c| V2Plus::Component.make(c, this) } # components 
      this
    end
    
    
    def to_composition_clause(depth)
      locals = {
        :caption => "HL7 Component Table - #{code} - #{name}",
        :datatype_control_page => "http://www.hl7.eu/refactored/dt.html", # FIXME
        :code => code,
        :component_rows => component_rows
      }
      
      table = V2Plus.render_with_locals(:datatype, :table, locals)
      cshtml = component_string_html
      table << V2Plus.render_with_locals(:datatype, :components_string, {:content => cshtml}) if cshtml
      
      content = description&.content
      # puts Rainbow(content).cyan;puts
      table_regexp = /<div class=.insert-component-table.\s+id=....?-component-table.+><\/div>/
      content = content.sub(table_regexp, table)


      locals = {
        :title => "#{code} - #{name}",
        :content => content,
        :component_definitions => component_definitions_html
      }
      V2Plus.render_with_locals(:datatype, :page, locals)
    end
    
    
    
    def to_web_pub
      page = to_composition_clause(3)
      V2Plus.save_web_file("data-type-#{code}.html", page)
    end
    
    # HTML
    def component_string_html
      return nil unless components.count > 1
      str = "<p class='v2_components'>Components: #{_components_string_html}</p>"
      subs_str = subcomponents.map do |sc|
         "<p class='v2_components'>Subcomponents for #{sc.name} (#{sc.type.code}): #{sc.type._components_string_html(true)}</p>"
       end
       str << subs_str.join("\n") if subs_str.any?
       str
    end
    
    def subcomponents
      components.select { |c| c.type&.components_count.to_i > 1 }
    end
      
    
    def _components_string_html(as_sub = false)
      joiner = as_sub ? ' &#94; ' : ' &#38; ' # caret : ampersand
      array = []
      components.each do |c|
        if c.withdrawn
          array << "&#60;WITHDRAWN #{c.name}&#62;"
        else
          # puts "Component for #{name}#{c.sequence_number || '1'} - #{c.name}"
          array << "&#60;#{c.name} (#{c.type.code})&#62;"
        end
      end
      array.join(joiner)
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
