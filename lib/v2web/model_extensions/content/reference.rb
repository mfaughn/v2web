module V2Web
  class Reference
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      ref.name
    end
    
    def to_pub(depth)
      rendering_type = render_as&.value
      begin
        r = ref
      rescue
        pp self
        raise
      end
      unless r
        puts Rainbow("Reference does not reference a model element!").red
        pp self
        puts '---------parents-----------'
        parents.each { |parent| pp parent }
        return '<strong>FIXME</strong>'
      end
      case rendering_type
      when 'message table'
        r.to_tabs
      when 'segment-definition', 'segment definition', 'datatype-definition', 'datatype definition'
        r.to_pub_clause(depth)
      else
        raise Rainbow("Can't render a #{rendering_type}").red
      end
    end
    
    # Wow, this should really be #to_composition, I think?? FIXME
    def to_hl7_site
      # "INSERT REFERENCE TO: #{identifying_text}"
      "<entry>\n  <reference value=#{ref.url_name.inspect}\>\n</entry>"
    end
    
    def to_v2_html_test(_ = nil)
      puts "Reference has no ref.  This reference is contained in #{parents.first.chaptered_title}" unless ref
      "<p>REFERENCE to #{ref.name} -- render table here.</p>"
    end
  end
end
