module V2Web
  class Section
    attr_accessor :configuration

    def immediate_aggregations_with_data
      {:subsections => {:value => subsections, :data => self.class.properties[:subsections] }}.to_a
    end
    
    # For debugging because we're just getting the first in the path
    def _breadcrumbs
      bc = [self.title]
      bc = bc + parents.first._breadcrumbs if parents.first
      bc
    end
    
    # For debugging because we're just getting the first in the path
    def breadcrumbs
      _breadcrumbs.reverse.join(' > ')
    end
    
    # FIXME not sure this is correct anymore
    alias_association :subsections, 'V2Web::Section', :type => :many_to_many, :alias_of => :content
    
    alias_association :tab_sets, 'V2Web::TabSet', :type => :many_to_many, :alias_of => :content
    
    def subsections
      content.select { |c| c.is_a?(V2Web::Section) }
    end
    
    def subcontent
      content.select { |c| c.is_a?(V2Web::Section) || c.is_a?(V2Web::Reference) }
    end
    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      "<strong>#{title}</strong>"
    end
    
    derived_attribute(:display_name, ::String)
    def display_name
      # "<strong>#{title}</strong>"
      numbered_title
    end

    def to_composition_section
      xml = HL7::V2.get_instance_template(:domain, 'section')
      [:title].each do |methd|
        xml.sub!(methd.to_s.upcase, send(methd).to_s)
      end
      xml.sub!('NARRATIVE', resource_narrative)
      xml.sub!('ENTRY', '') # FIXME do we actually need to put something here? When?
      xml.sub!('EMTPY_REASON', '') # FIXME do we actually need to put something here? When?
      sections_xml = []
      subsections.each { |ss| sections_xml << ss.to_composition_section }
      xml.sub!('SECTIONS', sections_xml.join)
      # puts xml;puts '*********************************************************'
      nxml = Nokogiri::XML(xml) { |config| config.strict.noblanks }.root.to_s
      # puts nxml;puts '*********************************************************'
      nxml
    end
    
    def resource_narrative
      html = to_hl7_section_header
      # NOTE giant assumption that everything after the first Clause is also a Clause...
      front_matter = content.take_while { |c| !(c.is_a?(V2Web::Section) || c.is_a?(V2Web::TabSet))}
      html << front_matter.map { |item| item.to_hl7_site }.join("\n")
      html
    end
    
    def numbered_title
      # return title if title =~ /^(Glossary|Appendix)/
      n = number
      n ? number + ' ' + title : title
    end
    
    def chaptered_title
      chapter + ' ' + title
      # n ? n + ' ' + title : title
    end

    # depth first...much less than an ideal way to determine this stuff.  completely unreliable if there are multiple parents    
    def guess_root(from = parents)
      return nil unless parents.any?
      from.find { |parent| parent.is_a?(V2Web::Standard) } || guess_root(from.map(&:parents).flatten.compact)
    end
    
    # depth first...much less than an ideal way to determine this stuff.  completely unreliable if there are multiple parents
    def guess_link_root(from = parents)
      return nil unless parents.any?
      from.find { |parent| parent.is_a?(V2Web::Section) && parent.render_as&.value == 'linked_page' } || guess_link_root(from.map(&:parents).flatten.compact)
    end
    
    # this will have problems if the same section exists in multiple places in a single Document.
    def chapter(root = guess_root)
      return nil unless parents.any?
      if parents.include?(root)
        i = root.subsections.index { |c| c.id == self.id }
        return "#{root.chapter}.#{i + 1}"
      end
      ret = nil
      parents.find do |parent|
        parent_chapter = parent.chapter(root)
        if parent_chapter
          i = parent.subsections.index { |c| c.id == self.id }
          ret = "#{parent_chapter}.#{i + 1}"
        end
      end
      ret
    end #def chapter
    
    # this will have problems if the same section exists in multiple places in a single Document.
    def number(root = guess_root)
      return nil unless parents.any?
      if parents.include?(root)
        i = root.subsections.index { |c| c.id == self.id }
        return (i + 1).to_s
      end
      ret = nil
      # parents.find do |parent|
      #   appendix_val = parent.title.slice(/(?<=Appendix )[A-Z]+/) if parent.title =~ /^Appendix/
      #   if appendix_val
      #     i = parent.subsections.index { |c| c.id == self.id }
      #     ret = appendix_val + '.' + (i + 1).to_s
      #   end
      # end
      # return ret if ret
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
    
    # def hl7_page_link(root_dir, base_link)
    #   raise
    #   link = File.join(root_dir, local_link(base_link))
    #   locals = {:link => link, :title => title, :depth => site_depth}
    #   V2Web.render_with_locals(:v2_section_link, locals)
    # end
    
    # def link_title
    #   url_title
    # end
    
    def url_title
      title.gsub(/\s/, '-').delete(':').hl7
    end
    
    def local_link(base_page_url)
      if render_as&.value == 'linked_page'
        # base_page_url + '_' + url_title + '.html'
        url_title + '.html'
      else
        base_page_url + '#' + html_id
      end
    end
    
    def html_id
      numbered_title.gsub(/\W/, '-')
    end
    
    def front_matter
      content.take_while { |c| !(c.is_a?(V2Web::Section) || c.is_a?(V2Web::TabSet))}
    end

    def hl7_page_content(root_dir, section_link)  
      linked_subsections = subsections.select { |s| s.is_a?(V2Web::Section) && s.render_as&.value == 'linked_page' }
      linked_subsections.each do |ss|
        # FIXME if you ever need to....
        raise "This section of code doesn't work because you aren't sending all of the variables necessary for the v2_page haml in the locals!"
        ss_link = ss.local_link(section_link)
        ss_content = ss.hl7_page_content(root_dir, ss_link)
        V2Web.create_linked_page({:content => ss_content, :title => title}, root_dir, ss_link)
      end
      html = to_hl7_section_header
      # NOTE giant assumption that everything after the first Clause is also a Clause...
      html << front_matter.map { |l| l.to_hl7_site }.join("\n")
      html = handle_ck_footnotes(html) # We are pretty much requiring that ALL footnotes be entered using ck_editor
      html = link_references(html, section_link)

      # sections_and_tabs = content.select { |c| c.is_a?(V2Web::Section) || c.is_a?(V2Web::TabSet) }
      sections_and_tabs = content - front_matter
      sections_and_tabs.each_with_index do |ss, index|
        if ss.is_a?(V2Web::Section)
          if ss.render_as == 'linked_page'
            html << ss.to_hl7_section_header(:link => section_link)
          else
            html << ss.hl7_page_content(root_dir, section_link)
            # This helps to narrow down encoding errors
            # begin
            #   added = nil
            #   more  = ss.hl7_page_content(root_dir, section_link)
            #   more.split('<').each do |fragment|
            #     added = fragment
            #     html << fragment + '<'
            #   end
            # rescue
            #   puts Rainbow('Problem in ' + number).red
            #   puts added
            #   raise
            # end
          end
        else
          html << ss.hl7_page_content(self, root_dir, section_link, index)
        end
      end
      html
    end
    
    def link_references(html, base_link)
      html = html.gsub(/<span style="color:#0000ff">(.*?)<\/span>/, '\1')
      mentions = html.scan(/(....)\s*(Table|Figure|Section)\s*(\d+(?:\.\d+)+)(....)/im) + html.scan(/(....)(Section)\s*(\d+)([^\.]..)/)
      if mentions.any?
        # puts html
        # puts '*'*33
      end
      mentions.reject! { |m| m.first =~ /ion>/ }
      mentions.uniq.each do |leading,type,num,trailing|
        key = "#{type} #{num}"
        if type.downcase == 'table'          
          table = V2Web.tables_by_number[num]
          html.gsub!(/#{Regexp.escape(leading)}(\s*)#{type}\s*#{num}#{Regexp.escape(trailing)}/im, leading + '\1' + "<a href=#{base_link}##{table.html_id}>#{type} #{num}</a>#{trailing}")
          # puts table.caption if table
          puts Rainbow('no match for ' + key).red unless table
        elsif type.downcase == 'figure'
          # skip alt text
          next if leading =~ /t = '/
          # puts Rainbow(key).magenta
          fig = V2Web.figures_by_number[num]
          html.gsub!(/#{Regexp.escape(leading)}(\s*)#{type}\s*#{num}#{Regexp.escape(trailing)}/im, leading + '\1' + "<a href=#{base_link}##{fig.html_id}>#{type} #{num}</a>#{trailing}")
          # puts fig.caption if fig
          puts Rainbow('no match for ' + key).red unless fig
        else # section
          sect = V2Web.section_by_number(num)
          sect ||= V2Web.section_by_number('6.5') if num == '6.1.5' # fix for typo in Conformance Doc footnotes
          unless sect
            puts Rainbow("Did not find #{type} #{num}! Skipping reference.").red
            next
          end
          # puts Rainbow("Found #{sect.title} for #{num}").orange
          html.gsub!(/#{Regexp.escape(leading)}(\s*)#{type}\s*#{num}#{Regexp.escape(trailing)}/im, leading + '\1' + "<a href=#{sect.reference_url}>#{type} #{num}</a>#{trailing}")
          # puts sect.reference_url
        end
      end
      html
    end
    
    def handle_ck_footnotes(html)
      lf = local_footnotes
      # pp  local_footnotes.map { |x| x[:original_footnote] }
      if lf.any?
        fnotes = []
        lf.each do |entry|
          html = html.sub(entry[:original_reference], entry[:reference])
          fnotes << entry[:footnote]
        end
        html.gsub!(/<section class="footnotes">.+?<\/section>/m, '')
        html << V2Web.render_with_locals(:ck_footnotes, {:footnotes => fnotes} )
      end
      html
    end
    
    def local_texts
      texts = []
      front_matter.map do |item|
        if item.is_a?(V2Web::Text)
          texts << item
        else
          texts << item.all_texts
        end
      end
      texts.flatten
    end
    
    def local_footnotes
      local_texts.map(&:id).map { |txt_id| V2Web.footnotes.select { |entry| entry[:text_id] == txt_id }}.flatten
    end
    
    # TODO move all lists into text.  move all footnotes into text using ck_editor footnotes
    def all_ckeditor_footnotes
      entries = []
      all_texts.each do |txt|
        c = txt.content_content
        next unless c =~ /data-footnote-id/
        body, fnote_section = c.split(/(?=<section class="footnotes">)/)
        refs = body.scan(/<sup data-footnote-id.+?<\/sup>/m)
        fnotes = fnote_section.scan(/<li data-footnote-id.+?<\/li>/m)
        unless refs.count == fnotes.count
          puts c
          raise "References count != Footnotes count in Text[#{txt.id}]"
        end
        refs.zip(fnotes).each_with_index do |pair, i|
          # NOTE hopefully we don't need :order_in_text
          entries << {:text_id => txt.id, :original_reference => pair.first, :original_footnote => pair.last, :order_in_text => i}
        end
      end
      entries
    end
    
    def all_reordered_ckeditor_footnotes
      counter = 1
      reordered = all_ckeditor_footnotes
      reordered.each do |entry|
        entry[:counter] = counter
        entry[:reference] = "<span class='id_anchor2' id='footnote-marker-#{entry[:text_id]}-#{counter}'></span>" + entry[:original_reference]
          .sub(/href="#footnote-\d+"/, "href='#footnote-#{counter}'")
          .sub(/id="footnote-marker-\d+-\d+"/, '')
          .sub(/>\[\d+\]</, ">#{counter}<")
        entry[:footnote]  = "<div class='id_anchor' id='footnote-#{counter}'></div>" + entry[:original_footnote]
          .sub(/id="footnote-\d+"/, '')
          .sub(/href="#footnote-marker-\d+-\d+">.</, "href='#footnote-marker-#{entry[:text_id]}-#{counter}'>#{counter}<")
          .sub('<li ', '<p.v2_footnote ')
          .sub('</li>', '</p>')
        counter += 1
      end
      reordered
    end
    
    def all_texts
      texts = []
      front_matter.each do |item|
        if item.is_a?(V2Web::Text)
          texts << item
        else
          texts.concat(item.all_texts)
        end
      end
      subsections.each { |ss| texts.concat(ss.all_texts) }
      texts
    end
    
    def all_tables
      tables = []
      front_matter.each do |item|
        if item.is_a?(V2Web::Table)
          tables << item
        elsif item.is_a?(V2Web::Box)
          tables.concat(item.all_tables)
        else
          # do nothing.  assuming that no other content types contain tables....which is bound to change...
        end
      end
      subsections.each { |ss| tables.concat(ss.all_tables) }
      tables
    end
    
    def all_figures
      figures = []
      front_matter.each do |item|
        if item.is_a?(V2Web::Figure)
          figures << item
        elsif item.is_a?(V2Web::Box)
          figures.concat(item.all_figures)
        else
          # do nothing.  assuming that no other content types contain figures....which is bound to change...
        end
      end
      subsections.each { |ss| figures.concat(ss.all_figures) }
      figures
    end

    def set_section_numbers(val)
      # puts "Setting #{val} as #{self.title}"
      V2Web.set_section_number(self, val)
      subsections.each_with_index do |sect, i|
        sect.set_section_numbers("#{val}.#{i+1}")
      end
    end
    
    def toc_entry(base_url = nil)
      # puts "toc_entry. base_url for #{numbered_title} is #{base_url}"
      url = relative_url(base_url)
      # puts "url is #{url}"
      locals = { :entry => numbered_title, :url => url, :subentries => toc_subentries(base_url || url) }
      html = V2Web.render_with_locals("toc_entry", locals)
    end
    
    def toc_subentries(url)
      base_url = url.split('#').first
      subsections.map { |ss| ss.toc_entry(base_url) }.join("\n")
    end

    def to_hl7_section_header(link: nil)
      nt = numbered_title
      # puts nt
      depth_indicator = nt.slice(/^[\d\.]+/) || nt.slice(/^[A-Z]+[\d\.]+/)
      depth_indicator ||= 'X' # hack in case the numbered_title is something like 'Glossary', forces depth to be 1
      depth = depth_indicator.split('.').count # this is hacky but should work
      # puts "#{depth} -- #{nt}"
      # numbered_title = num + ' ' + title
      
      depth = depth - 1 if depth > 0 # HACK experimental
      # locals = { :content => numbered_title.hl7, :link => link, :section_id => html_id }
      locals = { :content => numbered_title.hl7, :number => number.hl7, :title => title.hl7, :link => link, :section_id => html_id }
      html = V2Web.render_with_locals("clause#{depth}", locals)
    end
    
    def relative_url(base_url = nil)
      if base_url
        "#{base_url}##{html_id}"
      else
        url_title + '.html'
      end
    end
    
    def reference_url
      if render_as&.value == 'linked_page'
        url_title + '.html'
      else
        relative_url(guess_link_root.relative_url)
      end
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
    #   link = "#{url_title}.html"
    #   location = File.join(root_dir, link)
    #   # FIXME TabSets just isn't worked out well
    #   # page_content = hl7_page_content + subsections.map { |ss| ss.hl7_page_content(self) }
    #   page = V2Web.render_with_locals(:page, {:content => hl7_page_content})
    #   File.open(location, 'w+') { |f| f.puts page }
    #   [link, title.hl7]
    # end

    def toc(indent = 0)
      puts "#{'  ' * indent}#{title}"
      subsections.each { |ss| ss.toc(indent + 1) }
    end

    def to_v2_html_test(depth = 0)
      html = []
      # locals = { :content => numbered_title.hl7, :link => link, :section_id => html_id }
      locals = { :content => numbered_title.hl7, :number => number.hl7, :title => title.hl7, :link => link, :section_id => html_id }
      # header
      html << V2Web.render_with_locals("clause#{depth}", locals)
      content.each { |c| html << c.to_v2_html_test(depth + 1) }
      html.join("\n")
    end
  end  
end

module V2Web
  class Section
        
    def to_pub(depth, html_id)
      ensure_valid_content_ordering
      output = case render_as&.value
      when 'pre'
        to_pub_pre
      when 'clause'
        to_pub_clause(depth, html_id)
      # when 'segment-definition'
     #    obj_id  = entry.split('/').last
     #    pbug entry, 'orange'
     #    begin
     #      seg_def = SegmentDefinition.get(obj_id)
     #      seg_content = seg_def.to_pub_clause(depth)
     #      V2Pub.render_with_locals(:section, :wrapper_div, {:html_id => html_id, :depth => depth, :content => seg_content})
     #    rescue Exception => e
     #      # Doesn't get much dirtier than this ....
     #      return '' if e.message =~ /segment-usage-in-vaccine-messages/
     #      raise
     #    end
      when 'datatype-definition'
        obj_id = entry.split('/').last
        dt     = DataType.get(obj_id)
        dt_content = dt.to_pub_clause(depth)
        V2Pub.render_with_locals(:section, :wrapper_div, {:html_id => html_id, :depth => depth, :content => dt_content})
      else
        puts "Section for #{code} -- #{entry}"
      end
      # err = Nokogiri::XML(output).errors
      # if err.any?
      #   puts err
      #   raise
      # end
      output
    end
    
    def to_pub_pre
      html = []
      content.each do |c|
        case c
        when V2Web::Text
          html << c.content.content
        when V2Web::Figure
          html << c.to_web_pub
        else
          raise "Can't handle a #{c.class} in clause frontmatter."
        end
      end
      html.join("\n")
    end
    
    def to_pub_clause(depth, html_id)
      locals = {
        :html_id  => html_id,
        :depth    => depth,
        :title    => title,
        :content  => completed_text(depth + 1),
        :sections => pub_subcontent(depth + 1, html_id)
      }
      html = V2Pub.render_with_locals(:section, :clause, locals)
      html
    end
    
    def to_toc(depth, url, num)
      pub = []
      content.each_with_index do |s, i|
        next unless s.is_a?(V2Web::Section)
        next if s.render_as&.value == 'pre'
        pub << s.to_toc(depth, "#{url}-#{i+1}", "#{num}.#{i+1}")
      end
      locals = {
        :url      => url,
        :title    => "#{num} #{title}",
        :sections => pub.join
      }
      V2Pub.render_with_locals(:section, :toc_entry, locals)
    end
    
    def ensure_valid_content_ordering
      section_seen = false
      content.each do |item|
        section_seen = section_seen || item.is_a?(V2Web::Section) || item.is_a?(V2Web::Reference)
        # puts "Item is a #{item.class} -- section_seen is #{section_seen}"
        next if item.is_a?(V2Web::Section) || item.is_a?(V2Web::Reference)
        next unless section_seen
        puts Rainbow("#{item.class} element encountered after a Section element in #{self.class}[#{self.id}]").orange
        display_for_debug
        puts '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
        return
      end
    end
    
    def non_section_content
      content.reject { |item| item.is_a?(V2Web::Section) || item.is_a?(V2Web::Reference) }
    end

    def completed_text(depth)
      html = []
      non_section_content.each do |item|
        case item
        when V2Web::Text
          txt = item.content.content
          # puts txt;puts
          html << txt unless txt.strip.empty?
        when V2Web::Figure
          html << item.to_hl7_site
        when V2Web::Reference
          raise "Should not be here"
          puts item.render_as&.value
          puts item.ref.class
          raise
          html << nil
        else
          display_for_debug
          raise Rainbow("Can't handle a #{item.class} in clause frontmatter for #{self.class}[#{self.id}].").red
        end
      end
      return '' unless html.any?
      remove_ack_chor_reference(html.join("\n"))
    end

    def display_for_debug
      content.each_with_index do |c, i|
        output = "#{i}) #{c.class}: "
        case c
        when V2Web::Text
          output << Rainbow(c.content_content).yellow
        when V2Web::Reference
          output << Rainbow(c.ref.class.name.demodulize).magenta + " #{c.render_as&.value}"
        else          
          output << Rainbow(c.title).cyan + " #{c.render_as&.value}"
        end
        puts output
      end
      puts '______________________IN_______________________'
      pp self
    end

    def remove_ack_chor_reference(html)
      regex = /<div class=.insert-ack-choreography.\s+id=.([A-Z0-9\^_]+)-ack-choreography.+<\/div>/
      html.gsub(regex, '') # putting ack chor in tabs instead
    end

    def insert_ack_chor(html, depth)
      regex = /<div class=.insert-ack-choreography.\s+id=.([A-Z0-9\^_]+)-ack-choreography.+<\/div>/
      return html.gsub(regex, '') # putting ack chor in tabs instead
      matches = html.scan(regex)
      # puts Rainbow(matches.flatten.inspect).coral
      matches.flatten.each do |m|
        msg_id = m.split('^')[0..-2].join('-').downcase
        begin
          msg = HL7::Message.get(msg_id)
        rescue
          puts title
          raise
        end
        ac    = msg.ack_chor
        entry = ac.to_composition_entry(depth)
        replacer = /<div class=.insert-ack-choreography. id=.#{m.gsub('^', '\^')}-ack-choreography.+<\/div>/
        # puts replacer.inspect
        replaceables = html.scan(replacer)
        raise "#{replaceables.count} substrings match #{replacer.inspect}" unless replaceables.count == 1
        # puts Rainbow(replaceables.inspect).cadetblue
        html.sub!(replacer, entry)
      end
      html
    end
    
    def pub_subcontent(depth, html_id)
      htmls = []
      subcontent.each_with_index do |item, i|
        case item
        when V2Web::Section
          htmls << item.to_pub_clause(depth, "#{html_id}-#{i+1}")
        when V2Web::Reference
          htmls << item.to_pub(depth)
        else
          display_for_debug
          raise Rainbow("Can't handle a #{item.class} in #{self.class}[#{self.id}]").red
        end
      end
      htmls
    end
    
  end # Section
end # V2Web
