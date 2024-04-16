module V291
  
  module_function

  def add_content_item_to_page(parent_page, content)
    ChangeTracker.start
    parent_page.add_content(content) # content may be a (linked) page, section, text, tab_set, etc..
    ChangeTracker.commit
  end
  
  # Yeah, we should probably refactor some of these methods and/or name them better
  def add_content(parent_page, item, index = nil)
    if item =~ /^\d+A?\./i
      sc = get_section_content(item)
      # pp sc if parent_page.title == 'Trash Bin'
      ChangeTracker.start
      sc.each do |c|
        if c.is_a?(V2Web::Section)
          # puts Rainbow("#{parent_page.breadcrumbs} | Index: #{index}").lime
          # puts "Adding #{c.title} - #{c.original_number} TO #{parent_page.title} "  + Rainbow(item).gold
        elsif c.is_a?(V2Web::Reference)
          # Do nothing
        elsif c.is_a?(V2Web::Text)
          # Do nothing
        else
          raise "got a #{c.class} for adding"
          # puts Rainbow("#{parent_page.breadcrumbs} | Index: #{index}").lime
          # puts "Adding a #{c.class} TO #{parent_page.title}"  + Rainbow(item).coral
        end
        parent_page.add_content(c)
      end
      ChangeTracker.commit
    else
      # puts Rainbow("#{parent_page.breadcrumbs} | Index: #{index}").magenta
      # puts "Adding a #{item.class} TO #{parent_page&.title} "  + Rainbow(item).gold
      t = create_text_with_asciidoc_richtext("Placeholder Text: #{parent_page.breadcrumbs} | Index: #{index}")
      ChangeTracker.start
      parent_page.add_content(t)# Create a placeholder text block
      ChangeTracker.commit
    end
  end
  
  def build_content_tree(val, deletions = [])
    if deletions.empty?
      vals, deletions = split_sections(val)
    else
      vals = [val]
    end
    # FIXME this should be adapted to handle trees such it returns a text at the top level section and subsections for subsections.  i.e., no section for the top level section

    reuse = true if val =~ /!/
    existing_section = reused_sections[val.delete('!')]
    return existing_section if existing_section
    
    if val =~ /\(|\+/
      puts Rainbow(val).orange
    end
    
    content = []
    vals.each do |v|
      content = content + _build_content_tree(v)
    end
    ret = content.compact
    reused_sections[val.delete('!')] = ret if reuse
    ret
  end
  
  def _build_content_tree(val)
    v2section_entry = get_v2ad_section(val)
    raise "No V2AD::Section for #{val}" unless v2section_entry
    v2ads     = v2section_entry[:obj]
    v2ads_for = v2section_entry[:for]
    if v2ads_for.any? { |f| f.class.name =~ /Section/ }
      pp v2ads_for
      raise "CRAP"
    end 
    content = v2ads_for.map(&:sequel).compact # Should just get texts # FIXME we may want to add placeholders for other stuff
    substitute_references(content)
  end
  
  def build_section_tree(val, deletions = [])
    if deletions.empty?
      vals, deletions = split_sections(val)
    else
      vals = [val]
    end
    # puts "build_section_tree #{val}"
    raise "Unexpected multiple vals in build_section_tree: #{vals}" if vals.size > 1
    vals1 = vals.first
    section = get_existing_v2web_section(vals1) if vals1 =~ /!/ # Exclamation point means that this section is reused in multiple places.  Perhaps this only matters if we're concerned with text?
    # FIXME is there a case where we don't want in "inline" section? i.e., with render_as = "Inherit"?
    section ||= create_new_inline_section(vals1, deletions)
    section
  end
  
end
