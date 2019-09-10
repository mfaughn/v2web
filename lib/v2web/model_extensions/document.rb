module SDoc
    
  class Document
    alias_association :clauses, 'SDoc::Clause', :type => :many_to_many, :alias_of => :content
  end
  
  class Clause
    alias_association :subclauses, 'SDoc::Clause', :type => :many_to_many, :alias_of => :content
    alias_method :clauses, :subclauses
    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      "<strong>#{title}</strong>"
    end
    
    # this will have problems if the same clause exists in multiple places in a single Document.
    def number_in(doc)
      if documents.include?(doc)
        i = doc.content.index { |c| c.id == self.id }
        return (i + 1).to_s
      end
      ret = nil
      containers.find do |container|
        # puts Rainbow("#{title} -- container: #{container&.title}").orange
        val = container.number_in(doc)
        if val
          i = container.content.index { |c| c.id == self.id }
          ret = val + '.' + (i + 1).to_s
        end
      end
      ret
    end #def number_in
  end # Clause
  
  class ClauseContent
    def to_html
      "#{self.class}#to_html is not implemented"
    end
  end
  
  class Text
    def to_html
      content.content
    end
    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      content_content[0..50]
    end
  end # Text
    
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
  end

  class Code
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      title
    end
  end

  class List
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      title
    end
  end

  class Table
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      if title
        title
      elsif caption
        caption
      else
        header_row_simple
      end
    end
    
    def to_html
      html_simple
    end
    
    derived_attribute :html_simple, String
    def html_simple
      html = []
      html << '<table>' # style="width:100%"
      html << "<caption>#{caption}</caption>" if caption
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
        html << "#{cell.html_content}"
      end
      'Table: ' + html.join(" | ")[0..50]
    end
  end
  
  class Cell
    def html_content
      content.map { |c| c.to_html }.join("\n")
    end
  end
end # SDoc
