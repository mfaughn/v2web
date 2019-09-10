module SDoc
  class Document
    def subclauses
      content.select { |c| c.is_a?(SDoc::Clause) }
    end
    
    def to_hl7_site_file(location = nil)
      payload = content.map { |c| c.to_hl7_site(:parent => self, :parent_number => nil) }.join("\n")
      HL7Site.create_site_file(payload, location)
    end
    def to_hl7_site
      HL7Site.render_site(content.map { |c| c.to_hl7_site(:parent => self, :parent_number => nil) }.join("\n"))
    end
    # def hl7_page_content
    #   base_content = content.reject { |c| c.is_a?(SDoc::Clause) }
    #   page_content = base_content.map { |c| c.to_hl7_site(:parent => self, :parent_number => nil) }.join("\n")
    # end
    def link_title
      title.gsub(/\s/, '_').hl7
    end
  end
  
  class Clause
    def subclauses
      content.select { |c| c.is_a?(SDoc::Clause) }
    end
    
    def number(parent: nil, parent_number: nil)
      # And here is where we just sort of guess at what clause number this shold be if we have aren't given a parent. We are going to choose whichever was most recently modified. TODO make this more deterministic
      if parent.nil?
        if documents.any?
          parent = documents.max_by { |d| d[:updated_at] }
        elsif containers.any?
          parent = containers.max_by { |d| d[:updated_at] }
        end
      end
      return '' if parent.nil? # bail out, can't number if no parent
      parent_number = parent.number if parent_number.nil? && parent.is_a?(SDoc::Clause)
      num = (parent.clauses.index { |c| c.id == id } + 1).to_s
      num = parent_number + '.' + num if parent_number
      num
    end
    
    def nesting_depth(root, val = 0)
      return val if val == 5
      if documents.any?
        found_root = documents.find { |doc| doc.id == root.id }
        return val if found_root
      end
      # Note that this can return nil if there are no containers.
      depths = containers.map { |cont| cont.depth(root, val + 1) }.sort
      depths.first
    end
    
    def numbered_title
      number + ' ' + title
    end
    
    def to_hl7_section_header(depth: nil, parent: nil, parent_number: nil, link: nil)
      nt = numbered_title
      # puts nt
      depth = nt.slice(/^[\d\.]+/).split('.').count # this is hacky but should work
      
      # numbered_title = num + ' ' + title
      locals = { :content => numbered_title, :link => link }
      html = HL7Site.render_with_locals("clause#{depth}", locals)
    end
    
    def to_hl7_site(depth: 1, include_subclauses: true, parent: nil, parent_number: nil, link: nil)
      html = [to_hl7_section_header(depth, parent, parent_number)]
      included_content = content
      unless include_subclauses
        included_content = included_content.reject { |c| c.is_a?(SDoc::Clause) }
      end
      html += content.map { |c| c.to_hl7_site(:depth => depth + 1, :parent => self, :parent_number => number) }
      html.join("\n")
    end
    alias_method :hl7_page_content, :to_hl7_site
    
    def link_title
      parent = documents.first || containers.first
      parent.link_title + '_' + title.gsub(/\s/, '_').hl7
    end
  end
  
  class ClauseContent
  end
  
  class Table
    def to_hl7_site(_ = nil)
      # TODO some tables don't have a header row.  Currently no way to determine that.
      html = ["<caption>#{caption}</caption>"]
      # puts rendering_type.inspect
      html += rows.map { |r| r.to_hl7_site(r.header) }
      locals = { :content => html.join("\n") }
      HL7Site.render_with_locals(:table, locals)
    end
  end
  
  class Column
  end
  
  class Row
    def to_hl7_site(header = false)
      HL7Site.render_with_locals(:tr, {:content => cells.map { |c| c.to_hl7_site(header) }.join("\n") })
    end
  end
  
  class Cell
    def to_hl7_site(header = false)
      tag = header ? :th : :td
      HL7Site.render_with_locals(tag, {:content => content.map { |c| c.to_hl7_site(self) }.join("\n") })
    end
  end
  
  class Text
    def web_content
      # content_content.gsub(/\n/, '<br>').hl7
      content_content.hl7
    end
    
    def to_hl7_site(_ = nil)
      # TODO this might be different if the content is already HTML
      HL7Site.render_with_locals(:p, {:content => web_content})
    end
  end
  
  class Figure
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
      HL7Site.render_with_locals(:figure, {:content => html.join("\n") })
    end
  end
  
  class List
    def to_hl7_site(_ = nil)
      html = []
      items.each { |item| html << HL7Site.render_with_locals(:li, {:content => item.to_hl7_site })}
      HL7Site.render_with_locals(:ul, {:content => html.join("\n") })
    end
  end
  
  class Note
  end
  
  class Example
  end
end
