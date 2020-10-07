require 'terminal-table'
require_relative 'debug_tables'
# require_relative 'extractor_helpers'
module V2Web
  class DocXtractor
    def clear_hl7
      HL7.classes(:no_imports => true).each do |c|
        next unless c < Sequel::Model
        next if c.enumeration?
        if DB.tables.include?(c.table_name)
          c.delete
        end
      end
      nil
    end
    
    def extract_chapter(doc, html)
      @html = File.open(html) { |f| Nokogiri::XML(f) }
      root_section = V2Web::Standard.where(:chapter => @chapter).first
      ChangeTracker.start
      if root_section
        root_section.remove_all_content
      else
        root_section = V2Web::Standard.create(:chapter => @chapter)
      end
      ChangeTracker.commit
      @section = root_section
      @section_depth = 1
      # @html_dt = {}
      # @current_html_dt = nil
      # find_datatypes
      @node_types = []
      @styles = []
      doc.remove_namespaces!
      # @datatype = nil
      # @datatypes = {}
      # @component = nil
      doc.children.each { |c| _extract_chapter(c) }
      # puts @node_types.uniq.sort
      # puts
      # puts @styles.uniq.sort
      # root_section.toc 
    end
    
    def extract_tbl(tbl)
      # TODO preserve styles in rows/cells/etc.
      parent_styles = tbl.previous.xpath('.//pPr/pStyle').map { |s| s['val'] }
      # AttributeTableCaption precedes segment tables
      return if (parent_styles & ['MsgTableCaption', 'AttributeTableCaption']).any?
      return if tbl.xpath(".//pStyle[@val='ACK-ChoreographyHeader']").any?
      add_table(tbl)
      return
      # puts Rainbow(tbl.previous.name).magenta
      # puts Rainbow(extract_text(tbl.previous)).magenta
      # puts Rainbow(parent_styles).magenta
      rows = tbl.children.select { |n| n.name == 'tr'}.map { |row| extract_tr(row) }
      display_tbl(rows)
      # puts Rainbow(tbl.xpath(".//pStyle[@val='ACK-ChoreographyHeader']").inspect).green
      # puts tbl.to_s if rows.first.first =~ /Acknowledge?ment Choreography/
      # rows
    end

    def create_section(title, depth)
      title = title.gsub(/^\./, '').gsub("\n", ' ').strip
      depth = depth.to_i
      if depth == 1
        ChangeTracker.start
        @section.title = title
        @section.save
        ChangeTracker.commit
        return @section
      end
      ChangeTracker.start
      new_section = V2Web::Section.create(:title => title)
      if depth == @section_depth
        @section.parents.first.add_content(new_section)
      elsif depth == @section_depth + 1
        @section.add_content(new_section)
        @section_depth += 1
      elsif depth < @section_depth
        (@section_depth - depth).times { @section = @section.parents.first; @section_depth -= 1 }
        @section.parents.first.add_content(new_section)
      else
        # puts title
        # puts depth
        # puts @section_depth
        raise
      end
      ChangeTracker.commit
      @section = new_section
      @current_text = nil
      new_section
    end
    
    def add_message_reference(node)
      title = extract_text(node)
      identifier = title.slice(/.+(?=:)/).strip
      name = title.slice(/(?<=:).+/).strip
      objs = HL7::Message.where(Sequel.ilike(:name, "#{identifier}%")).all
      
      objs.select! { |obj| obj.name =~ /#{name}/} if objs.count > 1
      raise "Too many MessageDefinition that match '#{name}' -- #{objs.map(&:name)}" if objs.count > 1
      
      if objs.first
        add_reference(objs.first)
      else
        if objs.empty?
          objs = HL7::Message.where(Sequel.ilike(:name, "%#{identifier.split('^').last}%")).all
          if objs.empty?
            puts Rainbow("No MessageDefinition for #{title}").yellow
          else
            objs.each do |obj|
              add_reference(obj)
              puts Rainbow("Added reference to #{obj.name} for #{title}").green
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
        add_reference(objs.first)
      else
        puts Rainbow("No MessageDefinition for #{title}").yellow
      end
    end
    
    def add_reference(obj)
      ChangeTracker.start
      reference = V2Web::Reference.create
      reference.ref = obj
      @section.add_content(reference)
      ChangeTracker.commit
    end
    
    # def is_list_item?(node)
    #   styles = node.xpath('.//pPr/pStyle').map { |x| x.to_s.slice(/(?<=<pStyle val=").+(?="\/>)/)}
    #   styles.any? { |s| s =~ /List/i }
    # end
    
    def _extract_chapter(node)
      # @node_types << node.name
      case node.name
      when 'body'
        node.children.each { |c| _extract_chapter(c) }
      when 'document'
        node.children.each { |c| _extract_chapter(c) }
      when 'tbl'
        extract_tbl(node)
        @caption = nil
      when 'bookmarkStart', 'bookmarkEnd'
        # TODO
      when 'sectPr'
        # TODO not sure what this is for
      when 'p'
        # last_node_was_list = is_list_item?(node.previous)
        # puts Rainbow(node.path).green
        styles = node.xpath('.//pPr/pStyle').map { |s| s['val'] }
        styles.each { |s| @styles << s }
        puts Rainbow('Multiple Styles!').red if styles.count > 1
        if styles.any?
          # val_attr = styles.first.attributes.find { |a| a.first == 'val' }
          # style = val_attr.last.value
          style = styles.first
          if style =~ /Heading/
            depth = style[-1]
            create_section(extract_text(node), depth)
          else
            case style          
            when 'TOC1', 'TOC2', 'TOC3', 'TOC4', 'TOC5', 'TableofFigures'
              # skip it
            when 'ACK-ChoreographyHeader'
              puts Rainbow(extract_text(node)).green
            when 'ACK-ChoreographyBody'
              # already done in parse_ac.rb
            when 'MsgTableCaption'
              add_message_reference(node)
            when 'QryTableCaption'
              # FIXME
              @caption = extract_text(node)
            when 'AttributeTableCaption'
              add_segment_reference(node)
            when 'NormalIndented', 'Components', 'Example', 'Note', 'NoteIndented'
              add_styled_text(node, style)
            when 'NoteChar'
              # FIXME found in Ch6
            when 'CommentText'
              # FIXME found in Ch13
            when 'ANSIdesignation'
              ChangeTracker.start
              @section.ansi_designation = extract_text(node)
              
              # puts Rainbow("ANSIdesignation: #{extract_text(node)}").red
            # when 'List'
              # this appears to be a list item
              # puts Rainbow("#{style}: #{extract_text(node)}").yellow;puts

            when 'NormalList', 'NormalListAlpha', 'NormalListNumbered',  'NormalListBullets'
              _list(node, style)
            when 'ListBullet3'
              # FIXME Ch. 17
            when 'OtherTableCaption'
              @caption = extract_text(node)
            when 'EndnoteText'
              puts Rainbow("#{style} -- #{extract_text(node)}").magenta
              add_styled_text(node, style)
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
              puts 'Unknown style for paragraph: ' + Rainbow(style).red
              add_styled_text(node, style)
            end
            # @figure should only be preserved for the very next paragraph after the figure, then forget about it.
          end
        else
          # text = extract_text(node).strip
          # unless text.empty?
          #   puts Rainbow(node.to_s).orange
          #   puts '*'*22
          # end
          add_styled_text(node, 'Default')
        end
        @last_figure = nil
        @list = nil unless styles.any? { |s| s =~ /List/i }
      else
        unless node.name == 'bookmarkStart' # not worrying about bookmarks in Word document
          puts Rainbow(node.name).orange
          puts node.to_xml[0..1000]
        end
      end
    end
    
    # This might fail for nested lists.  Check Ch 4 TQ2 usage
    def _list(node, type)
      start_list(type) unless @list
      add_list_item(node)
    end
        
  end
end
