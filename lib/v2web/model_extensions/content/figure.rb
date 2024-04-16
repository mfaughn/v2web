module V2Web
  class Figure
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      caption ? caption : file_filename
    end
    
    derived_attribute(:title, ::String)
    alias_method :title, :caption
    
    def to_web_pub
      html = ['<div class="v2-image">']
      b64 = file.binary_data.data
      mt  = file.mime_type
      puts Rainbow(mt).cyan
      img = '<img src="data:' + mt + ';base64, ' + b64 + '">'
      html << img
      html << '</div>'
      html.join("\n")
    end
    
    def to_hl7_site(_ = nil)
      # TODO don't embed Bin64 but instead save to folder with guaranteed unique filename and then use that filename for the value of :src
      html = []
      if file
        encoded_image = "data:#{file.mime_type};base64,#{Base64.encode64(file.binary_data.data)}"
        html << "<img src = '#{encoded_image}' alt = '#{caption}' />" #style = 'width:100%;'
        html << "<figcaption>#{caption}</figcaption>" if caption
      else
        html = ['FILE MISSING!']
      end
      V2Web.render_with_locals(:figure, {:content => html.join("\n"), :figure_id => html_id })
    end
    
    def html_id
      "v2web_figure-#{id}"
    end
    
    # FIXME how get footnotes into caption headers
    def all_texts
      []
    end
  end
end
