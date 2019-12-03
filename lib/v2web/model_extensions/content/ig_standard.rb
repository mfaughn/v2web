require 'fileutils'
# require_relative 'ig_section'
load File.join(__dir__, 'ig_section.rb')

module V2Web
  class Standard
    def to_ig
      dir_name ||= title.gsub(/\s/, '_')
      root_dir = relative("../../../../IG/#{dir_name}")
      FileUtils.remove_entry_secure(root_dir) if File.exist?(root_dir)
      FileUtils.mkdir_p(root_dir)
      copy_ig_files(root_dir)      
      make_menu_xml(root_dir)
      
      contained_xml = linked_sections.map { |sect| sect.to_ig(root_dir) }.join("\n")

      page_content = front_matter.map { |l| l.to_hl7_site }.join("\n")
      make_page(page_content, root_dir, 'index')

      index_page_xml = make_page_xml('index', title, contained_xml)
      toc_page = make_toc_page_xml(index_page_xml)
      resources = '' # TODO
      ig_id = dir_name.gsub(/-|_/, '')
      ig_description = '' # TODO
      make_properties(root_dir, ig_id)
      make_ig_xml(root_dir, toc_page, resources, ig_id, title, ig_description)
    end
    
    def make_properties(root_dir, ig_id)
      props = """
      #guidename must match the id of the implementation guide
      guidename=#{ig_id}
      copyrightyear=2017+
      license=CC0-1.0
      version=0.0.0
      ballotstatus=STU 1
      fhirspec=http://build.fhir.org/
      #excludexml=Yes
      #excludejson=Yes
      #excludettl=Yes
      """
      location = File.join(root_dir, "src/properties.txt")
      File.open(location, 'w+') { |f| f.puts props }
    end
    
    def make_toc_page_xml(pages)
      substitutions = {:pages => pages}
      V2IG.render('toc_page.xml', substitutions)
    end
    
    def make_menu_xml(root_dir)
      links = linked_sections.map do |s|
        substitutions = {:href => "#{s.link_title}.html", :title => s.title.hl7}
        V2IG.render('li.xml', substitutions)
      end
      menu = V2IG.render('menu.xml', :list_items => links.join("\n"))
      menu_location = File.join(root_dir, 'src/includes/menu.xml')
      File.open(menu_location, 'w+') { |f| f.puts menu }
    end
    
    def make_ig_xml(root_dir, toc_page, resources, ig_id, ig_title, ig_description = nil)
      substitutions = {:toc_page => toc_page, :resources => resources, :ig_id => ig_id, :ig_title => ig_title, :ig_description => ig_description.to_s}
      ig = V2IG.render('ig.xml', substitutions)
      ig_location = File.join(root_dir, "src/#{ig_id}.xml")
      File.open(ig_location, 'w+') { |f| f.puts ig }
    end
      
    def copy_ig_files(dest, source_dir = nil)
      source ||= relative("../../../../ig_framework")
      FileUtils.copy_entry(source, dest)
    end
        
  end # Standard
end
