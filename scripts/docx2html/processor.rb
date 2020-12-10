require 'base64'
module Docx2HTML
  class FootnoteError < StandardError; end 

  class Processor
    attr_accessor :list, :output
    attr_reader   :opts, :images, :embeds, :chapter
    def initialize(input, opts = {})
      @client    = opts[:client]
      @lists     = []
      @input     = input
      @output    = ''
      @opts      = opts
      @chapter   = opts[:chapter]
      @links     = opts[:links]
      @embeds    = opts[:embeds]
      @images    = opts[:images]
      @footnotes = opts[:footnotes]
      @image_substitutions = opts[:image_substitutions]
      # puts @input
    end
    
    def process(opts = {})
      @opts = @opts.merge(opts)
      if @input.is_a?(Array)
        begin
          # puts @input
          # puts '*'*33
          @input.each do |n|
            sub_process(n)
          end.join
        rescue ListError
          puts @input
          raise
        end
        add_list_and_note
      else
        sub_process(@input)
      end
      if @opts[:raw]
        if output =~ /<\/strong><\/strong>/
          puts @input
          raise "</strong></strong>"
        end
        return output
      end
      puts caller; puts opts.keys.inspect ;raise# ret = sub_process(@nodes).join
      nokhtml = Nokogiri::HTML::fragment(output).to_xhtml(indent: 2)
      # if output =~ /^<p/
      #   puts
      #   puts output#.inspect
      #   puts Rainbow(nokhtml).cyan
      #   puts Rainbow(Nokogiri::HTML::fragment(nokhtml).to_xhtml(indent: 2) ).magenta
      # end
      if @opts[:debug]
        puts @input
        puts Rainbow(output.inspect).cyan
        puts Rainbow(nokhtml.inspect).magenta
      end
      nokhtml
    end
    
    def sub_process(input)
      if input.is_a?(Array)
        raise "should not get an array"
        nodes = input
      elsif input.name == 'tbl'
        output << Table.new(input, @opts).process
      else
        # puts input
        case input.name
        when 'p'
          process_p(input)
        when 'hyperlink'
          nodes = collect_nodes(input)
          hyperlink(nodes)
          raise
        when 'bookmarkStart', 'bookmarkEnd'
          # ignore
        else
          raise "Can't process a #{input.name} node."
          puts caller.first
        end
        # puts '*'*33
      end
    end
    
    def add_list
      if @lists.any?
        # puts "Adding list"
        output << @lists.first.html 
        @lists.clear
      end
    end
        
    def set_list(props, styles, input)
      styles = styles.reject { |s| ['normalindented'].include?(s) }
      list_styles = styles & List.known_styles
      puts Rainbow("List with unknown styles #{styles}").red if styles.any? && list_styles.empty?
      puts Rainbow("Multiple styles for list #{styles}").orange if styles.count > 1
      list_style = list_styles.first
      numPr = props.at_xpath('.//numPr')
      if numPr
        begin
          depth = numPr.at_xpath('.//ilvl')['val'].to_i
          numId = numPr.at_xpath('.//numId')['val']
        rescue
          puts input
          raise
        end
        # puts Rainbow("numId: #{numId} and styles: #{styles}").yellow if styles.any?
      else
        numId = nil
        depth = 0
      end
      if @lists.empty?
        @lists << List.new(list_style, numId, opts)
      end
      # puts Rainbow("#{depth} - #{list_style}")
      while depth > (@lists.count - 1)
        # puts "before: depth is #{depth}, lists: #{@lists.count - 1}"
        # pp @lists
        if depth + 1 == @lists.count
          sub_list = List.new(list_style, numId)
        else
          # puts Rainbow("Depth indicates there is a sublist but there is no parent list.").red + " #{extract_run_text(input)}"
          sub_list = List.new(list_style, numId, :sublist => true)
        end
        add_to_list(nil) unless @lists.last.items.any?
        @lists.last.items.last.list = sub_list
        @lists << sub_list
        # puts "after: depth is #{depth}, lists: #{@lists.count - 1}"
        # pp @lists
      end
      while depth < (@lists.count - 1)
        @lists.pop
      end
      # else
      #   raise "Tried to start a list that did not have numPr" unless @lists.any?
      # end
      # puts props
    end
    
    def add_to_list(content)
      @lists.last.add(ListItem.new(content)) #FIXME
    end
    
    def image64(str, ext)
      html = '<div class="v2-image"><img src="data:image/' + ext + ';base64, ' + str + '" /></div>'
    end
    
    def process_p(input)
      object = input.at_xpath('.//OLEObject')
      if object
        prog = object['ProgID']
        rId = object['id']
        directive = @image_substitutions[rId]
        # puts directive if directive
        if directive == :remove
          add_list_and_note
          output << ''
          return
        end
        # NOTE: Originally we were going to put the replacement files in @image substitutions.  Instead the paths for usable images have already been moved into @objects
        # if directive
        #   add_list_and_note
        #   output << ''
        #   return
        # end
        path = @embeds.dig(rId)
        unless File.exist?(path)
          puts input;puts
          pp @embeds
        end
        puts path
        ext  = path.split('.').last
        b64  = Base64.encode64(File.open(path, "rb").read) # will raise if no file
        img = image64(b64, ext)
        add_list_and_note
        output << img
        return
      end
      image = input.at_xpath('.//drawing') || input.at_xpath('.//graphic')
      if image
        blip = image.at_css('blip')
        if blip
          rId = blip['embed']
          directive = @image_substitutions&.[](rId)
          if directive == :remove
            add_list_and_note
            output << ''
            return
          end
          if directive
            add_list_and_note            
            output << ''
            return
          end          
          path = @images.dig(rId)
          ext  = path.split('.').last
          b64  = Base64.encode64(File.open(path, "rb").read) # will raise if no file
          img = image64(b64, ext)
          add_list_and_note
          output << img
          return
        end
      end
      
      # puts Rainbow(input).magenta
      nodes = collect_nodes(input)
      css_classes = []
      # puts input
      # puts '*'*33      
      props     = input.xpath('.//pPr')
      list_item = props.at_xpath('.//numPr')
      list_item = list_item.at_xpath('.//ilvl') if list_item # There are cases where there is numPr but it isn't a list.  If it is a list then it should have ilvl
      styles    = props.xpath('.//pStyle')&.map { |s| s['val'].downcase }&.uniq
      is_note   = styles.include?('note')
      styles.delete('note') if is_note
      jc        = props.at_xpath('.//jc')
      if jc
        val = jc['val']
        css_classes << 'centered' if val == 'center'
        css_classes << 'justify'  if val == 'both'
        # css_classes << 'left' if val == 'left' # do nothing, this is the default
        css_classes << 'justify-right' if val == 'right'
      end
      indentations = props.xpath('.//ind')&.map { |s| s['left'] }&.uniq
      return if @opts[:remove_headings] && styles.find { |s| s =~ /heading\d/ }
      puts Rainbow("Multiple Styles for paragraph! #{styles}").red if styles&.count.to_i > 1
      puts Rainbow("Multiple Indentations for paragraph! #{indentations}").red if indentations&.count.to_i > 1
      str = '<p class=' + '"v2'
      str << ' ' + css_classes.join(' ') if css_classes.any?
      str << ' v2-' + styles.first if styles.first
      str << ' v2-indent' + indentations.first.downcase if indentations.first  
      # at this point, nodes should all be paragraph contents
      p_contents = process_paragraph_contents(nodes)
      if opts[:is_footnote]
        str << footnote_p(p_contents) 
      else
        str << '">' + p_contents + '</p>'
      end
      if is_note
        add_list
        @note ||= Note.new
        @note.add(str)
      elsif list_item || (styles & List.known_styles).any?
        add_note
        begin
          set_list(props, styles, input)
        rescue ListError => e
          # unless p_contents.strip.empty?
            puts input
            raise
          # end
        end
        # puts "Adding to list: #{str}"
        add_to_list(str)
      else
        add_list_and_note
        output << str
      end
    end

    def add_list_and_note
      add_note
      add_list
    end
    
    def add_note
      return unless @note
      output << @note.html
      @note = nil
    end
    
    def collect_nodes(node)
      collection = node.children.select do |child_node|
        case child_node.name
        when 'bookmarkStart', 'bookmarkEnd', 'proofErr'
          false
        when 'pPr'
          # puts Rainbow(child_node).magenta
          true
        when 'r', 'hyperlink'
          true
        else
          puts "Skipping a #{child_node.name} found in a #{node.name}"
          false
        end
      end
      collection
    end
  
    def link_styles
      ['HyperlinkText', 'Hyperlink', 'ReferenceAttribute']
    end
  
    def run(node)
      run_text = extract_run_text(node)
      styles   = [get_style(node)]
      styles << 'Strong' if node.at_xpath('.//b')
      styles.uniq! # sometimes docx uses w:b and sometimes they use style Strong...go figure
      # Guessing that people copied text that once had fn reference into the footnote and now the footnote text itself has a dead fn reference
      unless opts[:is_footnote] || opts[:ignore_footnotes]
        run_text = add_footnote_reference(run_text, node) if styles.include?('FootnoteReference')
      end
      
      if (styles & link_styles).any?
        raise # Should no longer be happening.        
        # styles = styles - link_styles
        # run_text.strip.empty? ? nil : Docx2HTML::LinkedRun.new(node,run_text, run_text, styles, @opts)
      else
        run_text.empty? ? nil : Docx2HTML::Run.new(node,run_text, styles, @opts)
      end
    end
    
    def linked_run(nodes)
      # We are going to apply all found styles to the entire bunch of text.  I know there is a small chance that this alters things a little bit.  We can TODO fix it later if it is really an issue.
      run_text = nodes.map { |node| extract_run_text(node) }.join
      styles   = nodes.map { |node| get_style(node) }.compact.uniq
      styles << 'Strong' if nodes.any? { |node| node.at_xpath('.//b') }
      # Guessing that people copied text that once had fn reference into the footnote and now the footnote text itself has a dead fn reference
      unless opts[:is_footnote] || opts[:ignore_footnotes]
        run_text = add_footnote_reference(run_text, node) if styles.include?('FootnoteReference')
      end            
      run_text.strip.empty? ? nil : Docx2HTML::LinkedRun.new(nodes, run_text, run_text, styles, @opts)
    end
    
    def add_footnote_reference(run_text, node)
      fn_id = node.css('footnoteReference').attribute('id')&.value
      unless fn_id
        # puts Rainbow('Null FootnoteReference').lime
        return run_text
        # raise FootnoteError, "Can't find footnoteReference with id value"
      end
      ch = @chapter
      raise "No chapter" unless ch
      @client.add_footnote(fn_id)
      output = '<span id="chapter-' + ch + '-footnote-reference-' + fn_id + '">' + run_text + '<a href="#chapter-' + ch + '-footnote-' + fn_id + '"><sup>' + fn_id + '</sup></a></span>'  
      # puts output
      output
    end
    
    def footnote_p(contents)
      fn   = opts[:is_footnote].to_s
      id   = 'chapter-' + @chapter.to_s + '-footnote-' + fn
      href = '#chapter-' + @chapter.to_s + '-footnote-reference-' + fn
      # '"><a href="chapter-' + @chapter.to_s + '-footnote-reference-' + fn + '">[' + fn + '] </a>' + '<span id="chapter-'  + @chapter.to_s + '-footnote-' + fn + '">' + contents + '</span></p>'
      '" id=' + id.inspect + '><a href=' + href.inspect + '>[' + fn + '] </a>' + contents + '</p>'
    end
    
    def extract_run_text(node)
      run_text = ''
      texts = node.xpath('.//t | .//noBreakHyphen | .//br | .//tab')
      texts.each do |t|
        if t.name == 'noBreakHyphen'
          run_text << '-'
        elsif t.name == 'br'
          run_text << "<br/>"
        elsif t.name == 'tab'
          run_text << '&nbsp;&nbsp;&nbsp;&nbsp;'
        else
          txt = CGI.escapeHTML(t.text)
          # if t['space'] == 'preserve'
          #   puts txt.inspect
          # end
          run_text << txt
        end
      end
      ret = run_text.html_entity_code_to_entity_number
      ret
    end
  
    def get_style(node)
      node.xpath('.//rStyle').attribute('val')&.value # should fail if multiple styles
    end
    
    def process_paragraph_contents(nodes, paragraph_opts = {})
      # debug = caller.join =~ /tables.rb/
      batches = []
      nodes.each_with_index do |n, i|
        s = get_style(n)
        if batches.empty?
          batches << { style:s, text:extract_run_text(n), nodes:[n]}
          next
        end
        if batches.last[:style] == s
          batches.last[:text]  << extract_run_text(n)
          batches.last[:nodes] << n
        else
          batches << { style:s, text:extract_run_text(n), nodes:[n]}
        end
      end
      # puts;puts batches.map { |h| "#{h[:style]} - #{h[:text]}" }
      # puts;puts batches.select { |h| h[:style] == 'Strong' }.map { |h| h[:text] }
      # batches.each { |e| puts Rainbow("#{e[:style].inspect} -- #{e[:text].length}").crimson if e[:text].strip.empty? }
      # puts batches.map{ |b| b[:style] }.uniq.sort.inspect if debug
      # puts nodes if nodes.to_s =~ /snomed/  
      # if batches.any? { |b| link_styles.include?(b[:style]) }
      #   pp batches
      #   puts
      # end
      
      bucket  = []
      batches.each do |batch|
        if link_styles.include?(batch[:style])
          lr = linked_run(batch[:nodes])
          bucket << lr if lr
        else
          batch[:nodes].each do |node|
            x = case node.name
            when 'r'
              begin
                run(node)
              rescue FootnoteError => e
                puts nodes
                puts Rainbow(node).cyan
                raise e
              end
            when 'hyperlink'
              hyperlink(node)
            when 'pPr', 'bookmarkStart', 'bookmarkEnd'
              # do nothing
            else
              puts Rainbow("Can't process a #{node.name} that is in a paragraph").red
            end
            # puts Rainbow(node).cyan if x.nil?
            bucket << x if x
          end
        end
      end
      # TODO some concern that there will be problems if a hyperlink style batch has multiple nodes
      
      # nodes.each do |node|
      #   x = case node.name
      #   when 'r'
      #     begin
      #       run(node)
      #     rescue FootnoteError => e
      #       puts nodes
      #       puts Rainbow(node).cyan
      #       raise e
      #     end
      #   when 'hyperlink'
      #     hyperlink(node)
      #   when 'pPr', 'bookmarkStart', 'bookmarkEnd'
      #     # do nothing
      #   else
      #     puts Rainbow("Can't process a #{node.name} that is in a paragraph").red
      #   end
      #   # puts Rainbow(node).cyan if x.nil?
      #   bucket << x if x
      # end
      begin
        if !paragraph_opts[:suppress_links]
          bucket.each do |r|
            next if r.is_a?(LinkedRun)
            puts r.node if r.styles.include?('Hyperlink') || r.styles.include?('HyperlinkText')
          end 
        end
        html = Docx2HTML::RunStyler.new.style(bucket, @opts.merge(paragraph_opts))
        # puts Rainbow("      #{html}").yellow
      rescue
        html = 'ERROR'
        puts nodes
        raise
      end
      # puts Rainbow(html).green
      html
    end
    
    def hyperlink(node)
      nid      = node['id']
      external = opts.dig(:links, nid, :external)
      target   = opts.dig(:links, nid, :target)
      if opts[:links]
        anchor_attr = target
      else
        anchor_attr = node['anchor']
        raise unless anchor_attr.nil? || anchor_attr.is_a?(String) # leaving this here until sure we are correct
      end
      anchor = anchor_attr ? anchor_attr : nil
      link_text = process_paragraph_contents(node.children, :suppress_links => true)
      anchor ||= link_text
      if link_text.empty?
        puts 'link with no text: ' + Rainbow(node).cyan
        ret = nil
      else
        ret = Docx2HTML::LinkedRun.new(node, link_text, anchor, 'Hyperlink', opts.merge({:text => link_text, :external_link => external}))
        # puts ret.inspect
      end
      if ret && external && ret.link.nil?
        puts "    EXTERNAL LINK: #{anchor.inspect} --> #{ret.link.inspect} (#{ret.text})"
      end
      ret
    end
          
  end # class Processor
end
