module WriteAdoc
  module_function
  
  def write_section(section, parent_dir, level)
    # if section.title =~ /\//
    #   if section.title == 'General Use Cases / Background'
    #     ChangeTracker.start
    #     section.title = 'General Use Cases &sol Background'
    #   else
    #     puts Rainbow(section.title)
    #   end
    # end
    puts Rainbow('  '*level + section.title).green
    section_dir = File.join(parent_dir, dirnamify(section.title.strip))
    link_dir    = File.join(parent_dir, dirnamify(section.title.strip)).sub(git_dir, '')
    link_dir = link_dir[1..] if link_dir[0] == '/'
    local_link_dir = dirnamify(section.title.strip)
    begin
      FileUtils.mkdir_p(parent_dir) unless File.exist?(parent_dir)
    rescue
      puts "Parent dir: #{parent_dir}"
      puts "Dir: #{dirnamify(section.title.strip)}"
      puts "SECTION"
      pp section
      raise
    end
    
    refs = section.content.select { |c| c.is_a?(V2Web::Reference) }.map(&:ref).map(&:class).uniq
    puts Rainbow("#{refs}").magenta
    
    basename = filenamify(section.title)
    filename = File.join(parent_dir, basename)
    File.open(filename, 'w+') do |file|
      
      # TODO may eventually want to extract all attributes to a separate method
      file.puts '= ' + section.title
      # file.puts ':docinfo: shared'
      # file.puts ':docinfodir: ' + '.' + '/..'*(level - 1)
      file.puts ':render_as: '    + section.render_as.value || 'unspecified'
      file.puts ':v291_section: ' + section.original_number.to_s if section.original_number
      file.puts ':refs: ' + refs.to_s if refs.any?
      # file.puts ':linkcss: '
      # file.puts ':copycss!: '
      file.puts
      
      section.content.each do |c|
        # puts '  '*(level+1) + c.class.name
        if c.is_a?(V2Web::Section)
          ras = c.render_as&.value
          if ras =~ /Subsection/
            write_inline_subsection(file, c, 1)
          elsif ras =~ /Level|Message Page/
            link = File.join(local_link_dir, filenamify(c.title))
            xref = "xref:#{link}[#{c.title}]"
            puts Rainbow('  '*(level+1) + xref).gold
            file.puts xref 
            write_section(c, section_dir, level + 1)
            file.puts
          else
            pp c
            pp c.render_as
            raise "Don't know how to render #{ras}"
          end
            
        elsif c.is_a?(V2Web::Text)
          if c.content_content
            file.puts c.content_content
            file.puts
          end
        elsif c.is_a?(V2Web::TabSet)
          write_tabset(file, c, level + 1)
        else
          puts Rainbow(c.class.name).orange
        end
      end
    end
    # puts Rainbow(filename).gold
    render(filename)
  end
  
  def write_inline_subsection(file, section, level)
    puts Rainbow('  '*level + section.title).yellow
    file.puts '='*level + '= ' + section.title
    file.puts
    section.content.each do |c|
      # puts '  '*(level+1) + c.class.name
      if c.is_a?(V2Web::Section)
        ras = c.render_as&.value
        if ras =~ /Subsection/
          write_inline_subsection(file, c, level + 1)
        elsif ras =~ /Level|Domain\/Workflow/
          raise "Unexpected linked section from #{section.title} to #{c.title}"
        else
          raise "Don't know how to render #{ras}"
        end
      elsif c.is_a?(V2Web::Text)
        if c.content_content
          file.puts c.content_content
          file.puts
        end
      elsif c.is_a?(V2Web::TabSet)
        write_tabset(file, c, level + 1)
      else
        puts Rainbow(c.class.name).orange
      end
    end
  end
  
  def write_tabset(file, tabset, level)
    # FIXME Tabsets are not getting into the content
    # FIXME how do we do a tabset in AsciiDoc?
    puts '  '*level + "Tabset - #{tabset.tabs.map(&:title)}"
    file.puts "[message-tabs, #{tabset.tabs.map(&:title)}]"
    file.puts
  end
  
  def filenamify(str)
    (str.gsub(/\s/, '_').sub(/_$/, '').strip + '.adoc').gsub('/', '').gsub(/__+/, '_').gsub(/\.+/, '.').sub(/_$/, '').strip
  end
  
  def dirnamify(str)
    str.gsub(/\//, ' and ').gsub(/\s/, '_')
  end

end
