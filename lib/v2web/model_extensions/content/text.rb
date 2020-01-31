module V2Web
  class Text
    def to_html
      content.content
    end
    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      Loofah.fragment(content_content).scrub!(:prune).text[0..50]
    end
    
    def web_content
      content_content.hl7
      # V2Web.htmlize(content_content)
    end
  
    def to_hl7_site(_ = nil)
      # TODO this might be different if the content is already HTML
      V2Web.render_with_locals(:p, {:content => web_content})
    end
  end
end
