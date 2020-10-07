module V2Web
  class Footnote
    def to_html
      content.content
    end
    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      Loofah.fragment(content_content).scrub!(:prune).text[0..50]
    end
    
    def web_content
      content_content.hl7.strip.sub(/^<p>/, '').sub(/<\/p>$/, '')
    end
  
    def to_hl7_site(_ = nil)
      # TODO this might be different if the content is already HTML
      locals = {:content => web_content, :css => ''}
      # if styles.any?
      #   # Note that it is entirely possible to have conflicting styles here!
      #   locals[:css] = styles.map { |s| _css(s) }.compact.join
      # end
      ret = V2Web.render_with_locals(:footnote, locals)
    end    
    
    def to_v2_html_test(_ = nil)
      to_hl7_site
    end
  end
end
