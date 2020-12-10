module V2Web  
  class DocXtractor    
    def setup_extra(source, title)
      @chapter = title
      HL7Parse.set_list_styles(@chapter)
      base_path = File.expand_path(File.join('~/projects/v2web/test_data/v2plus_extras', source))
      docx_path = base_path + '.docx'
      zip_path  = base_path + '.zip'
      unzipped  = base_path

      FileUtils.cp_r(docx_path, zip_path, :remove_destination => true) unless File.exist?(zip_path)
      system "unzip -o #{zip_path} -d #{unzipped}" unless File.exist?("#{unzipped}/word/document.xml")

      docx = Docx::Document.open(docx_path)
      docx.setup(unzipped, chapter)
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
    
    def setup_for_extra(source, title)
      puts Rainbow("#### Parse Extra #{source} ###").orange
      setup_extra(source, title)
    end

    def extract_extra(source, title)
      doc = setup_for_extra(source, title)
      @styles = []
      @html_fragments = []
      @p_buffer       = []
      # @last_node = nil
      doc.at('body').children.each { |c| extract_extra_node(c) }
      fill_narrative # add text to last section
      ChangeTracker.start
      @composition.title = 'HL7 over HTTP Specification'
      ChangeTracker.commit
      @composition.persist(V2Plus::Composition.persistance_dir)
      pp @composition
      @composition
    end
    
    def extract_extra_node(node)
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
              unless (2..6).include?(depth)
                puts node
                raise "Bad depth for #{style}"
              end
              create_section(txt, depth, 'clause')
            end
          else
            return if @skip
            case style          
            when 'TOC1', 'TOC2', 'TOC3', 'TOC4', 'TOC5', 'TableofFigures'
              add_to_narrative(node, :style => style)
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
    
  end
end