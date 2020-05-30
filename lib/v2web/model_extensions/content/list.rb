module V2Web
  class List
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      title
    end
      
    def to_hl7_site(_ = nil)
      matcher = /(<p.*?>.+?<\/p>)/m
      html = []
      items.each do |item|
        item_content = item.to_hl7_site
        # FIXME find out why matcher isn't matching anything.  The m&.count is just a hack to keep it going while I work on something else
        m = matcher.match(item_content)&.captures
        if m&.count == 1
          item_content = item_content.sub(/^<p.*?>/, '').sub('</p>', '')
        else
          if m.nil?
            puts Rainbow('Empty List Item for ' + parents.first.numbered_title).yellow
          else
            puts Rainbow('Complex List Item for ' + parents.first.numbered_title).yellow
            puts m.inspect
            puts item_content
          end
        end
        li = V2Web.render_with_locals(:li, {:content => item_content })
        html << li
      end
      html = html.join
      # puts html
      list_locals = { :content => html }
      case item_indicator&.value.to_s.downcase
      # when 'bullets', 'bullet'  
      when 'letters', 'letter', 'alpha'
        list_locals[:list_type] = 'lower-alpha'
        V2Web.render_with_locals(:ol, list_locals)
      when 'numbers', 'number', 'numbered'
        list_locals[:list_type] = 'decimal'
        V2Web.render_with_locals(:ol, list_locals)
      when 'none'
        list_locals[:list_type] = 'none'
        V2Web.render_with_locals(:ul, list_locals)
      else
        V2Web.render_with_locals(:ul, list_locals)
      end
    end
    
    def to_v2_html_test(_ = nil)
      to_hl7_site
    end
  end
end
