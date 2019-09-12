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
require_relative 'current_parent_hack'
module V2Web
  class DocXtractor
    def extract_document(doc, title = 'Test')
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
    end
    
    def get_mime_type(path)
      `file --brief --mime-type - < #{Shellwords.shellescape(path)}`.strip
    end
    
    def make_gbp_file(path)
      ChangeTracker.start
      f = Gui_Builder_Profile::File.create(:filename => path.split('/').last, :mime_type => get_mime_type(path))
      bd = Gui_Builder_Profile::BinaryData.create(:data => File.binread(path))
      f.binary_data = bd
      f.save
      ChangeTracker.commit
      f
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
        puts Rainbow('Multiple Styles!').red if styles.count > 1
        if styles.first
          val_attr = styles.first.attributes.find { |a| a.first == 'val' }
          style = val_attr.last.value
          if style =~ /Heading/
            # puts node.to_xml;puts
            header(node, style[-1].to_i)
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
            when 'ListParagraph'
              # puts Rainbow("List: #{extract_text(node)}").yellow

            # Make these DRY
            when 'NormalListAlpha'
              start_list('letters') unless @list
              last_node_was_list = true
              add_list_item(node)
            when 'Bullet', 'NormalListBullets'
              start_list('bullets') unless @list
              last_node_was_list = true
              add_list_item(node)


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
              # Just 'Acknowledgements'
            when 'NormalIndented'
              # HL7 v2.x Messaging Standard (www.hl7.org)
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
          add_text(node)
        end
        @last_figure = nil
        @list = nil unless last_node_was_list # assumes that all items in a list occur in successive p elements
      else
        unless node.name == 'bookmarkStart' # not worrying about bookmarks in Word document
          puts Rainbow(node.name).orange
          puts node.to_xml[0..1000]
        end
      end
    end
    
    def start_list(indicator_kind, unordered = false)
      @current_text = nil
      ChangeTracker.start
      @list = V2Web::List.new
      # FIXME turn these on after regeneration
      # @list.ordered = true unless unordered
      # @list.indicator = 'letters'
      @list.item_indicator = 'letters' # turn off after regeneration
      @current_section.add_content(@list)
      ChangeTracker.commit
    end
    
    def add_list_item(node)
      ChangeTracker.start
      text ||= V2Web::Text.create
      text.content = Gui_Builder_Profile::RichText.create(:content => extract_text(node))
      text.save
      @list.add_item(text) # TODO only works for simple text content
      ChangeTracker.commit
    end
    
    def make_xml_code(node)
      xml = Gui_Builder_Profile::Code.create(:content => node.to_xml)
      xml.language = 'XML'
      xml.save
      xml
    end
    
    def make_html_code(nodes)
      html = Gui_Builder_Profile::Code.create(:content => nodes.map{ |n| n.to_html}.join("\n") )
      html.language = 'HTML'
      html.save
      html
    end
    
    def make_html_text(nodes)
      html = Gui_Builder_Profile::RichText.create(:content => nodes.map { |n| n.to_html }.join("\n") )
      html.markup_language = 'HTML'
      html.save
      html
    end

    def box(node, style)
      @current_text = nil
      ChangeTracker.start
      box = V2Web::Box.create
      box.style = style
      @current_section.add_content(box)
      ChangeTracker.commit
      parent = @current_section
      @current_section = box
      add_text(node)
      @current_section = parent
    end

    def gray_box(node)
      box(node, 'gray_box')
    end

    def pink_box(node)
      box(node, 'pink_box')
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
      @current_section.add_content(table)
      add_styles(node, table)
      ChangeTracker.commit
      ChangeTracker.start
      cols = node.xpath('.//tblGrid/gridCol')
      cols.each do |col|
        scol = V2Web::Column.create
        # TODO = capture original style and put it in here
        table.add_column(scol)
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
        add_styles(cell, scell)
        srow.add_cell(scell)
        scell.ooxml = make_xml_code(cell)
        paragraphs = cell.xpath('.//p')
        paragraphs.each do |para|
          text = Gui_Builder_Profile::RichText.create(:content => extract_text(para))
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
        model.add_style('emphasis_column')
      end
      if node.to_s =~ /fill="C96660"/ && model.is_a?(V2Web::Cell)
        model.add_style('emphasis_header')
      end
      if node.to_s =~ /fill="F3E1E1"/ && model.is_a?(V2Web::Table)
        model.add_style('striped_rows')
      end
    end
    
    def add_text(node)
      ChangeTracker.start
      @current_text ||= V2Web::Text.create
      if @current_text.content
        @current_text.content_content = @current_text.content_content + extract_p(node)
      else
        @current_text.content = Gui_Builder_Profile::RichText.create(:content => extract_p(node))
      end
      @current_text.save
      unless @current_section.content.last&.is?(@current_text)
        @current_section.add_content(@current_text)
      end
      ChangeTracker.commit
    end
    
    def extract_p(node)
      extract_text(node, true)
    end
    
    def extract_text(node, paragraph = false)
      texts = node.xpath('.//t').map { |t| t.content }.join.strip
      if paragraph and node.name == 'p'
        texts = '<p>' + texts + '</p>'
      end
      texts
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
  end
end
