module V291
  
  module_function
  
  def current_parent_page(page = nil)
    @cpp = page if page
    raise if @cpp.nil?
    @cpp
  end
    
  def reset_slurp(testing = false)
    @pages = {
      1 => [],
      2 => [],
      3 => [],
      4 => [],
      5 => []
    }
    
    if testing # FIXME for TESTING ONLY
      DB[:v2_web_sections].delete 
      # DB[:v2_web_texts].delete
      DB[:v2_web_tab_sets].delete
      DB[:v2_web_tabs].delete
    end
  end
  
  def do_page_row(v2section, level, row, index)
    page = create_section("Level#{level}", row[level - 1], row[4])
    @pages[level] << page
    add_content(page, v2section, index)
    if level > 1
      add_content_item_to_page(@pages[level - 1].last, page)
    end
    current_parent_page = page
    @tab_set = nil
  end
  
  def slurp(csv_source = V291::Structure.full)
    reset_slurp(:testing)
    
    puts Rainbow('Creating Section Structure').cyan
    

    csv = CSV.read(csv_source)
    headers = csv.shift
    # headers.each_with_index { |h,i| puts "#{i} - #{h}"}
    # 0 - First level - Level1
    # 1 - Domain/Workflow/... - Level2
    # 2 - Second Level - Level3
    # 3 - Third Level - Level4
    # 4 - V2 Section
    # 5 - V2 Section Names
    # 6 - v2+ HTML Page - Level5
    # 7 - v2+ Group Type
    # 8 - v2+ Group Section
    # 9 - Comments

    csv.each_with_index do |row, index|
      # page = nil
      v2section = row[4]&.gsub('a.', 'A.')
      next if v2section == 'Chapter 1' # FIXME
      next if v2section =~ /^X\./ # Sheet had messed up section numbers for ch13.  X.n.. indicates that row should be skipped.
      v2section = nil unless v2section.to_s =~ /^\d+A?\./
      next if row.compact.empty?
      # puts row.inspect
      if row[0] # First level
        do_page_row(v2section, 1, row, index)
      elsif row[1] # Domain/Workflow/...
        do_page_row(v2section, 2, row, index)
      elsif row[2] # Second Level
        do_page_row(v2section, 3, row, index)        
      elsif row[3] # Third Level
        do_page_row(v2section, 4, row, index)
      elsif row[6] # v2+ HTML Page
        # Check if all values of row[5] are the same.  If they are, then we have a single page with a single section.  If not, then we have multiple sections on the page AND the page may have it's own text (example: Message - General Clinical Order).  Also worth checking that all sections map 1:1 with v2section numbers.  TODO account for this...kinda weird that we have a page that ostensibly has a name and also sections that have names.  Do we use both if the page has only one section?
        
        # page = pages5[row[6]]
        type = row[7]&.titleize&.strip # Column H
        puts Rainbow("No title in row: ").yellow + row.inspect unless type

        page_depth = 5
        last_page = @pages[page_depth].last
        if last_page&.title == row[6]
          page = last_page
        else
          page = create_section("#{type} Page", row[6], row[4])
          add_content_item_to_page(@pages[page_depth - 1].last, page)        
          @pages[page_depth] << page
          current_parent_page(page)
        end
               
        content_type = row[8]&.strip || type # Column I or Column H
        puts Rainbow("No content_type for: ").yellow + row.inspect unless content_type
        if ['Message'].include?(type)
          if content_type == 'Text'
            begin
              if v2section
                # puts Rainbow(v2section).orange
                # if v2section =~ /\+/
                  content = get_section_content(v2section)
                # else
                  # content = get_section_content(v2section) # we want to grab the v2AD section
                # end
              else
                content = [create_text_with_asciidoc_richtext("Placeholder Text for #{row.inspect}")]
              end
            rescue
              pp row
              raise
            end
            @tab_set = nil
            content.each { |c| add_content_item_to_page(page, c) }
          elsif content_type =~ /^Tab - /
            unless @tab_set
              ChangeTracker.start
              @tab_set = V2Web::TabSet.new
              @tab_set.title = row[5].strip
              @tab_set.save
              ChangeTracker.commit
              add_content_item_to_page(page, @tab_set)
            end        
            ChangeTracker.start
            tab = V2Web::Tab.new
            tab.title = content_type.slice(/(?<=Tab - ).+/).strip
            tab.save
            @tab_set.add_tab(tab)
            ChangeTracker.commit
          else
            raise "Unknown group type for #{row}"
          end
        elsif type == 'DataType Definition'
          # FIXME
        elsif type == 'Segment Definition'
          # FIXME
        elsif content_type == 'Text'
          begin
            if v2section
              # puts Rainbow(v2section).orange
              # if v2section =~ /\+/
                content = get_section_content(v2section)
              # else
                # content = get_section_content(v2section) # we want to grab the v2AD section
              # end
            else
              content = [create_text_with_asciidoc_richtext("Placeholder Text for #{row.inspect}")]
            end
          rescue
            pp row
            raise
          end
          @tab_set = nil
          content.each { |c| add_content_item_to_page(page, c) }
        else
          raise "Unknown content_type for #{row}"
        end
      else
        if v2section
          # puts Rainbow("Creating subordinate sections in #{current_parent_page.title} for #{v2section}")
          begin
            add_content(current_parent_page, v2section, index)
          rescue
            pp row
            raise
          end
          # Get the v2AD section and display it.
        else
          puts Rainbow("What do I do with: ").orange + row.inspect unless row[0..8].compact.empty?
          # FIXME do something with the other pages??
        end
        
      end
      # Now get the section v291 section number and add that content to current_section as text content
    end
  end

end
