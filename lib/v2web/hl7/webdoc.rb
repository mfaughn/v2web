require_relative 'tabs'
module WebDoc
  class Homepage
    def to_hl7_site(root_dir = nil)
      # create the homepage
      # - create a level for each level
      # - create groups in each level
      # - create links in each section
      # create pages for each group.doc
      # create pages for each section.doc
      # connect everthing
      root_dir ||= relative('../pages/v2plus')
      content = levels.map { |l| l.to_hl7_site(self, root_dir) }.join("\n")
      page = HL7Site.render_with_locals(:homepage, {:content => content})
      home_location = File.join(root_dir, 'main.html')
      File.open(home_location, 'w+') { |f| f.puts page }
    end
  end # Homepage
  
  class Level
    def level_number
      (homepage.levels.index { |level| level.id == id }) + 1
    end
    def to_hl7_site(homepage, root_dir)
      content = groups.map { |g| g.to_hl7_site(homepage, root_dir) }.join("\n")
      locals = {:level_number => level_number, :level_text => text, :content => content}
      # Don't need to create file for Level
      return HL7Site.render_with_locals(:level, locals)
    end
  end # Level
  
  # NOTE Gigantic assumption here is that each Level is based off of a single document (from Rob Snelick).  This will surely change and we will need to re-code how clause numbering happens.
  class LevelGroup
    # directs creation of independent page and returns snippet for inclusion on homepage
    def to_hl7_site(homepage, root_dir)
      section_links = sections.map { |section| [section.to_hl7_page(homepage, root_dir), section.doc.title] }
      # page creation method returns the local url for the created page 
      link = to_hl7_page(root_dir)
      locals = {:level_group_link => link, :level_group_title => doc.title, :section_links => section_links}
      return HL7Site.render_with_locals(:level_group, locals)
    end
    # returns relative url for created page
    def to_hl7_page(root_dir)
      link = "#{doc.link_title}.html"
      location = File.join(root_dir, link)
      page = HL7Site.render_with_locals(:page, {:content => doc.hl7_page_content(:depth => 1, :include_subclauses => false)})
      File.open(location, 'w+') { |f| f.puts page }
      link
    end
  end # LevelGroup
  
  class Section
    # returns relative url for created page
    def to_hl7_page(homepage, root_dir)
      link = "#{doc.link_title}.html"
      location = File.join(root_dir, link)
      stuff = doc.hl7_page_content + subsections.map { |ss| ss.hl7_page_content(self) }
      page = HL7Site.render_with_locals(:page, {:content => doc.hl7_page_content})
      File.open(location, 'w+') { |f| f.puts page }
      link
    end
  end
  
end
