module Docx2HTML
  class FootnoteError < StandardError; end 

  class Processor
    attr_accessor :list, :output
    # attr_reader :nodes
    def initialize(input, opts = {})
      @lists = []
      @input = input
      @output = ''
      @opts = opts
      @chapter = opts[:chapter]
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
        add_list
      else
        sub_process(@input)
      end
      return output if opts[:raw]
      # ret = sub_process(@nodes).join
      # puts output
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
      numPr = props.xpath('.//numPr').first
      if numPr
        depth = numPr.xpath('.//ilvl').first['val'].to_i
        numId = numPr.xpath('.//numId').first['val']
        # puts Rainbow("numId: #{numId} and styles: #{styles}").yellow if styles.any?
      else
        numId = nil
        depth = 0
      end
      @lists << List.new(list_style, numId) if @lists.empty?
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
    
    def process_p(input)
      # puts Rainbow(input).magenta
      nodes = collect_nodes(input)
      # puts input
      # puts '*'*33      
      props     = input.xpath('.//pPr')
      list_item = props.xpath('.//numPr').first
      styles    = props.xpath('.//pStyle')&.map { |s| s['val'].downcase }&.uniq
      indentations = props.xpath('.//ind')&.map { |s| s['left'] }&.uniq
      return if @opts[:remove_headings] && styles.find { |s| s =~ /heading\d/ }
      # if list_item || (styles & List.known_styles).any?
      #   begin
      #     set_list(props, styles)
      #   rescue
      #     puts input
      #     raise
      #   end
      # else
      #   add_list
      # end
      # puts input if styles.include?('Example')
      # puts Rainbow(input.xpath('.//pPr/ind')).yellow if indentations
      puts Rainbow("Multiple Styles for paragraph! #{styles}").red if styles&.count.to_i > 1
      puts Rainbow("Multiple Indentations for paragraph! #{indentations}").red if indentations&.count.to_i > 1
      str = '<p class=' + "'v2"
      str << ' v2_' + styles.first if styles.first
      str << ' v2_indent' + indentations.first.downcase if indentations.first  
      # at this point, nodes should all be paragraph contents
      p_contents = process_paragraph_contents(nodes)
      str << "'>" + p_contents + '</p>'
      # puts str;puts
      if list_item || (styles & List.known_styles).any?
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
        add_list
        output << str
      end
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
  
    def run(node)
      run_text = extract_run_text(node)
      style = get_style(node)
      run_text = add_footnote_reference(run_text, node) if style == 'FootnoteReference' && !@opts[:ignore_footnotes]
      run_text.empty? ? nil : Docx2HTML::Run.new(run_text, style, @opts)
    end
    
    def add_footnote_reference(run_text, node)
      fn_id = node.css('footnoteReference').attribute('id')&.value
      unless fn_id
        puts Rainbow('Null FootnoteReference').lime
        return run_text
        # raise FootnoteError, "Can't find footnoteReference with id value"
      end
      ch = @chapter
      raise "No chapter" unless ch
      output = '<span id="chapter-' + ch + '-footnote-reference-' + fn_id + '">' + run_text + '<a href="chapter-' + ch + '-footnote-' + fn_id + '"><sup>' + fn_id + '</sup></a></span>'  
      # puts output
      output
    end
    
    def extract_run_text(node)
      run_text = ''
      texts = node.xpath('.//t | .//noBreakHyphen | .//br')
      texts.each do |t|
        if t.name == 'noBreakHyphen'
          run_text << '-'
        elsif t.name == 'br'
          run_text << "<br/>"
        else
          run_text << CGI.escapeHTML(t)
        end
      end
      run_text.html_entity_code_to_entity_number
    end
  
    def get_style(node)
      node.xpath('.//rStyle').attribute('val')&.value # should fail if multiple styles
    end
    
    def process_paragraph_contents(nodes, paragraph_opts = {})
      bucket = []
      nodes.each do |node|
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
      begin
        html = Docx2HTML::RunStyler.new.style(bucket, @opts.merge(paragraph_opts))
      rescue
        html = 'ERROR'
        puts nodes
        raise
      end
      # puts Rainbow(html).green
      html
    end
    
    def hyperlink(node)
      anchor_attr = node.attribute('anchor')
      anchor = anchor_attr ? anchor_attr.value : nil
      link_text = process_paragraph_contents(node.children, :suppress_links => true)
      anchor_attr ||= link_text
      if link_text.empty?
        puts Rainbow(node).cyan
        ret = nil
      else
        ret = Docx2HTML::LinkedRun.new(link_text, anchor, 'Hyperlink')
        # puts ret.inspect
      end
      # puts Rainbow(ret.text).yellow + "  #{anchor}"  + " -- #{link_text}" if ret
      ret
    end
          
  end # class Processor
end
