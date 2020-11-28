module V2Plus
  class Composition
    def self.make(doc, identifier = nil)
      puts Rainbow("Warning! #{self.class}#make called from #{caller.first}").red unless caller.first =~ /make_and_cache/
      this = new
      node = doc.at_css('Composition')

      this.title    = node.get_val('title')
      # this.sections = node.css('section').map { |s| V2Plus::Section.make(s, this) } # sections
      section_nodes = []
      node.children.each { |n| section_nodes << n if n.name == 'section' }
      # this.sections = nodeset..select { |n| puts n.class; n.name == 'section' }.map { |s| puts s; V2Plus::Section.make(s, this) } # sections
      this.sections = section_nodes.map { |s| V2Plus::Section.make(s, this) } # sections
      this
    end
    
    def domain_name
      V2Plus.domain_name(title)
    end
    
    def to_web_pub
      locals = {
        :title => title,
        :sections => web_sections
      }
      page = V2Plus.render_with_locals(:composition, :page, locals)
      puts "Saving chapter-#{local_url_name}.html"
      V2Plus.save_web_file("chapter-#{local_url_name}.html", page)
    end
    
    def web_sections
      ss = []
      sections.each_with_index { |s, i| ss << s.to_composition_content(2, "#{local_url_name}-#{i+1}") }
      ss.join
    end
  end
end
