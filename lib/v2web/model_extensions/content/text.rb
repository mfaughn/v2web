module V2Web
  class Text
    def to_html
      content.content
    end
    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      content_content[0..50]
    end
    
    def web_content
      # content_content.gsub(/\n/, '<br>').hl7
      content_content.hl7
    end
  
    def to_hl7_site(_ = nil)
      # TODO this might be different if the content is already HTML
      V2Web.render_with_locals(:p, {:content => web_content})
    end
  end
end
