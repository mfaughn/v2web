require 'fileutils'

# require_relative 'ig_standard'
load File.join(__dir__, 'ig_standard.rb')

module V2Web
  class Standard
    def to_composition
      xml = HL7.get_instance_template(:composition, 'base')
      xml.sub!('YYYY-MM-DD', Time.now.strftime("%F"))
      xml.sub!('TITLE', title)      
      sections_xml = []
      subsections.each { |ss| sections_xml << ss.to_composition_section }
      xml.sub!('SECTIONS', sections_xml.join)
      Nokogiri::XML(xml,&:noblanks).to_s
    end
    
    def local_url_name
      #FIXME make better
      # title.downcase.sub(/[^\W]/, '_')
      url_title
    end
    
    def to_hl7_site_file(location = nil)
      payload = content.map { |c| c.to_hl7_site(:parent => self, :parent_number => nil) }.join("\n")
      V2Web.create_site_file(payload, location)
    end
    def to_hl7_site_FIXME
      V2Web.render_site(content.map { |c| c.to_hl7_site(:parent => self, :parent_number => nil) }.join("\n"))
    end
    
    def to_hl7_site
      # Make a place to put everything and copy js/css/image files that will be needed
      dir_name ||= title.gsub(/\s/, '_')
      root_dir = relative("../../../../generated/#{Time.now.strftime('%B%d_%Y')}/#{dir_name}")
      FileUtils.remove_dir(root_dir, true) if File.exist?(root_dir)
      FileUtils.mkdir_p(root_dir)
      copy_web_files(root_dir)
      
      # Do this now so we have the links to put in the navbar
      ls  = linked_sections.map { |s| [s.relative_url, s.numbered_title.hl7, s] }
      
      # FIXME ...if need be.  We are currently assuming that all of the main sections are going to be linked sections.  If any of the sections aren't linked, they are being lost here because we aren't doing anything with them.  This is only true for sections directly contained by the Standard obj.
      
      # create the main page
      page_content = front_matter.map { |l| l.to_hl7_site }.join("\n")
      nav_bar_items = ls.map do |link, title, section|
        section_submenu_items = section.subsections.map do |subsection|
          V2Web.render_with_locals(:navbar_dropdown, {:link => subsection.relative_url(link), :title => subsection.numbered_title.hl7})
        end
        navbar_template = section.subsections.any? ? :navbar_dropdown_with_subs : :navbar_dropdown
        V2Web.render_with_locals(navbar_template, {:link => link, :title => title.hl7, :menu_items => section_submenu_items.join("\n") })
      end
      nav_bar_items = nav_bar_items.join("\n")
      locals = {:content => page_content, :navbar_items => nav_bar_items, :title => title, :homepage_url => 'main.html', :toc_url => 'toc.html' }
      page = V2Web.render_with_locals(:v2_page, locals)
      
      main_location = File.join(root_dir, 'main.html')
      File.open(main_location, 'w+') { |f| f.puts page }
      
      toc_entries = ls.map { |_,_,section| section.toc_entry }.join("\n")
      locals = {:entries => toc_entries}
      toc_page_content = V2Web.render_with_locals(:toc, locals)
      locals = {:content => toc_page_content, :navbar_items => nav_bar_items, :title => title, :homepage_url => 'main.html', :toc_url => nil }
      toc_page = V2Web.render_with_locals(:v2_page, locals)
      toc_location = File.join(root_dir, 'toc.html')
      File.open(toc_location, 'w+') { |f| f.puts toc_page }
      
      ls.each do |link, _, section|
        content = section.hl7_page_content(root_dir, link)
        linked_page_locals = locals.merge({ :content => content, :title => section.title, :toc_url => 'toc.html' })
        V2Web.create_linked_page(linked_page_locals, root_dir, link)
      end
      
    end
    
    def linked_sections
      content.select { |c| c.is_a?(V2Web::Section) && c.render_as&.value == 'linked_page' }
    end
    
    def front_matter
      # document.content.take_while { |c| !c.is_a?(V2Web::Section)}
      content.take_while { |c| !c.is_a?(V2Web::Section)}
    end
    
    def copy_web_files(dest_dir, source_dir = nil)
      ['css', 'images', 'js'].each do |folder|
        source_dir ||= relative("../../site_files")
        source = File.join(source_dir, folder)
        dest   = File.join(dest_dir, folder)
        FileUtils.copy_entry(source, dest) #unless File.exist?(dest)
      end
    end
    
    # def link_title
    #   title.gsub(/\s/, '-').hl7
    # end
    
    def configure_site(config_file, tab_files)
      config = File.open(config_file) { |f| Nokogiri::XML(f) }.children.first
      configure(config, tab_files)
    end
    
    def to_v2_html_test(_ = nil)
      html  = super(0)
      # fname = title.gsub(/\s/, '_')
      fname = 'test' + chapter.to_s
      root_dir = relative("../../../v2plus_test")
      FileUtils.mkdir_p(root_dir)
      copy_web_files(root_dir)
      main_location = File.join(root_dir, "#{fname}.html")
      puts main_location
      File.open(main_location, 'w+') { |f| f.puts html }
    end
  end # Standard
end
