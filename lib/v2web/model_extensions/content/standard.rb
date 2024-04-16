require 'fileutils'

# require_relative 'ig_standard'
# load File.join(__dir__, 'ig_standard.rb')

module V2Web
  Domain = Standard unless defined?(Domain)
  class Standard
    def domain_name
      V2Pub.domain_name(title)
    end
    
    def self.process?(title)
      @skip ||= title == 'Query'
    end
    
    def self.reset_process
      @skip = nil
    end
    
    def to_web_pub
      # return unless self.class.process?(title)
      puts Rainbow("Rendering #{title}").cyan
      locals = {
        :title    => title,
        :sections => web_sections
      }
      page = V2Pub.render_with_locals(:domain, :page, locals)
      puts "Saving domain/#{local_url_name}.html"
      V2Pub.save_web_file("domain/#{local_url_name}.html", page)
    end
    
    def web_sections
      ss = []
      content.each_with_index { |s, i| ss << s.to_pub(2, "#{local_url_name}-#{i+1}") }
      ss.join
    end
    
    def to_toc(num)
      url = "domain/#{local_url_name}.html"
      locals = {
        :url      => url,
        :title    => "#{num} #{title}",
        :sections => toc_sections(url, num)
      }
      page = V2Pub.render_with_locals(:domain, :toc_entry, locals)
    end
    
    def toc_sections(url, num)
      ss = []
      counter = 0
      content.each_with_index do |s, i|
        next unless s.is_a?(V2Web::Section)
        next if s.render_as&.value == 'pre'
        counter += 1
        ss << s.to_toc(2, "#{url}##{local_url_name}-#{i+1}", "#{num}.#{counter}")
      end
      ss.join
    end
    
  end
end

module V2Web
  class Standard
    def local_url_name
      #FIXME make better
      # title.downcase.sub(/[^\W]/, '_')
      url_title
    end
    
    # def to_hl7_site_file(location = nil)
    #   payload = content.map { |c| c.to_hl7_site(:parent => self, :parent_number => nil) }.join("\n")
    #   V2Web.create_site_file(payload, location)
    # end
    # def to_hl7_site_FIXME
    #   V2Web.render_site(content.map { |c| c.to_hl7_site(:parent => self, :parent_number => nil) }.join("\n"))
    # end
    #
    # def to_hl7_site
    #   # Make a place to put everything and copy js/css/image files that will be needed
    #   dir_name ||= title.gsub(/\s/, '_')
    #   root_dir = relative("../../../../generated/#{Time.now.strftime('%B%d_%Y')}/#{dir_name}")
    #   FileUtils.remove_dir(root_dir, true) if File.exist?(root_dir)
    #   FileUtils.mkdir_p(root_dir)
    #   copy_web_files(root_dir)
    #
    #   # Do this now so we have the links to put in the navbar
    #   ls  = linked_sections.map { |s| [s.relative_url, s.numbered_title.hl7, s] }
    #
    #   set_section_numbers
    #   V2Web.store_tables(all_tables)
    #   V2Web.store_figures(all_figures)
    #   V2Web.store_footnotes(all_reordered_ckeditor_footnotes)
    #
    #   # FIXME ...if need be.  We are currently assuming that all of the main sections are going to be linked sections.  If any of the sections aren't linked, they are being lost here because we aren't doing anything with them.  This is only true for sections directly contained by the Standard obj.
    #
    #   # create the main page
    #   page_content = front_matter.map { |l| l.to_hl7_site }.join("\n")
    #   nav_bar_items = ls.map do |link, title, section|
    #     section_submenu_items = section.subsections.map do |subsection|
    #       V2Web.render_with_locals(:navbar_dropdown, {:link => subsection.relative_url(link), :title => subsection.numbered_title.hl7})
    #     end
    #     navbar_template = section.subsections.any? ? :navbar_dropdown_with_subs : :navbar_dropdown
    #     V2Web.render_with_locals(navbar_template, {:link => link, :title => title.hl7, :menu_items => section_submenu_items.join("\n") })
    #   end
    #   nav_bar_items = nav_bar_items.join("\n")
    #   locals = {:content => page_content, :navbar_items => nav_bar_items, :title => title, :homepage_url => 'main.html', :toc_url => 'toc.html' }
    #   page = V2Web.render_with_locals(:v2_page, locals)
    #
    #   main_location = File.join(root_dir, 'main.html')
    #   File.open(main_location, 'w+') { |f| f.puts page }
    #
    #   toc_entries = ls.map { |_,_,section| section.toc_entry }.join("\n")
    #   locals = {:entries => toc_entries}
    #   toc_page_content = V2Web.render_with_locals(:toc, locals)
    #   locals = {:content => toc_page_content, :navbar_items => nav_bar_items, :title => title, :homepage_url => 'main.html', :toc_url => nil }
    #   toc_page = V2Web.render_with_locals(:v2_page, locals)
    #   toc_location = File.join(root_dir, 'toc.html')
    #   File.open(toc_location, 'w+') { |f| f.puts toc_page }
    #
    #   ls.each do |link, _, section|
    #     content = section.hl7_page_content(root_dir, link)
    #     linked_page_locals = locals.merge({ :content => content, :title => section.title, :toc_url => 'toc.html' })
    #     linked_page = V2Web.create_linked_page(linked_page_locals, root_dir, link)
    #
    #   end
    #
    # end
    #
    def set_section_numbers
      V2Web.reset_sections
      linked_sections.each_with_index do |sect, i|
        sect.set_section_numbers((i+1).to_s)
      end
      # V2Web.sections_by_number.each { |n, sect| puts "#{n} -- #{sect.title}"}
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
