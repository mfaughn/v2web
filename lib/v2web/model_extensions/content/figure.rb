module V2Web
  class Figure
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      if title
        title
      elsif caption
        caption
      elsif file_filename
        file_filename
      end
    end
    
    def to_hl7_site(_ = nil)
      # TODO don't embed Bin64 but instead save to folder with guaranteed unique filename and then use that filename for the value of :src
      html = []
      if file
        encoded_image = "data:#{file.mime_type};base64,#{Base64.encode64(file.binary_data.data)}"
        html << "<img src = '#{encoded_image}' alt = '#{caption}' />" #style = 'width:100%;'
        html << "<figcaption>#{caption}</figcaption>"
      else
        html = ['FILE MISSING!']
      end
      V2Web.render_with_locals(:figure, {:content => html.join("\n") })
    end
  end
end
