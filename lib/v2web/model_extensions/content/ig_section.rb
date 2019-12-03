module V2Web

  class Section
    
    # returns xml <page/> element
    def to_ig(root_dir)
      name_url = title.gsub(/\s/, '_')
      content = ig_page_content(root_dir)
      make_page(content, root_dir, name_url)
      linked_subsections = subsections.select { |s| s.is_a?(V2Web::Section) && s.render_as&.value == 'linked_page' }
      
      contained_page_xml = linked_subsections.map do |lss|
        lss.to_ig(root_dir)
      end
      contained_page_xml = contained_page_xml.join("\n")
      make_page_xml(name_url, title, contained_page_xml, generation = :markdown)
    end
    
    def make_page(content, root_dir, name_url, generation = :markdown)
      locals = {:content => content}
      page = V2Web.render_with_locals(:ig_page, locals)
      extension = case generation
                  when :markdown; 'markdown'
                  when :html; 'html'
                  else
                    raise
                  end
      page_location = File.join(root_dir, "src/pagecontent/#{name_url}.#{extension}")
      File.open(page_location, 'w+') { |f| f.puts content }
    end
    
    def make_page_xml(name_url, title, pages = '', generation = :markdown)
      substitutions = {:pages => pages, :generation => generation.to_s, :title => title, :name_url => name_url}
      V2IG.render('page.xml', substitutions)
    end
    
    def ig_page_content(root_dir)
      html = to_hl7_section_header
      # NOTE giant assumption that everything after the first Clause is also a Clause...
      front_matter = content.take_while { |c| !c.is_a?(V2Web::Section)}
      html += front_matter.map { |l| l.to_hl7_site }.join("\n")
      
      subsections.each_with_index do |ss, index|
        if ss.is_a?(V2Web::Section)
          section_link = title.gsub(/\s/, '_').hl7
          if ss.render_as == 'linked_page'
            html += ss.to_hl7_section_header(:link => section_link)
          else
            html += ss.hl7_page_content(root_dir, section_link)
          end
        else # then it is a TabSet? Could it be anything else?  TODO clarify
          html += ss.hl7_page_content(self, root_dir, section_link, index)
        end
      end
      html
    end # def ig_page_content
  
  end  
end
