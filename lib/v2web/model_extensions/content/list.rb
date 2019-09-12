module V2Web
  class List
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      title
    end
      
    def to_hl7_site(_ = nil)
      html = []
      items.each { |item| html << V2Web.render_with_locals(:li, {:content => item.to_hl7_site })}
      V2Web.render_with_locals(:ul, {:content => html.join("\n") })
    end
  end
end
