require 'terminal-table'
require_relative 'debug_tables'
# require_relative 'extractor_helpers'
module V2Web
  class DocXtractor

    def setup_for_chapter(source)
      puts Rainbow("#### Parse Chapter #{source} ###").orange
      setup(source)
    end
    
    def extract_chapter(source)
      doc = setup_for_chapter(source)
      @datatype_titles = Marshal.load(File.binread(File.join(__dir__, '../parse/datatype_titles.bin')))
      @segment_titles  = Marshal.load(File.binread(File.join(__dir__, '../parse/segment_titles.bin')))
      # @node_types = []
      @styles = []
      @html_fragments = []
      @p_buffer       = []
      # @last_node = nil
      doc.at('body').children.each { |c| extract_chapter_node(c) }
      fill_narrative # add text to last section
      # @composition.toc
      @composition
    end
    
    def start_composition(node)
      title = extract_text(node).delete("\n").delete("\n.").strip
      title = "Data Type" if title =~ /AControl/
      title = title.sub(/^Chapter:?\s*/, '')
      title.sub!('AOrder', 'Order')
      
      # FIXME add @chapter to Composition
      puts "Chapter: #{title}"
      # return
      # @composition = V2Web::Standard.where(:chapter => @chapter).first
      @composition = FHIR::Composition.where(:title => title).first
      ChangeTracker.start
      if @composition
        @composition.remove_all_sections
      else
        # @composition = V2Web::Standard.create(:chapter => @chapter)
        @composition = FHIR::Composition.create(:title => title)
      end
      ChangeTracker.commit
      
      @section = @composition
      @section_depth = 1
      create_section('Frontmatter for ' + title, 2, 'pre')
      # fill_narrative
      # @section = FHIR::Section.new(:code => 'pre', :title => 'Frontmatter for ' + title)
      # @composition.add_section(@section)
    end
    
    def add_footnote(id)
      @footnote_ids ||= []
      @footnote_ids << id
    end
    
    def add_footnotes
      return unless @footnote_ids&.any?
      @footnote_ids.each do |id|
        @html_fragments << @footnotes[id]
        # footnote_content = @footnotes[id]
        # div = <<~HERE
        # <div class="v2-footnote">#{footnote_content}</div>
        # HERE
        # @html_fragments << div
      end
      @footnote_ids = []
    end
    
    def fill_narrative
      return unless @section.is_a?(FHIR::Section)
      p_buffer_to_html
      add_footnotes
      if @html_fragments.empty? 
        # puts Rainbow("@html_fragments EMPTY").lime
        return
      end
      # this should be both redundant and harmless (they should all already have been hit with ::fragment)
      # html = Nokogiri::HTML::fragment(@html_fragments.join).to_s
      html = @html_fragments.join
      # puts "FILL #{@section.title}" #"--> #{html.inspect}" if html =~ /\n/
      @html_fragments.clear
      unless @section.text
        puts html
        raise 'Unexpected content!'
      end
      raise 'crap' if @section.text.div
      
      narrative = @section.text
      ChangeTracker.start
      narrative.div = Gui_Builder_Profile::Code.new(:content => html)
      narrative.save
      ChangeTracker.commit
    end
    
    def p_buffer_to_html
      if @p_buffer.any?        
        html = Docx2HTML::Processor.new(@p_buffer, @processor_opts).process
        # processor returns what should be a proper html string
        @html_fragments << html
        # puts Rainbow("adding @p_buffer to @html_fragments: #{@html_fragments.last[0..100]}").yellow
        @p_buffer.clear
      end
    end
    
    def add_to_narrative(html_or_node, opts = {})
      if html_or_node.is_a?(Nokogiri::XML::Element)
        if html_or_node.name == 'p' || html_or_node.name == 'Hyperlink'
          opts.delete(:style)
          if opts.any?
            pp opts
            raise 'Expected empty opts'
          end
          @p_buffer << html_or_node
          # puts "added to @p_buffer"
        else
          # puts "TABLE BEGIN: #{@html_fragments.count}"
          p_buffer_to_html # add the paragraphs to the buffer now.
          puts Rainbow("Unexpected #{node.name} in add_to_narrative").red unless html_or_node.name == 'tbl'
          # puts "adding TABLE to @html_fragments"
          @html_fragments << Docx2HTML::Processor.new(html_or_node, opts.merge(@processor_opts)).process
          # puts "TABLE END: #{@html_fragments.count}"
        end
      elsif html_or_node.is_a?(String)
        p_buffer_to_html
        # puts "adding String to @html_fragments"
        # @html_fragments << Nokogiri::HTML::fragment(html_or_node).to_xhtml(indent: 2)
        @html_fragments << html_or_node
      else
        raise "Got a #{html_or_node.class}"
      end
    end
            
    def extract_tbl(node)
      
      if is_msg_table?(node)
        # do nothing, reference added when we hit the caption
      elsif is_ack_table?(node)
        add_ac_reference(node)
      elsif is_segment_table?(node)
        # do nothing, reference added when we hit the caption
      elsif is_component_table?(node)
        # do nothing, reference added when we hit the caption
      else
        # puts "sending a #{node.name} to add_to_narrative"
        add_to_narrative(node, :caption => @caption)
      end 
      return # FIXME
      # TODO preserve styles in rows/cells/etc.
      parent_styles = node.previous.xpath('.//pPr/pStyle').map { |s| s['val'] }
      # AttributeTableCaption precedes segment tables
      return if (parent_styles & ['MsgTableCaption', 'AttributeTableCaption']).any?
      return if node.xpath(".//pStyle[@val='ACK-ChoreographyHeader']").any?
      add_table(node)
      return
      # puts Rainbow(tbl.previous.name).magenta
      # puts Rainbow(extract_text(tbl.previous)).magenta
      # puts Rainbow(parent_styles).magenta
      rows = node.children.select { |n| n.name == 'tr'}.map { |row| extract_tr(row) }
      display_tbl(rows)
      # puts Rainbow(tbl.xpath(".//pStyle[@val='ACK-ChoreographyHeader']").inspect).green
      # puts tbl.to_s if rows.first.first =~ /Acknowledge?ment Choreography/
      # rows
    end

    def create_section(title, depth, code, opts = {})
      fill_narrative
      new_section = _create_section(title, depth, code, opts = {})
      ChangeTracker.start
      new_section.text = FHIR::Narrative.new
      ChangeTracker.commit
      insert_section(new_section, depth)
      @section = new_section
      @current_text = nil
      puts Rainbow('  '*depth + "#{title}").cadetblue
      new_section
    end
    
    def create_datatype_section(title, depth)
      name = title.gsub(/^[A-Z][A-Z][A-Z0-9]?\s*[–|-]\s*/, '').strip
      temp = HL7::DataType.new(:name => name).url_name
      # puts Rainbow(name).cyan
      # puts Rainbow(temp).cyan
      create_reference_section(title, depth, 'datatype-definition', temp)
    end

    def create_segment_section(title, depth)
      name = title.gsub(/^[A-Z][A-Z][A-Z0-9]?\s*[–|-]\s*/, '').strip
      create_reference_section(title, depth, 'segment-defintion', HL7::SegmentDefinition.new(:name => name).url_name)
    end

    def create_reference_section(title, depth, code, url)
      fill_narrative
      # puts Rainbow(url).lime
      section = _create_section(title, depth, code, opts = {})
      insert_section(section, depth)
      ChangeTracker.start
      section.entry = url
      section.save
      ChangeTracker.commit
      @section = section
      @current_text = nil
      puts Rainbow('  '*depth + "#{title}").coral
      section
    end
    
    def _create_section(title, depth, code, opts = {})
      title = title.gsub(/^\./, '').gsub("\n", ' ').strip
      if depth == 1
        raise
        ChangeTracker.start
        @section.title = title
        @section.save
        ChangeTracker.commit
        return @section
      end # raise
      ChangeTracker.start
      new_section = FHIR::Section.create(:title => title, :code => code)
      ChangeTracker.commit
      new_section
    end
    
    def insert_section(section, depth)
      raise if depth < 2
      ChangeTracker.start
      if depth == @section_depth
        @section.parent.add_section(section)
      elsif depth == @section_depth + 1
        @section.add_section(section)
        @section_depth += 1
      elsif depth < @section_depth
        (@section_depth - depth).times { @section = @section.parent; @section_depth -= 1 }
        @section.parent.add_section(section)
      else
        # puts title
        # puts depth
        # puts @section_depth
        raise
      end
      ChangeTracker.commit
    end
    
    def add_message_reference(node)
      ttl = extract_text(node)
      titles = expand_msg_tbl_title(ttl)
      titles.each do |title|
        identifier = title.slice(/.+(?=:)/).strip
        name = title.slice(/(?<=:).+/).strip
        objs = HL7::Message.where(Sequel.ilike(:name, "#{identifier}%")).all
      
        objs.select! { |obj| obj.name =~ /#{name}/} if objs.count > 1
        raise "Too many MessageDefinition that match '#{name}' -- #{objs.map(&:name)}" if objs.count > 1
      
        if objs.first
          add_reference(objs.first, title)
        else
          if objs.empty?
            objs = HL7::Message.where(Sequel.ilike(:name, "%#{identifier.split('^').last}%")).all
            if objs.empty?
              puts Rainbow("No MessageDefinition for #{title}").yellow
            else
              objs.each do |obj|
                add_reference(obj, title)
                # puts Rainbow("Added reference to #{obj.name} for #{title}").green
              end
            end
          end
        end
      end
    end
    
    def add_segment_reference(node)
      title = extract_text(node)
      abbr  = title.slice(/(?<=HL7 Attribute Table [–|-]) *[A-Z0-9]{3} *(?=[–|-].+)/).strip
      objs = HL7::SegmentDefinition.where(Sequel.ilike(:code, "#{abbr}%")).all
      if objs.count > 1 && abbr == 'RXA'
        if title =~ /vaccine/i
          objs.select! { |obj| obj.name =~ /vaccine/i }
        else
          objs.reject! { |obj| obj.name =~ /vaccine/i }
        end
      end
      raise Rainbow("'#{title}' with code '#{abbr}' matches ").yellow + "#{objs.map(&:name).inspect}" if objs.count > 1
      if objs.first
        add_reference(objs.first, title)
      else
        puts Rainbow("No MessageDefinition for #{title}").yellow
      end
    end
    
    def add_datatype_reference(node)
      title = extract_text(node)
      puts title; raise
      abbr  = title.slice(/(?<=HL7 Attribute Table [–|-]) *[A-Z0-9]{3} *(?=[–|-].+)/).strip
      objs = HL7::DataType.where(Sequel.ilike(:code, "#{abbr}%")).all
      raise Rainbow("'#{title}' with code '#{abbr}' matches ").yellow + "#{objs.map(&:name).inspect}" if objs.count > 1
      if objs.first
        add_reference(objs.first, title)
      else
        puts Rainbow("No DataType for #{title}").yellow
      end
    end
    
    # If there are multiple ack chor tables that result here then they aren't going to get placed right under each table.  That doesn't really matter now because we are inserting ack chor tables based on the msg table reference.  We're just erasing this div right now.
    def add_ac_reference(node)
      return  # Not doing this right now because we are adding Ack Chor based on msg reference (right now they are in the tab adjacent to the msg structure)
      ttl = ack_table_msg(node)
      titles = expand_msg_tbl_title(ttl)
      titles.each do |title|
        # puts title
        message_defs = HL7::Message.where(Sequel.ilike(:name, "#{title}%"), :code => title.split('^').first).all
        raise "Too many message defs for AckChor titled #{title}" if message_defs.count > 1
        raise "No message defs for AckChor titled #{title}" if message_defs.count < 1
        md = message_defs.first
        ac = md.acknowledgment_choreography # just checking to make sure this was actually there....
        raise Rainbow("No AcknowledgmentChoreography for #{title}").yellow unless ac
        add_reference(ac, title)
      end
    end
    
    # The choice here is to either add html to the narrative, with a cue to create a table from the resource OR to add another section that is just a reference.  We're going to add html cues for now....    
    def add_reference(obj, title = nil)
      case obj
      when HL7::AcknowledgmentChoreography
        html = "<div class='insert-ack-choreography' id='#{title}-ack-choreography' style='display: none;'>#{title} Acknowledgment Choreography</div>"
        add_to_narrative(html)
      when HL7::DataType
        add_reference_section(obj, title)
      when HL7::SegmentDefinition
        add_reference_section(obj, title)
      when HL7::MessageStructure, HL7::Message
        # puts Rainbow("          REF: #{title}").yellow
        html = "<div class='insert-msg-table' id='#{title}-message-table' style='display: none;'>#{title} Table</div>"
        add_to_narrative(html)
      else
        raise obj.class
      end
    end


    # def is_list_item?(node)
    #   styles = node.xpath('.//pPr/pStyle').map { |x| x.to_s.slice(/(?<=<pStyle val=").+(?="\/>)/)}
    #   styles.any? { |s| s =~ /List/i }
    # end
    
    def extract_chapter_node(node)
      case node.name
      when 'tbl'
        extract_tbl(node) unless @skip
        @caption = nil
      when 'bookmarkStart', 'bookmarkEnd'
        # ignore
      when 'sectPr'
        # not sure what this is for...section properties
      when 'p'
        styles = node_styles(node)
        # styles.each { |s| @styles << s }
        puts Rainbow('Multiple Styles! ' + styles.inspect).red if styles.count > 1
        if styles.any?
          style = styles.first
          if style =~ /Heading/
            case style
            when 'Heading1'
              start_composition(node)
            else
              txt = extract_text(node).strip
              return if txt.empty? || txt =~ /hiddentext/i
              depth = style[-1].to_i
              raise unless (2..6).include?(depth)
              if depth.to_i <= @section_depth
                # puts Rainbow('UNSKIP!').red + " depth: #{depth}; section_depth: #{@section_depth}"
                @skip = false
              end 
              if depth == 2 && txt =~ /Contents/i
                @skip = true
                puts Rainbow("    Skipping #{txt}").crimson
              end
               
              if @datatype_titles&.include?(txt)
                @skip = true
                create_datatype_section(txt, depth)
              elsif @segment_titles&.include?(txt)
                # puts Rainbow("SKIP #{txt}").green
                @skip = true
                create_segment_section(txt, depth)
              else
                return if @skip           
                # puts "#{style} - #{txt}"
                create_section(txt, depth, 'clause')
              end
            end
          else
            return if @skip
            case style          
            when 'TOC1', 'TOC2', 'TOC3', 'TOC4', 'TOC5', 'TableofFigures'
              # skip it
            when 'ACK-ChoreographyHeader'
              # should not ever get here...
              puts style + ' ' + Rainbow(extract_text(node)).green
            when 'ACK-ChoreographyBody'
              # already done in parse_ac.rb
            when 'MsgTableCaption'
              add_message_reference(node)
            when 'QryTableCaption'
              # FIXME
              @caption = extract_text(node)
            when 'AttributeTableCaption'
              add_segment_reference(node)
            when 'AttributeTableCaption'
              add_datatype_reference(node)
            when 'NormalIndented', 'Components', 'Example', 'Note', 'NoteIndented'
              add_to_narrative(node, :style => style)
            when 'NoteChar'
              etext = extract_text(node)
              if etext.strip&.[](0)
                # Only in Ch. 6
                # puts style + ' ' + Rainbow(etext).red
                add_to_narrative(node, :style => style) 
              end
              # FIXME found in Ch6
            when 'CommentText'
              etext = extract_text(node)
              if etext.strip&.[](0)
                puts style + ' ' + Rainbow(etext).red
                add_to_narrative(node, :style => style) 
              end
              # FIXME found in Ch13
            when 'ANSIdesignation'
              add_to_narrative(node, :style => style)
              # puts Rainbow("ANSIdesignation: #{extract_text(node)}").red
            # when 'List'
              # this appears to be a list item
              # puts Rainbow("#{style}: #{extract_text(node)}").yellow;puts

            when 'NormalList', 'NormalListAlpha', 'NormalListNumbered',  'NormalListBullets', 'ListParagraph'
              add_to_narrative(node, :style => style)
            when 'ListBullet3'
              # FIXME Ch. 17
            when 'OtherTableCaption'
              @caption = extract_text(node)
            when 'EndnoteText'
              puts Rainbow("#{style} -- #{extract_text(node)}").magenta
              add_to_narrative(node, :style => style)
            when 'Default', 'Title1'
              add_to_narrative(node, :style => "#{style}-#{@chapter}")
            # when 'ComponentTableCaption'
              # These can be skipped
            # when 'HL7TableCaption'
              # add_datatype_or_component_content(node, :table_caption)
              # FIXME this table content in a component definition
              # This should probably have just been 'Normal' in most cases
              # puts Rainbow('HL7TableCaption: ' + extract_text(node)).yellow
            # when 'Note'
              # add_datatype_or_component_content(node, :note)
              # This should probably have just been 'Normal' in most cases
              # puts Rainbow('Note: ' + extract_text(node)).yellow
            # when 'Tableheading'
            #   raise
            #   # This should probably have just been 'Normal' in most cases
            #   puts Rainbow('Tableheading: ' + extract_text(node)).red;puts
            else
              
              # There aren't anymore right now but may be some in other docx
              puts 'Unknown style for paragraph: ' + Rainbow(style).red unless extract_plain_text(node).strip.empty?
              add_to_narrative(node, :style => style)
            end
            # @figure should only be preserved for the very next paragraph after the figure, then forget about it.
          end
        else
          return if @skip
          # text = extract_text(node).strip
          # unless text.empty?
          #   puts Rainbow(node.to_s).orange
          #   puts '*'*22
          # end
          add_to_narrative(node)
          # add_to_narrative(node, 'Default')
        end
        @last_figure = nil
        @list = nil unless styles.any? { |s| s =~ /List/i }
      else
        return if @skip
        unless node.name == 'bookmarkStart' # not worrying about bookmarks in Word document
          puts Rainbow(node.name).orange
          puts node.to_xml[0..1000]
        end
      end
      @last = node
    end
    
    # This might fail for nested lists.  Check Ch 4 TQ2 usage
    def _list(node, type)
      start_list(type) unless @list
      add_list_item(node)
    end
        
  end
end
