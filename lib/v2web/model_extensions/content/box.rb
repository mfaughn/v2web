module V2Web
  class Box    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      content.first&.identifying_text
    end
      
    # FIXME!!!
    def to_hl7_site(_ = nil)
      return ''
      # TODO this might be different if the content is already HTML
      V2Web.render_with_locals(:box, {:content => web_content, :css => 'fixme'})
    end
  end
end
