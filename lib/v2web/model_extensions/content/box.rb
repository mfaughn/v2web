module V2Web
  class Box    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      content.first&.identifying_text
    end
      
    def to_hl7_site(_ = nil)
      locals = {:content => content.map { |c| c.to_hl7_site }.join("\n")}
      locals[:classes] = styles.map(&:value).join(' ')
      V2Web.render_with_locals(:box, locals)
    end
  end
end
