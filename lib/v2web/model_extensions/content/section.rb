module V2Web
  
  class SectionContent
    def to_html
      "#{self.class}#to_html is not implemented"
    end
  end

  class Section
    attr_accessor :configuration
    @@subsection_info = properties[:subsections]
    def immediate_aggregations_with_data
      {:subsections => {:value => subsections, :data => self.class.properties[:subsections] }}.to_a
    end
    
    # FIXME not sure this is correct anymore
    alias_association :subsections, 'V2Web::Section', :type => :many_to_many, :alias_of => :content
    
    alias_association :tab_sets, 'V2Web::TabSet', :type => :many_to_many, :alias_of => :content
    
    # def subsections
    #   content.select { |c| c.is_a?(V2Web::Section) }
    # end
    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      "<strong>#{title}</strong>"
    end
    
    derived_attribute(:display_name, ::String)
    def display_name
      # "<strong>#{title}</strong>"
      numbered_title
    end
    
    def numbered_title
      n = number
      n ? number + ' ' + title : title
    end
    
    def guess_root(from = parents)
      return nil unless parents.any?
      from.find { |parent| parent.is_a?(V2Web::Standard) } || guess_root(from.map(&:parents).flatten.compact)
    end
    
    # this will have problems if the same section exists in multiple places in a single Document.
    def number(root = guess_root)
      return nil unless parents.any?
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
    
    def link_title(parent = nil)
      parent ||= parents.first
      parent.link_title + '_' + url_title
    end
    
    def url_title
      title.gsub(/\s/, '_').delete(':').hl7
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
      front_matter = content.take_while { |c| !(c.is_a?(V2Web::Section) || c.is_a?(V2Web::TabSet))}
      html += front_matter.map { |l| l.to_hl7_site }.join("\n")
      
      # sections_and_tabs = content.select { |c| c.is_a?(V2Web::Section) || c.is_a?(V2Web::TabSet) }
      sections_and_tabs = content - front_matter
      sections_and_tabs.each_with_index do |ss, index|
        if ss.is_a?(V2Web::Section)
          if ss.render_as == 'linked_page'
            html += ss.to_hl7_section_header(:link => section_link)
          else
            html += ss.hl7_page_content(root_dir, section_link)
            # This helps to narrow down encoding errors
            # begin
            #   added = nil
            #   more  = ss.hl7_page_content(root_dir, section_link)
            #   more.split('<').each do |fragment|
            #     added = fragment
            #     html += fragment + '<'
            #   end
            # rescue
            #   puts Rainbow('Problem in ' + number).red
            #   puts added
            #   raise
            # end
          end
        else
          html += ss.hl7_page_content(self, root_dir, section_link, index)
        end
      end
      html
    end
    
    # FIXME!!!!!!! Fix what? This seems to never be called.  Get rid of it?
    def to_hl7_site(depth: 1, include_subsections: true, parent: nil, parent_number: nil, link: nil)
      raise "Who called this!"
      html = [to_hl7_section_header(depth, parent, parent_number)]
      included_content = content
      unless include_subsections
        included_content = included_content.reject { |c| c.is_a?(V2Web::Section) }
      end
      html += content.map { |c| c.to_hl7_site(:depth => depth + 1, :parent => self, :parent_number => number) }
      html.join("\n")
    end
    # alias_method :hl7_page_content, :to_hl7_site
    
    def to_hl7_section_header(link: nil)
      nt = numbered_title
      # puts nt
      depth = nt.slice(/^[\d\.]+/).split('.').count # this is hacky but should work
      
      # numbered_title = num + ' ' + title
      locals = { :content => numbered_title.hl7, :link => link }
      html = V2Web.render_with_locals("clause#{depth}", locals)
    end
    
    def configure(config, tab_files)
      ts = config.children.find { |n| n.name == 'tabSet' }
      configure_tab_set(config, ts, tab_files) if ts
      config_sections = config.children.select { |c| c.name == 'section' }
      configuration_pairs = subsections.zip(config_sections)
      configuration_pairs.each do |sect, sect_config|
        same = sect.title == sect_config['title']
        if same
          sect.configure(sect_config, tab_files)
        else
          puts Rainbow("#{sect.title} is not #{sect_config['location']} #{sect_config['title']}").red
        end
      end
    end
    
    def configure_tab_set(config, ts, tab_files)
      # ASSUMPTIONS
      # one tabset per section
      # tabset comes immediately before subsections
      # subsections all come after textual content
      tabset = content.find { |c| c.is_a?(V2Web::TabSet) }
      unless tabset
        ChangeTracker.start
        tabset = V2Web::TabSet.create(:title => ts['title'])
        add_content(tabset)
        save
        ChangeTracker.commit
        first_section = content.find { |c| c.is_a?(V2Web::Section) }
        if first_section
          position = content.find_index(first_section)
          ChangeTracker.start
          move_content(tabset, position)
          ChangeTracker.commit
        end
      end
      tabset.configure(ts,tab_files)
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
