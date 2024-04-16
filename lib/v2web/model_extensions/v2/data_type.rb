module HL7::V2
  class DataType
    
    def to_pub_clause(depth)
      locals = {
        :caption => "HL7 Component Table - #{code} - #{name}",
        :datatype_control_page => "data-types.html",
        :code => code,
        :component_rows => component_rows
      }
      
      table = V2Pub.render_with_locals(:datatype, :table, locals)
      cshtml = component_string_html
      table << V2Pub.render_with_locals(:datatype, :components_string, {:content => cshtml}) if cshtml
      
      content = description&.content
      # puts Rainbow(content).cyan;puts
      table_regexp = /<div class=.insert-component-table.\s+id=....?-component-table.+><\/div>/
      content = content.to_s.sub(table_regexp, table)

      locals = {
        :title => "#{code} - #{name}",
        :content => content,
        :component_definitions => component_definitions_html
      }
      V2Pub.render_with_locals(:datatype, :page, locals)
    end
    
    def to_web_pub
      page = to_pub_clause(3)
      V2Pub.save_web_file("data-type/#{code}.html", page)
    end
    
    # HTML
    def component_string_html
      return nil unless components.count > 1
      str = "<p class='v2-components'>Components: #{_components_string_html}</p>"
      subs_str = subcomponents.map do |sc|
         "<p class='v2-components'>Subcomponents for #{sc.name} (#{sc.type.code}): #{sc.type._components_string_html(true)}</p>"
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
          puts self.code unless c.type
          # puts "Component for #{name}#{c.sequence_number || '1'} - #{c.name}"
          pbug "#{self.name} has a component without a type.\n#{c.inspect}" unless c.type
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
      return '' if cc.count < 2 #&& cc.first&.type == self
      cc.each_with_index { |comp, i| html << comp.to_web_definition("#{code}-#{i+1}") }
      html.join("\n")
    end
    
    def local_url_name
      unless name
        # FIXME do better than this...
        puts "Datatype without name\n#{pretty_inspect}"
        puts
        return ''
      end
      name.downcase.gsub(/[^A-Za-z\d]/, '-')
    end
    
  end
  Datatype = DataType
end
