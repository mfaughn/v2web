module V2Web
  class Reference
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      ref.name
    end
    
    def to_hl7_site
      "INSERT REFERENCE TO: #{identifying_text}"
    end
    
    def to_v2_html_test(_ = nil)
      puts "Reference has no ref.  This reference is contained in #{parents.first.chaptered_title}" unless ref
      "<p>REFERENCE to #{ref.name} -- render table here.</p>"
    end
  end
end