module V2Web
  
  class SectionContent
    def to_html
      "#{self.class}#to_html is not implemented"
    end
  end

  class Section
    # FIXME not sure this is correct anymore
    alias_association :subsections, 'V2Web::Section', :type => :many_to_many, :alias_of => :content
    
    # def subsections
    #   content.select { |c| c.is_a?(V2Web::Section) }
    # end
    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      "<strong>#{title}</strong>"
    end
    
    def numbered_title
      number + ' ' + title
    end
    
    def guess_root(from = parents)
      from.find { |parent| parent.is_a?(V2Web::Standard) } || guess_root(from.map(&:parents).flatten.compact)
    end
    
    # this will have problems if the same section exists in multiple places in a single Document.
    def number(root = guess_root)
      if parents.include?(root)
        i = root.subsections.index { |c| c.id == self.id }
        return (i + 1).to_s
      end
      ret = nil
      parents.find do |parent|
        val = parent.number(root)
        if val
          i = parent.subsections.index { |c| c.id == self.id }
          ret = val + '.' + (i + 1).to_s
        end
      end
      ret
    end #def number
    
    def site_depth(d = 1, root = nil)
      # if root isn't passed then we are totally guessing
      root ||= parents.find { |sect| sect.is_a?(V2Web::Standard) }
      site ? d : parent.site_depth(d + 1, root)
    end
    
    def hl7_page_link(root_dir, base_link)
      link = File.join(root_dir, local_link(base_link))
      locals = {:link => link, :title => title, :depth => site_depth}
      V2Web.render_with_locals(:v2_section_link, locals)
    end
    
    def link_title
      parents.first.link_title + '_' + title.gsub(/\s/, '_').hl7
    end
    
    def local_link(base_link)
      base_link + '_' + link_title + '.html'
    end
    
    def hl7_page_content(root_dir, section_link)
      linked_subsections = subsections.select { |s| s.is_a?(V2Web::Section) && s.render_as&.value == 'linked_page' }
      linked_subsections.each do |ss|
        ss_link = ss.local_link(section_link)
        ss_content = ss.hl7_page_content(root_dir, ss_link)
        V2Web.create_linked_page({:content => ss_content}, root_dir, ss_link)
      end
      html = to_hl7_section_header
      # NOTE giant assumption that everything after the first Clause is also a Clause...
      front_matter = content.take_while { |c| !c.is_a?(V2Web::Section)}
      html += front_matter.map { |l| l.to_hl7_site }.join("\n")
      
      subsections.each_with_index do |ss, index|
        if ss.is_a?(V2Web::Section)
          if ss.render_as == 'linked_page'
            html += ss.to_hl7_section_header(:link => section_link)
          else
            html += ss.hl7_page_content(root_dir, section_link)
          end
        else
          html += ss.hl7_page_content(self, root_dir, section_link, index)
        end
      end
      html
    end
    
    # FIXME!!!!!!!
    def to_hl7_site(depth: 1, include_subsections: true, parent: nil, parent_number: nil, link: nil)
      html = [to_hl7_section_header(depth, parent, parent_number)]
      included_content = content
      unless include_subsections
        included_content = included_content.reject { |c| c.is_a?(V2Web::Section) }
      end
      html += content.map { |c| c.to_hl7_site(:depth => depth + 1, :parent => self, :parent_number => number) }
      html.join("\n")
    end
    # alias_method :hl7_page_content, :to_hl7_site
    
    def to_hl7_section_header(depth: nil, parent: nil, parent_number: nil, link: nil)
      nt = numbered_title
      # puts nt
      depth = nt.slice(/^[\d\.]+/).split('.').count # this is hacky but should work
      
      # numbered_title = num + ' ' + title
      locals = { :content => numbered_title, :link => link }
      html = V2Web.render_with_locals("clause#{depth}", locals)
    end
    
    
    
    
    # returns relative url for created page
    # def to_linked_page(root, root_dir)
    #   link = "#{link_title}.html"
    #   location = File.join(root_dir, link)
    #   # FIXME TabSets just isn't worked out well
    #   # page_content = hl7_page_content + subsections.map { |ss| ss.hl7_page_content(self) }
    #   page = V2Web.render_with_locals(:page, {:content => hl7_page_content})
    #   File.open(location, 'w+') { |f| f.puts page }
    #   [link, title.hl7]
    # end
  end  
end
