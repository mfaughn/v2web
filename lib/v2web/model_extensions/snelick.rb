require 'fileutils'
module Snelick
  
  # Maybe we should pass locals in instead of just passing content
  def self.create_linked_page(locals, root_dir, link)
    location = File.join(root_dir, link)
    page = HL7Site.render_with_locals(:snelick_page, locals)
    File.open(location, 'w+') { |f| f.puts page }
  end
  
  class Site
    def to_hl7_site(title = nil)
      # Make a place to put everything and copy js/css/image files that will be needed
      title ||= name.gsub(/\s/, '_')
      root_dir = relative("../pages/#{title}")
      FileUtils.mkdir_p(root_dir)
      copy_web_files(root_dir)
      
      # Do this now so we have the links to put in the navbar
      ls  = linked_sections.map { |s| ["#{s.doc.link_title}.html", s.doc.title.hl7, s] }
      
      # FIXME ...if need be.  We are currently assuming that all of the main sections are going to be linked sections.  If any of the sections aren't linked, they are being lost here because we aren't doing anything with them.  This is only true for sections directly contained by the Site obj.
      
      # create the main page
      page_content = front_matter.map { |l| l.to_hl7_site }.join("\n")
      nav_bar_items = ls.map { |link, title, _| HL7Site.render_with_locals(:navbar_item, {:link => link, :title => title})}.join("\n")
      locals = {:content => page_content, :navbar_items => nav_bar_items, :title => title, :homepage_url => 'main.html'}
      page = HL7Site.render_with_locals(:snelick_page, locals)
      
      main_location = File.join(root_dir, 'main.html')
      File.open(main_location, 'w+') { |f| f.puts page }
      
      ls.each do |link, _, section|
        content = section.hl7_page_content(root_dir, link)
        linked_page_locals = locals.merge({:content => content, :title => section.doc.title})
        Snelick.create_linked_page(linked_page_locals, root_dir, link)
      end
      
    end
    def linked_sections
      content.select { |c| c.is_a?(Snelick::Section) && c.render_as&.value == 'linked_page' }
    end
    def front_matter
      # document.content.take_while { |c| !c.is_a?(SDoc::Clause)}
      doc.content.take_while { |c| !c.is_a?(SDoc::Clause)}
    end
    def copy_web_files(dest_dir, source_dir = nil)
      ['css', 'images', 'js'].each do |folder|
        source_dir ||= File.join(dest_dir, '..', 'v2plus')
        source = File.join(source_dir, folder)
        dest   = File.join(dest_dir, folder)
        FileUtils.copy_entry(source, dest) #unless File.exist?(dest)
      end
    end
      
  end # Site
  
  class Section
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      doc.title
    end
    
    # Will return the first site found. Not guaranteed to be correct unless this Section is found in only one site. FIXME
    def get_site
      site ? site : parent.get_site
    end
    
    def site_depth(d = 1)
      site ? d : parent.site_depth(d + 1)
    end
    
    def hl7_page_link(root_dir, base_link)
      link = File.join(root_dir, local_link(base_link))
      title = doc.title
      locals = {:link => link, :title => title, :depth => site_depth}
      HL7Site.render_with_locals(:snelick_section_link, locals)
    end
    
    def local_link(base_link)
      base_link + '_' + doc.link_title + '.html'
    end
    
    def hl7_page_content(root_dir, section_link)
      linked_subsections = subsections.select { |s| s.is_a?(Snelick::Section) && s.render_as&.value == 'linked_page' }
      linked_subsections.each do |ss|
        ss_link = ss.local_link(section_link)
        ss_content = ss.hl7_page_content(root_dir, ss_link)
        Snelick.create_linked_page({:content => ss_content}, root_dir, ss_link)
      end
      html = doc.to_hl7_section_header
      # NOTE giant assumption that everything after the first Clause is also a Clause...
      front_matter = doc.content.take_while { |c| !c.is_a?(SDoc::Clause)}
      html += front_matter.map { |l| l.to_hl7_site }.join("\n")
      
      subsections.each_with_index do |ss, index|
        if ss.is_a?(Snelick::Section)
          if ss.render_as == 'linked_page'
            html += ss.doc.to_hl7_section_header(:link => section_link)
          else
            html += ss.hl7_page_content(root_dir, section_link)
          end
        else
          html += ss.hl7_page_content(self, root_dir, section_link, index)
        end
      end
      html
    end
    # returns relative url for created page
    # def to_linked_page(root, root_dir)
    #   link = "#{doc.link_title}.html"
    #   location = File.join(root_dir, link)
    #   # FIXME TabSets just isn't worked out well
    #   # page_content = doc.hl7_page_content + subsections.map { |ss| ss.hl7_page_content(self) }
    #   page = HL7Site.render_with_locals(:page, {:content => doc.hl7_page_content})
    #   File.open(location, 'w+') { |f| f.puts page }
    #   [link, doc.title.hl7]
    # end
  end
  
  class TabSet
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      tabs.map(&:type).map(&:value).join(', ')
    end
    
    def hl7_page_content(parent, root_dir, link, tab_set_index)
      tabs_id = (link.sub('.html', '')) + '-tab_set' + tab_set_index.to_s
      tabs_data = []
      tabs.each_with_index { |tab, index| tabs_data << tab.to_hl7_site(tabs_id, index, root_dir, link) }
      tabs_labels  = tabs_data.map { |tab| tab[:label] }.join("\n")
      tabs_content = tabs_data.map { |tab| tab[:content] }.join("\n")
      locals = {:tabs_id => tabs_id, :tabs_content => tabs_content, :tabs_labels => tabs_labels}
      set = HL7Site.render_with_locals(:tabs, locals)
    end
    
    # def set_number(parent)
    #   parent.subsets.select { |ss| ss.is_a?(WebDoc::TabSet) }.index { |ss| ss.id == id }
    # end
    # def hl7_page_content(parent)
    #   tabs_id = parent.doc.link_title + 'tab_set' + set_number(parent)
    #   tabs_data = tabs.map { |t| t.to_hl7_site }
    #   tabs_labels = tabs_data.map { |t| t[:label] }
    #   tabs_content = tabs_data.map { |t| t[:content] }
    #   locals = {:tabs_id => tabs_id, :tabs_content => tabs_content, :tabs_labels => tabs_labels}
    #   set = HL7Site.render_with_locals(:tabs, locals)
    # end
  end # class TabSet
  
  class Tab
    def to_hl7_site(parent_id, index, root_dir, link)
      location  = File.join(root_dir, link)
      code_type = type.value
      tab_index = index == 0 ? '0' : '-1'
      selected  = index == 0 ? 'true' : 'false'
      tab_content_id = parent_id + '-folder' + (index + 1).to_s
      tab_label_id   = parent_id + '-label'  + (index + 1).to_s
      tab_url = location + '#' + tab_content_id
      # code in the code property of the Tab object supercedes any file that the Tab object has
      # FIXME maybe it should be the other way around.  if it is an image file we definitely want that and no goop that may be in @code
      tab_content = code.content
      if (tab_content.nil? || tab_content.strip.empty?) && file
        tab_content = file.binary_data&.data
      end
      if (tab_content.nil? || tab_content.strip.empty?)
        tab_content = 'Content Missing'
      end
      locals = {:tabs_id => parent_id, :tab_title => code_type, :tab_index => tab_index, :selected => selected, :tab_content_id => tab_content_id, :tab_label_id => tab_label_id, :tab_url => tab_url, :tab_content_inner_id => (tab_content_id + '-inner'), :tab_content => tab_content}
      
      content_html = case
      when code_type =~ /XML|XSD|FHIR Structure Definition/
        HL7Site.render_with_locals(:tab_content_xml, locals)
      when code_type =~ /Message/ # FIXME for now, this is an HTML table pasted in just for demonstration purposes
        HL7Site.render_with_locals(:tab_content, locals)
      when code_type =~ /ER7/ # FIXME for now, this is an image file -- just for demonstration purposes
        fn = File.join(root_dir, 'images', tab_content_id + '_' + file_filename)
        File.open(fn, "w+b") { |file| file.puts tab_content }
        locals[:img_src] = fn
        HL7Site.render_with_locals(:tab_content_image, locals)
      else
        HL7Site.render_with_locals(:tab_content, locals)
      end
      label_html = HL7Site.render_with_locals(:tab_label, locals)
      {:content => content_html, :label => label_html}
    end
  end # class Tab
  
end
