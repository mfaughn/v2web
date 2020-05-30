require 'cgi'
require 'loofah'
module V2Web
  class Table
    def to_hl7_site(_ = nil)
      html = []
      if caption && !caption.strip.empty?
        cap = V2Web.htmlize(caption)
        html << "<caption>#{cap}</caption>"
      end
      # puts rendering_type.inspect
      html += rows.map { |r| r.to_hl7_site(r.header) }
      locals = { :content => html.join("\n") }
      locals[:classes] = styles.map(&:value).join(' ')
      # puts locals[:classes] unless locals[:classes]&.empty?
      V2Web.render_with_locals(:table, locals)
    end
    
    def to_v2_html_test(_ = nil)
      to_hl7_site
    end
    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      t = if title
        puts 'title'
        title
      elsif caption
        puts 'caption'
        caption
      else
        header_row_simple
      end
      puts t.inspect
      t
    end
    
    def to_html
      html_simple
    end
    
    derived_attribute :html_simple, String
    def html_simple
      html = []
      html << '<table>' # style="width:100%"
      html << "<caption>#{caption.hl7}</caption>" if caption
      rows.each_with_index do |row, index|
        # Hack to get rid of empty rows
        cell_check = row.cells.map(&:html_content).join.strip
        puts "Cell Check: #{cell_check.inspect}"
        next if cell_check.empty?
        cell_type = (index == 0 && caption && !caption.empty?) ? 'th' : 'td'
        html << '<tr>'
        row.cells.each do |cell|
          html << "<#{cell_type}>#{cell.html_content}</#{cell_type}>"
        end
        html << '</tr>'
      end
      html << '</table>'
      html = html.join("\n").strip
      puts html
      html
    end
    
    def header_row_simple
      html = []
      rows.first.cells.each do |cell|
        html << Loofah.fragment(cell.html_content).scrub!(:prune).text
      end
      puts html
      'Table: ' + html.join(" | ")[0..50]
    end
  end
  
  class Row
    def to_hl7_site(header = false)
      V2Web.render_with_locals(:tr, {:content => cells.map { |c| c.to_hl7_site(header) }.join("\n") })
    end
  end
  
  class Cell
    def to_hl7_site(header = false)
      tag = header ? :th : :td
      locals = {:content => content.map { |c| c.to_hl7_site(self) }.join("\n") }
      locals[:classes] = styles.map(&:value).join(' ')
      locals[:colspan] = colspan || 1
      V2Web.render_with_locals(tag, locals)
    end
    
    def html_content
      content.map { |c| c.to_html }.join("\n")
    end
  end
end
