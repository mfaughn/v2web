module V2Plus
  class Section
    def self.make(node, parent)
      this = new
      this.parent = parent
      this.title  = node.get_val('title')
      puts node unless this.title
      raise unless this.title
      this.code   = node.get_val('code > text')
      this.entry  = node.get_val('entry > reference') # FIXME, this is not specific
      # this.focus = nodeset.get_val('focus')
      texts = []
      sections = []
      node.children.each do |child|
        sections << child if child.name == 'section'
        next unless child.name == 'text'
        next unless child.children.any?
        texts << child
      end
      this.sections = sections.map { |s| V2Plus::Section.make(s, this) }
      raise if texts.count > 1
      unless texts.any?
        # puts "#{this.title} has no text"
        return this
      end
      # puts Rainbow(this.title).cyan
      div = texts.first.at_css('status + div')
      this.text = div.children.to_s # shortcutting the creation of a narrative...for now
      this
    end
        
    def to_composition_content(depth, html_id)
      case code
      when 'pre'
        text
      when 'clause'
        to_composition_clause(depth, html_id)
      when 'segment-defintion'
        obj_id  = entry.split('/').last
        begin
          seg_def = SegmentDefinition.get(obj_id)
          seg_def.to_composition_clause(depth)
        rescue Scrivener::FetchError => e
          # Doesn't get much dirtier than this ....
          return '' if e.message =~ /segment-usage-in-vaccine-messages/
          raise
        end
      when 'datatype-definition'
        obj_id = entry.split('/').last
        dt     = DataType.get(obj_id)
        dt.to_composition_clause(depth)
      else
        puts "Section for #{code} -- #{entry}"
      end
    end
    
    def to_composition_clause(depth, html_id)
      locals = {
        :html_id => html_id,
        :depth   => depth,
        :title   => title,
        :content => completed_text(depth + 1),
        :sections => composition_subcontent(depth + 1, html_id)
      }
      html = V2Plus.render_with_locals(:section, :clause, locals)
      html
    end
    
    def completed_text(depth)
      txt = text
      return '' unless txt
      # html = insert_ack_chor(insert_msg_tabs(txt), depth)
      html = insert_msg_tabs(remove_ack_chor_reference(txt))
    end
    
    def insert_msg_tabs(html)
      # So, the text pulled from here isn't quite correct in the cases where the message structure was replaced because the one in v2.9 was actually a duplicate.  So, we are getting the message, and then asking the message for its structure and using that.
      msg_regex = /<div class=.insert-msg-table. id=.([A-Z0-9\^_]+): .+-message-table.+<\/div>/
      matches = html.scan(msg_regex)
      # puts Rainbow(matches.flatten.inspect).coral
      matches.flatten.each do |m|
        # puts "Replacing #{m}"
        msg_id = m.split('^')[0..-2].join('-').downcase
        begin
          msg = V2Plus::Message.get(msg_id)
        rescue
          puts title
          raise
        end
        # msg_struct = msg.structure
        # table = msg_struct.to_tabs
        tabs = msg.to_tabs
        replacer = /<div class=.insert-msg-table. id=.#{m.gsub('^', '\^')}: .+-message-table.+<\/div>/
        # puts replacer.inspect
        replaceables = html.scan(replacer)
        raise "#{replaceables.count} substrings match #{replacer.inspect}" unless replaceables.count == 1
        # puts Rainbow(replaceables.inspect).cadetblue
        html.sub!(replacer, tabs)
      end
      html      
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
          msg = V2Plus::Message.get(msg_id)
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
    
    def composition_subcontent(depth, html_id)
      content = []
      sections.each_with_index do |s, i|
        content << s.to_composition_content(depth, "#{html_id}-#{i+1}")
      end
      content
    end
    
  end # Section
end # V2Plus
