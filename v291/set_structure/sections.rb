module V291
  module_function
  
  def create_section(type, title, section = nil)
    ChangeTracker.start
    # Is it going to be better to create an actual "Page" class?  Maybe....
    s = V2Web::Section.new
    s.render_as = type
    s.title = title
    # puts 'Create ' + Rainbow(s.title).lime + ' ' + section.to_s
    s.original_number = section.gsub('!', '') if section
    s.save
    ChangeTracker.commit
    s
  end
  
  def create_new_inline_section(val, deletions, recurse = false)
    recurse ||= val.include?('+')
    val     = val.delete('+').strip
    return nil if deletions.include?(val)
    v2section_entry = get_v2ad_section(val)
    return if v2section_entry.nil? && val =~ /\.0$/
    v2ads     = v2section_entry[:obj]
    v2ads_for = v2section_entry[:for]
    texts_for = v2ads_for.select { |o| o.is_a?(V2AD::Text) }
    
    # FIXME use create
    # title   = v2ads.adoc.lines.first.sub(/^=+\s+\d+a?(\.\d+)+/, '').strip
    title   = v2ads.title
    section = create_section("Subsection", title, val)
    v2ads.sequel = section
    
    
    # txt = v2ads.adoc
    # if txt
    #   puts "#{val} has #{txt.sequel.content.content}"
    #   # FIXME only add this if there is actually any text other than the title
    #   # add_content_item_to_page(section, txt.sequel) # could possibly just create a new text object here instead of using the already created one?
    # end
    
    if texts_for.size != 1
      puts Rainbow("#{texts_for.size} texts for #{val}").red
    # else
      # puts Rainbow("OK #{val}").green
    end
    
    texts_for.each do |txt|
      v2web_txt = txt.sequel
      cont = v2web_txt.content_content
      # if cont =~ /\[width="100%"/
      #   puts Rainbow(section.original_number).orange
      #   puts v2web_txt.content_content
      #   puts '________________'
      # end
      add_content_item_to_page(section, v2web_txt)
    end
    
    if recurse
      subsection_keys = get_sub_section_keys(val)
      subsection_keys.each do |ssk|
        subsection = create_new_inline_section(ssk, deletions, true)
        add_content_item_to_page(section, subsection) if subsection
      end
    end
    section
  end
  
  def get_existing_v2web_section(val)
    section = get_v2ad_section(val.gsub('!', ''))[:obj]&.sequel
    puts Rainbow("Reusing existing section for #{val}").gold if section
    section
  end
        
  def section_keys
    @section_keys ||= V2AD.v2.sections.keys
  end
  
  def get_sub_section_keys(key, deletions = nil)
    deletions ||= []
    # puts "get_sub_section_keys #{key}"
    ssk = section_keys.select { |k| k =~ /^#{key}\.\d+$/}#.reject { |k| deletions.include?(k) }
    # if ssk.any?
    #   puts "*** subsection keys for #{key}: #{ssk}"
    # end
    ssk
  end
  
  def get_sub_section_keys_recursive(key)
    # puts "get_sub_section_keys #{key}"
    [key] + section_keys.select { |k| k =~ /^#{key}\.\d+$/}.map { |k| get_sub_section_keys_recursive(k) }
  end
  
  def display_sections(sec, indent = 0)
    puts ' '*indent + sec.original_number
    sec.subsections.each { |s| display_sections(s, indent + 2) }
  end
  
  # FIXME need to translate all V2AD::Text into a RichText .... or just use a RichText to begin with
  
  # FIXME are we retaining each section or just spitting back the text? For now, retaining the section...but maybe we shouldn't unless there are nested sections?
  def get_section_content(val, texts_only = true)
    if val =~ /\+/
      v2web_sections = get_v2web_sections(val)
    else
      build_content_tree(val)
    end
    
    # v2web_sections.each do |sec|
    #   next # all this stuff is just debugging output I think
    #   orig_num = sec.original_number
    #   v2ad_sec = V2AD.v2.sections[orig_num]
    #   puts "No V2AD section for #{orig_num}" unless v2ad_sec
    #   objects = v2ad_sec[:for] || [] # FIXME do we need to know if this section is not "for" any objects??  I don't think so but maybe??
    #   display_sections(sec)
    #   puts Rainbow("Sec #{orig_num} - #{!!v2ad_sec}").gold
    #   objects.each do |obj|
    #     puts "#{obj.class} - #{obj.sequel.class}"
    #   end
    #
    # end
    
    
    # pp v2web_sections.map(&:class).map(&:name)
    # v2web_sections
    
    # v2ad_sections.each do |vs|
    #   # objects = vs[:for] || [] # FIXME do we need to know if this section is not "for" any objects??  I don't think so but maybe??
    #   objects = objects.select { |o| o.is_a?(V2AD::Text) } if texts_only
    #   if objects.empty?
    #     # unless vs[:obj]
    #     #   pp vs
    #     #   raise "WTF? V2AD section with no obj?"
    #     # end
    #     pp vs
    #     puts "#{vs[:obj].num}" + Rainbow("No objects").pink
    #   end
    #   if objects.size == 1
    #     # puts "#{vs[:obj].num} " + Rainbow(objects.first.class.name).magenta
    #   end
    #   if objects.size > 1
    #     puts "*#{vs[:obj].num}"
    #     objects.each { |o| puts Rainbow(o.class.name).lime }
    #   end
    # end
    
    # # FIXME what if they are nested?
    # texts = v2ad_sections.map do |vs|
    #   fors = vs[:for].map do |f|
    #     if f.is_a?(V2AD::Text)
    #       t = f.sequel; raise unless t; t
    #     elsif f.is_a?(V2AD::Section)
    #       puts Rainbow(f.num).red
    #     elsif f.is_a?(V2AD::Event)
    #       # puts Rainbow('Event ' + f.code)
    #       # puts Rainbow(f.text.sequel.content).gold if f.text&.sequel&.content
    #     elsif f.is_a?(V2AD::MessageStructure)
    #       # puts Rainbow('MessageStructure ' + f.code)
    #       # puts Rainbow(f.text.sequel.content).gold if f.text&.sequel&.content
    #     elsif f.is_a?(V2AD::Datatype)
    #       # puts Rainbow('Datatype ' + f.code)
    #       # puts Rainbow(f.text.sequel.content).gold if f.text&.sequel&.content
    #     else
    #
    #       raise "What to do with a #{f.class}?"
    #     end
    #   end
    # end
    # texts.flatten(1)
  end
  
  def get_v2ad_section(num)
    # FIXME we may need to implement a link from V2AD::Section to the elements in that section so we can follow to the text??
    num = num.dup[0..-2] if num[-1] == '.'
    v2ad_section = V2AD.v2.sections.dig(num.strip.gsub('!', '')) # returns hash of {obj:V2AD::section, for:<stuff>}
    return v2ad_section if v2ad_section
    return nil if num =~ /\.0$/
    debug_section(num)
    raise "#{num} not found in v2.9.1 import"
  end
  
  def debug_section(num)
    keys = v2.sections.keys.sort.select { |k| num =~ /#{k}/ }
    puts Rainbow("#{num.inspect} is a member of #{keys}? #{!!keys.include?(num)}").orange
    pp v2.sections[num]
    puts '_______'
  end
  
  def split_sections(val)
    parts = val.split(/(?=\(minus)/)
    raise "bad section value: #{val}" if parts.size > 2
    key, minus = parts
    keys = key.split(';').map(&:strip)
    deletions = minus&.slice(/(?<=minus).+(?=\))/)&.split(';')&.map(&:strip)
    deletions = deletions.map { |x| get_sub_section_keys_recursive(x) }.flatten if deletions
    [keys, (deletions || [])]
  end
  
  def get_section_texts(val)
    keys, deletions = split_sections(val)
    puts "get_section_texts has deletions #{val}" if deletions.any?
    puts "get_section_texts has multiple keys #{val}" if keys.size > 1
    content_items = []
    keys.each do |val|
      next if val == '8.16.1' || val =~ /^13\.7\.?$/ # TODO: remove this once the error is resolved in the spreadsheet
      val = val[0..-2] if val[-1] == '.'
      if val =~ /\+/
        raise "get_section_texts should not handle #{val}"
      elsif val =~ /!/ # Exclamation point means that this section is reused in multiple places.  Perhaps this only matters if we're concerned with text?
        # FIXME make sure we don't repeatedly create de novo V2Web::Section objects here.
        # sections << get_v2ad_section(val.delete('!'))
        sections << build_section_tree(val)
      elsif val =~ /^\d+A?(\.\d+)*$/
        # sections << get_v2ad_section(val)
        sections << build_section_tree(val)
      else
        raise "What do I do with #{val.inspect}??"
      end
    end
    content_items
  end
  
  
  # FIXME I think we need to go ahead and create texts for each v2ad_section ahead of time and then insert those...making sure not to recreate text sections if there is a !...if there isn't a ! then we duplicate.
  def get_v2web_sections(val)
    keys, deletions = split_sections(val)
    sections = []
    keys.each do |val|
      next if val == '8.16.1' || val =~ /^13\.7\.?$/ # TODO: remove this once the error is resolved in the spreadsheet
      val = val[0..-2] if val[-1] == '.'
      if val =~ /\+/
        raise if val =~ /!/ # because we need to handle both + and ! if this happens
        sections << build_section_tree(val, deletions) # FIXME and then do what?  Do we need to maintain the structure or just dump in the text? Assuming the former...
      elsif val =~ /!/ # Exclamation point means that this section is reused in multiple places.  Perhaps this only matters if we're concerned with text?
        # FIXME make sure we don't repeatedly create de novo V2Web::Section objects here.
        # sections << get_v2ad_section(val.delete('!'))
        sections << build_section_tree(val)
      elsif val =~ /^\d+A?(\.\d+)*$/
        # sections << get_v2ad_section(val)
        sections << build_section_tree(val)
      else
        raise "What do I do with #{val.inspect}??"
      end
    end
    sections
  end
  
  def reused_sections
    @reused_sections = {}
  end
  
end
