# Caption
# Figure
# Header
# Heading1
# Heading2
# Heading3
# Heading4
# ListParagraph
# NormalIndented
# TOC1
# TOC2
# TOC3
# TOC4
# Table
# TableContent
# TableHeadingB
# TableofFigures
# Title
# FIXME you are ignoring <w:tab/>
require 'shellwords'
require 'cgi'
require_relative 'current_parent_hack'

module V2Web  
  class DocXtractor
    attr_reader :chapter
    def initialize(chapter = nil)
      @chapter = chapter.to_s.gsub(/^0+/, '')
      HL7Parse.set_list_styles(@chapter) if chapter
    end
    
    def setup(source, chapter = nil)
      chapter  ||= source.slice(/(?<=CH)\d\dA?/)
      chapter  = chapter[1..-1] if chapter.to_s[0] == '0' # get rid of leading zero
      @chapter = chapter
      HL7Parse.set_list_styles(@chapter)
      docx_path = HL7Parse.docx_path(source)
      zip_path  = HL7Parse.zip_path(source)
      unzipped  = HL7Parse.unzip_path(source)

      FileUtils.cp_r(docx_path, zip_path, :remove_destination => true) unless File.exist?(zip_path)
      system "unzip -o #{zip_path} -d #{unzipped}" unless File.exist?("#{unzipped}/word/document.xml")

      docx = Docx::Document.open(docx_path)
      docx.setup(unzipped, chapter)
      # @links     = docx.links
      # @embeds    = docx.objects
      # @images    = docx.images
      @footnotes = docx.footnotes
      @processor_opts = {
        :client    => self,
        :links     => docx.links,
        :embeds    => docx.objects,
        :images    => docx.images,
        :chapter   => @chapter,
        # :footnotes => docx.footnotes,
        :raw       => true,
        :image_substitutions => HL7Parse.image_substitutions[@chapter]
      }
      doc = docx.doc
      doc.remove_namespaces!
      doc
    end
    
    def extract_document(doc, title = 'Test')
      @debug = false
      doc.remove_namespaces!
      ChangeTracker.start
      @site = V2Web::Standard.create(:title => title, :version => Time.now.strftime('%Y.%m.%d.%R'))
      @composition = FHIR::Composition.create
      @composition.v2  = @site
      @current_section = @site
      @current_fhir    = @composition
      ChangeTracker.commit
      @current_depth = 0
      doc.children.each { |c| extract(c) }
      compact_content(@site)
    end
    
    def make_gbp_file(path)
      V2Web.make_gbp_file(path)
    end
    
    # def extract_footnotes(word_dir)
    #   footnotes_xml = File.open(File.join(word_dir, 'footnotes.xml')) { |f| Nokogiri::XML(f) }
    #   ret = {}
    #   footnotes_xml.children.each do |fn|
    #     id = fn.attr('Id')
    #     next if id.to_i < 1
    #     ret[id] = extract_text(fn)
    #   end
    #   ret
    # end

    
    def extract_rels(path)
      @images    = {}
      @styles    = {}
      # @endnotes  = {}
      @links     = {}
      word_dir = File.join(path, 'word')
      # footnotes = extract_footnotes(word_dir)
      rels_xml = File.open(File.join(word_dir, '_rels/document.xml.rels')) { |f| Nokogiri::XML(f) }
      relationships = rels_xml.children.last
      relationships.children.each do |node|
        next unless node.name == 'Relationship'
        case node.attr('Type').split('/').last
        when 'image'
          image_file = Gui_Builder_Profile::File.create
          @images[node.attr('Id')] = make_gbp_file(File.join(word_dir, node.attr('Target')))
        when 'footnotes'
          # TODO Add footnotes by hand.  Much easier if it is only a few.
          # @footnotes[node.attr('Id')] = {}
        when 'endnotes', 'styles', 'fontTable', 'theme', 'webSettings', 'settings', 'customXml'
          # none
        when 'oleObject', 'package'
          # do nothing -- this is a link to another MS product (e.g. MS Excel, MS Photo Editor, an MS PowerPoint slide, etc.) which was used to create a nearby object (probably an image)
        when 'footer'
          # TODO ??
        when 'header'
          # TODO ??
        when 'numbering'
          # TODO ??
        when 'hyperlink'
          @links[node.attr('Id')] = {:target => node.attr('Target'), :external => (node.attr('TargetMode') == 'External')}
        else
          puts 'Unknown rel type: ' + Rainbow(node.attr('Type').split('/').last).red
        end
      end
      # pp @styles
      # pp @endnotes
    end
    
    def extract(node)
      # @debug = true if stuff == 'Segment Level Profiling'
      # @quit = true if stuff == 'Data Type Profiling'
      # return if @quit
      # return unless @debug
      
      # ntype = node.class.to_s
      # if ntype == 'Text'
      #   ChangeTracker.start
      #   t = V2Web::Text.new
      #   t.content = Gui_Builder_Profile::RichText.new(:content => node.content)
      #   t.save
      #   @current_section.add_content(t)
      #   ChangeTracker.commit
      #   return
      # end
      
      case node.name
      when 'body'
        node.children.each { |c| extract(c) }
      when 'document'
        ChangeTracker.start
        @site.ooxml = Gui_Builder_Profile::Code.create(:content => node.to_xml)
        ChangeTracker.commit
        node.children.each { |c| extract(c) }
      when 'tbl'
        # Some "tables" are not tables at all and are just a single cell used as a colored box.
        ns = node.to_s
        m = /fill="(?<color>.*?)"/.match(ns)
        if m&.[](:color).to_s =~ /D9D9D9/
          gray_box(node)
        elsif m&.[](:color).to_s =~ /FEDADB/
          pink_box(node)
        else
          add_table(node)
        end
      when 'bookmarkStart', 'bookmarkEnd'
        # TODO
      when 'sectPr'
        # TODO not sure what this is for
      when 'p'
        last_node_was_list = false
        # first check to see if it is a drawing
        blip = node.xpath('.//blip').first
        if blip
          id = blip.attr('embed')
          ChangeTracker.start
          figure = V2Web::Figure.create
          @last_figure = figure
          figure.file = @images[id]
          figure.save
          @current_section.add_content(figure)
          ChangeTracker.commit
          @current_text = nil
          return
        end

        # puts Rainbow(node.path).green
        styles = node.xpath('.//pPr/pStyle')
        bullet_list = node.xpath('.//pPr/numPr').first
        # puts Rainbow(styles.inspect).yellow if @debug
        puts Rainbow('Multiple Styles!').red if styles.count > 1
        if styles.first
          val_attr = styles.first.attributes.find { |a| a.first == 'val' }
          style = val_attr.last.value
          
          # HACK because Word is a POS...
          if bullet_list
            puts extract_text(node)
            unless style == 'ListParagraph'
              if style == 'NormalIndented'
                style = 'ListParagraph'
              else
                puts extract_text node
                puts
                puts node.to_s
                raise "List had style #{style} and I don't know how to handle that without some help."
              end
            end
          end

          if style =~ /Heading/
            header(node, style[-1].to_i)
          # elsif style =~ /Header/
          #   puts node.to_xml;puts
          else
            @caption = nil
            last_node_was_list = false
            case style
            when 'Graphic'
              imagedata = node.xpath('.//imagedata')
              if imagedata
                id = imagedata.attr('id')
                ChangeTracker.start
                figure = V2Web::Figure.create
                # @last_figure = figure
                figure.file = @images[id]
                figure.save
                @current_section.add_content(figure)
                ChangeTracker.commit
                @current_text = nil # close preceeding text block
              end              
            when 'TOC1', 'TOC2', 'TOC3', 'TOC4', 'TOC5', 'TableofFigures'
              # Make these DRY
            when 'NormalListAlpha'
              start_list('letters') unless @list
              last_node_was_list = true
              add_list_item(node)
            when 'Bullet', 'NormalListBullets', 'ListParagraph'
              start_list('bullets') unless @list
              last_node_was_list = true
              add_list_item(node)
              puts 'Added to list: ' + extract_text(node) if @debug


            when 'Caption'
              @caption = extract_text(node)
              # At least in the document I have now, figure captions come after the figure while table captions come before the table.  This makes things fun...It'll be even more fun when it is even less consistent in some other Word document.
              if @last_figure
                ChangeTracker.start
                @last_figure.caption = @caption
                @last_figure.save
                ChangeTracker.commit
                @last_figure = nil
                @caption = nil
              end
            when 'OtherTableCaption'
              @alt_caption = extract_text(node)
              # At least in the document I have now, figure captions come after the figure while table captions come before the table.  This makes things fun...It'll be even more fun when it is even less consistent in some other Word document.
            when 'Title'
              # Ignore this for now.  Just title of TOC and Indicies of Figures and Tables
            when 'Figure'
              add_text(node)
              # NOTE -- In the first of Rob's documents there are just a couple of these with any content.  They are simply paragraphs that describe a nearby figure or table.  There are similar paragraphs that aren't style as 'Figure'.  I'm just going to treat these as regular text for now and depend on the fact that there are bracketing tables or figures to make them distinct text elements.  Other .docx files may require some other treatment of content found in paragraphs styled as 'Figure'.
            when 'Table'
              # TODO What the heck is this?
            when 'Header'
              special_header(node)
              # Just 'Acknowledgements'
            when 'NormalIndented'
              # HL7 v2.x Messaging Standard (www.hl7.org)
              add_text(node)
            when 'NormalWeb'
              # This should probably have just been 'Normal' in most cases
              add_text(node)
            else
              
              # There aren't anymore right now but may be some in other docx
              puts 'Unknown style for paragraph: ' + Rainbow(style).red
              add_text(node)
            end
            # @figure should only be preserved for the very next paragraph after the figure, then forget about it.
          end
        else
          # puts Rainbow("No Style").magenta if @debug
          add_text(node)
        end
        @last_figure = nil
        @list = nil unless last_node_was_list # assumes that all items in a list occur in successive p elements
      else
        unless node.name == 'bookmarkStart' # not worrying about bookmarks in Word document
          puts Rainbow(node.name).magenta
          puts node.to_xml[0..1000]
        end
      end
    end
    
    def start_list(indicator_kind, unordered = false)
      @current_text = nil
      ChangeTracker.start
      @list = V2Web::List.new
      @list.item_indicator = case indicator_kind
      when 'NormalList'
        'none'
      when 'NormalListAlpha', 'letters'
        'letters'
      when 'NormalListBullets', 'bullets'
        'bullets'
      when 'NormalListNumbered'
        'numbers'
      else
        raise "Unknown List Type #{indicator_kind}"
      end
      (@current_section || @section).add_content(@list)
      ChangeTracker.commit
    end
    
    def add_list_item(node)
      ChangeTracker.start
      text ||= V2Web::Text.create
      t = extract_text(node)
      # remove_empty_paragraphs_from_html(t)
      text.content = Gui_Builder_Profile::RichText.create(:content => t)
      text.save
      @list.add_item(text) # TODO only works for simple text content
      ChangeTracker.commit
    end
    
    # def remove_empty_paragraphs_from_html(t)
    #   puts t
    #   t.gsub!('<p></p>', '')
    # end
    
    def make_xml_code(node)
      xml = Gui_Builder_Profile::Code.create(:content => node.to_xml)
      xml.language = 'XML'
      xml.save
      xml
    end
    
    def make_html_code(nodes)
      html = Gui_Builder_Profile::Code.create(:content => nodes.map { |n| n.to_html}.join )
      html.language = 'HTML'
      html.save
      html
    end
    
    def make_html_text(nodes)
      html = Gui_Builder_Profile::RichText.create(:content => nodes.map { |n| n.to_html }.join )
      html.markup_language = 'HTML'
      html.save
      html
    end

    def box(node, styles)
      @current_text = nil
      ChangeTracker.start
      box = V2Web::Box.create
      # styles can be passed as single style or array of styles
      [styles].flatten.each { |s| box.add_style(s) }
      @current_section.add_content(box)
      ChangeTracker.commit
      paragraphs = node.xpath('.//p')
      paragraphs.each { |pg| add_text(pg, box) }
      @current_text = nil
    end

    def gray_box(node)
      box(node, 'gray-box')
    end

    def pink_box(node)
      box(node, 'pink-box')
    end
    
    def add_table(node)
      @current_text = nil # make sure we close the preceeding text block
      ChangeTracker.start
      # puts "NO CAPTION" unless @caption
      table = V2Web::Table.create
      if @caption
        table.caption = @caption
        @caption = nil
      end
      table.ooxml = make_xml_code(node)
      (@current_section || @section).add_content(table)
      add_styles(node, table)
      ChangeTracker.commit
      ChangeTracker.start
      cols = node.xpath('.//tblGrid/gridCol')
      cols.each do |col|
        scol = V2Web::Column.create
        # TODO = capture original style and put it in here
        # table.add_column(scol)
        table.add_col(scol)
      end
      ChangeTracker.commit
      add_rows(table, node)
    end
    
    def add_rows(table, node)
      rows = node.xpath('.//tr')
      rows.each_with_index do |row, i|
        ChangeTracker.start
        srow = V2Web::Row.create
        srow.header = i == 0 ? true : false
        srow.ooxml = make_xml_code(row)
        srow.save
        table.add_row(srow)
        ChangeTracker.commit
        add_cells(srow, row)
      end
    end
    
    def add_cells(srow, node)
      cells = node.xpath('.//tc')
      cells.each do |cell|
        ChangeTracker.start
        scell = V2Web::Cell.create
        scell.colspan = (cell.to_s.slice(/(?<=gridSpan val=")\d+/) || 1).to_i
        add_styles(cell, scell)
        srow.add_cell(scell)
        scell.ooxml = make_xml_code(cell)
        paragraphs = cell.xpath('.//p')
        paragraphs.each do |para|
          extracted_paragraph = extract_text(para, true)
          text = Gui_Builder_Profile::RichText.create(:content => extracted_paragraph)
          stext = V2Web::Text.create
          stext.content = text
          scell.add_content(stext)
        end
        scell.save
        ChangeTracker.commit
      end
    end
    
    # NOTE: This assumes that a UnitOfWork is already opened!
    def add_styles(node, model)
      if node.to_s =~ /fill="EECECC"/ && model.is_a?(V2Web::Cell)
        model.add_style('emphasis-column')
      end
      if node.to_s =~ /fill="C96660"/ && model.is_a?(V2Web::Cell)
        model.add_style('emphasis-header')
      end
      if node.to_s =~ /fill="F3E1E1"/ && model.is_a?(V2Web::Table)
        model.add_style('striped-rows')
      end
    end
    
    def add_text(node, text_parent = @current_section)
      debug = true if false && text_parent.is_a?(V2Web::Box)
      ChangeTracker.start
      @current_text ||= V2Web::Text.create
      if @current_text.content
        @current_text.content_content = @current_text.content_content + extract_p(node)
        @current_text.ooxml_content = @current_text.ooxml_content + "\n" + node.to_xml # remove newline FIXME?
      else
        @current_text.content = Gui_Builder_Profile::RichText.create(:content => extract_p(node))
        xml = Gui_Builder_Profile::Code.create(:content => node.to_xml)
        xml.language = 'XML'
        xml.save
        @current_text.ooxml = xml
      end
      @current_text.save
      # FIXME look here for Box content issue
      unless text_parent.content.last&.is?(@current_text)
        text_parent.add_content(@current_text)
      end
      ChangeTracker.commit
      if debug
        puts text_parent.content.last.content_content;puts '*'*20
      end
    end
    
    def add_styled_text(node, style, text_parent = (@current_section || @section))
      # Start new Text if style changes
      @current_text = nil if @current_text && @current_text.styles.first.to_s != style
      add_text(node, text_parent)
      return if @current_text.styles.map(&:value).include?(style)
      ChangeTracker.start
      @current_text.add_style(style)
      ChangeTracker.commit
    end
    
    def extract_p(node)
      raise unless node.name == 'p'
      texts = extract_text(node, true)
      '<p>' + texts + '</p>'
    end
    
    def raw_text(node)
      extract_plain_text(node)
    end
    
    # Only being used to get titles
    def extract_text(node, preserve_style = false)
      parsed_text = ''
      runs = node.xpath('.//r')
      runs.each do |run|
        run_text = ''
        texts = run.xpath('.//t | .//noBreakHyphen | .//br')
        texts.each do |t|
          if t.name == 'noBreakHyphen'
            run_text << '-'
          elsif t.name == 'br'
            run_text << "\n"
            # run_text << "<br/>"
          else
            run_text << CGI.escapeHTML(t)
          end
        end
        unless run_text.empty?
          parsed_text << style_text(run, run_text)
        end
      end
      linkify(parsed_text) if parsed_text =~ url_matcher
      emailify(parsed_text) if parsed_text =~ email_matcher
      parsed_text
    end
    
    def extract_plain_text(node)
      parsed_text = ''
      runs = node.xpath('.//r')
      runs.each do |run|
        run_text = ''
        texts = run.xpath('.//t | .//noBreakHyphen | .//br')
        texts.each do |t|
          if t.name == 'noBreakHyphen'
            run_text << '-'
          elsif t.name == 'br'
            run_text << "\n"
          else
            run_text << t#CGI.escapeHTML(t)
          end
        end
        unless run_text.empty?
          parsed_text << run_text
        end
      end
      # linkify(parsed_text) if parsed_text =~ url_matcher
      # emailify(parsed_text) if parsed_text =~ email_matcher
      parsed_text
    end
    
    
    def url_matcher
      # from https://stackoverflow.com/questions/6038061/regular-expression-to-find-urls-within-a-string/29288898#29288898
            /(?:(?:https?|ftp|file):\/\/|www\.|ftp\.)(?:\([-A-Z0-9+&@#\/%=~_|$?!:,.]*\)|[-A-Z0-9+&@#\/%=~_|$?!:,.])*(?:\([-A-Z0-9+&@#\/%=~_|$?!:,.]*\)|[A-Z0-9+&@#\/%=~_|$])/im
    end
    
    def linkify(text)
      urls = url_matcher.match(text).to_a.uniq
      # if urls.any?
      #   puts text
      # end
      urls.each { |url| text.gsub!(url, "<a href='#{url}'>#{url}</a>") }
    end
    
    def email_matcher
      /([a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+)/i
    end
    
    def emailify(text)
      email_addresses = email_matcher.match(text)
      email_addresses.to_a.uniq.each { |ea| text.gsub!(ea, "<a href='mailto:#{ea}'>#{ea}</a>") }
    end
    
    # Assuming that normal font size in docx is 11pt, which is specified in ooxml in 1/2pt units.
    # We're going with 15px downstream as the default size -- not sure how to scale things though....
    def style_text(node, text, default_size:22)
      styles = []
      str  = node.to_s
      hyperlink = str =~ /<rStyle val="Hyperlink"\/>/ # because MS Word is insane! The 'Hyperlink' style defines one set of font and size in the style pane, a different set of font and size in the OOXML, and the actual rendering in MS Word is yet another thing.  WTF!!!!
      size = (str.slice(/(?<=sz\sval=")\d+/) || default_size).to_i
      size = default_size if hyperlink
      unless size == default_size
        styles << "font-size:#{size/2 + 4}px" # wild ass guess at getting size right
      end
      
      color = str.slice(/(?<=color val=")[A-Z0-9]+?(?=")/)
      if color
        styles << "color:##{color.downcase}"
      end
      
      font = str.slice(/(?<=rFonts ascii=").+?(?=")/) unless hyperlink
      # Assuming default is Times New Roman so we aren't recording it
      if font == 'Courier New'
        styles << 'font-family:Courier New,Courier,monospace'
      end
      if font == 'Arial'
        styles << 'font-family:Arial,Helvetica,sans-serif'
      end
      
      if node.to_s =~ /<b\/>/
        text = '<strong>' + text + '</strong>'
      end
      # Finish and apply styles
      if styles.any?
        text = '<span style="' + styles.join("; ") + '">' + text + '</span>'
      end
      text  
    end
    
    def header(node, header_depth)
      @current_text = nil    
      ChangeTracker.start
      # puts "#{header_depth} -- #{extract_text(node)}"
      next_section  = V2Web::Section.create(:title => extract_text(node), :version => Time.now.strftime('%Y.%m.%d.%R'))
      xml = Gui_Builder_Profile::Code.create(:content => node.to_xml)
      xml.language = 'XML'
      xml.save
      next_section.ooxml = xml
      if header_depth == @current_depth
        next_section.current_parent = @current_section.current_parent
      elsif header_depth > @current_depth
        @current_depth += 1
        next_section.current_parent = @current_section
      elsif header_depth < @current_depth
        change = @current_depth - header_depth
        target = @current_section.current_parent
        change.times do
          target = target.current_parent
        end
        
        next_section.current_parent = target
        @current_depth = header_depth # errrr, ok...doing it this way depends on no skipped header types in the original Word Doc...
      end
      
      @current_section = next_section

      @current_section.current_parent.add_content(@current_section)
      # if header_depth >= @current_depth
      # 
      # next_section  = V2Web::Section.create(:title => extract_text(node))
      #   
      # xml = Gui_Builder_Profile::Code.create(:content => node.to_xml)
      #   # xml.language = 'XML'
      #   # xml.save
      #   # next_section.ooxml = xml
      #   # FIXME turn this back on for FHIR resource linking
      #   # section      = FHIR::Section.create(:title => extract_text(node))
      #   # section.sdoc = next_section
      #   # narrative    = FHIR::Narrative.create
      #   # section.text = narrative
      #   # next_section.ooxml = # FIXME
      #   # html = 'FIXME' # FIXME convert .docx snippet to html snippet
      #   # code = Gui_Builder_Profile::Code.create(:content => html)
      #   # code.language = 'HTML'
      #   # narrative.div = code
      #   # narrative.save
      #   # @current_fhir.add_section(section) if @current_fhir
      #   # @current_fhir = section
      #   if header_depth > @current_depth
      #     @current_depth += 1
      #     next_section.current_parent = @current_section
      #     # FIXME not tracking current parent of section -- need to do this in order for this to get structured correctly.  see :current_parent for analogous situation applied to V2Web elements
      #   else
      #     next_section.current_parent = @current_section.current_parent
      #   end
      #   next_section.current_parent.add_content(next_section)
      #   @current_section = next_section
      # else
      #   @current_section = @current_section.current_parent
      #   # @current_fhir = @current_fhir.parent
      #   @current_depth -= 1 # This is WRONGGGGGGGG!!~!!!!! we don't know how far to go back up!
      # end
      ChangeTracker.commit
    end
    
    # Note that this is a one off for the MS Word 'Header' style, which is different from the 'Heading' styles.
    def special_header(node)
      add_text(node)
      c = @current_text.content.content
      paragraphs = c.split(/(?<=\<\/p\>)/)
      return if paragraphs[-1] == '<p></p>' # do nothing if it is empty
      replacement = paragraphs.pop.sub('<p>', '<p><span style="font-size:22px"><strong>').sub('</p>', '</p></strong></span>')
      paragraphs << replacement
      ChangeTracker.start
      html = Gui_Builder_Profile::RichText.create(:content => paragraphs.join)
      html.markup_language = 'HTML'
      html.save
      @current_text.content = html
      @current_text.save
      ChangeTracker.commit
      @current_text = nil
    end
    
    def show_cells(node)
      node.css('tr').each do |row|
        celltxts = row.children.select { |n| n.name == 'tc' }.map { |cell| Nokogiri::HTML(extract_raw_tc(cell)).text }
        puts celltxts.inspect
      end
    end
    
    def is_ack_table?(node)
      node.css('p').each do |paragraph|
        return true if node_style(paragraph) == 'ACK-ChoreographyHeader'
      end
      false
    end
    
    def ack_table_msg(node)
      msg = node.css('tr')[1].children.select { |n| n.name == 'tc' }.map { |cell| Nokogiri::HTML(extract_raw_tc(cell)).text }.first
      msg
    end
    
    def is_msg_table?(node)
      node.css('p').each do |paragraph|
        return true if node_style(paragraph) == 'MsgTableHeader'
      end
      false
    end
    
    def is_segment_table?(node)
      node.css('p').each do |paragraph|
        return true if node_style(paragraph) == 'AttributeTableHeader'
      end
      false
    end
    
    def is_component_table?(node)
      node.css('p').each do |paragraph|
        return true if node_style(paragraph) == 'ComponentTableHeader'
      end
      false
    end
    
    def node_style(node)
      node.xpath('.//pPr/pStyle').first&.attribute('val')&.value
    end
    
    def node_styles(node)
      node.xpath('.//pPr/pStyle').map { |s| s.attribute('val')&.value }.compact.uniq
    end
    
    def parse_code_set(set)
      parts = set.split(/\s*,\s*/)
      parts.map { |part| part =~ /-/ ? expand_code_range(part) : part }.flatten
    end
    
    def expand_code_range(range)
      first, last = range.split(/\s*[-]\s*/).map(&:strip)
      event_codes = [first]
      code = first
      until code == last
        code = code.succ
        event_codes << code
      end
      event_codes
    end
    
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
  end
end
