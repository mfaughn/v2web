module Docx2HTML
  class Table
    # 1440 twips = 1 inch = 96 pixels
    # 15 twips   = 1 pixel
    # page is 6.5 inches b/w margins
    PAGE_TWIPS = 9360.0 unless const_defined?('PAGE_TWIPS')
    
    attr_reader :tbl, :rows, :props, :twips, :col_widths, :chapter
    attr_accessor :html

    def initialize(tbl, opts = {})
      # pp opts.reject { |k,v| [:links, :images, :embeds, :image_substitutions].include?(k) };puts
      @chapter = opts[:chapter]
      @tbl     = tbl
      @opts    = opts
      @props   = tbl.css('tblPr')
      @col_widths = tbl.css('tblGrid gridCol').map { |n| n['w'].to_i }
      @twips = calculate_twips(@col_widths)
      @global_cell_borders = global_cell_borders(@props)
      @rows  = extract_rows
      create_grid
      @html = []
    end

    def process
      t_borders = tbl_borders(@props)
      start = '<table class="v2"'
      tbl_width
      start << ' style="width: ' + tbl_width.to_s + '%; '  
      start << t_borders if t_borders
      start << '">'
      @html << start
      # puts Rainbow(html.join).magenta if t_borders
      
      add_caption
      add_colgroup   
      rows.each_with_index { |row, i| html << process_row(row, i) }
      @html << '</table><br/>'
      # html.each { |e| puts e.is_a?(String) ? e.class.name : Rainbow(e.class.name).red }
      @html = @html.join
      html
    end
    
    def tbl_width
      w = ((@col_widths.reduce(&:+)/PAGE_TWIPS) * 100).ceil
      w > 100 ? 100 : w
    end
    
    def add_caption
      caption = @opts[:caption]
      return unless caption
      @html << "<caption>#{caption}</caption>"
    end
          
    def extract_rows
      rows = []
      xml_rows = tbl.css('tr')
      xml_rows.each do |tr|
        row = Row.new
        # row.xml = tr.children
        rows << row
        html_props  = nil
        other = []
        tr.children.each do |c|
          case c.name
          when 'tc'
            row.xml_cells << c
          when 'trPr'
            row.html_props = extract_row_properties(c)
          when 'bookmarkStart', 'bookmarkEnd'
            # ignore
          when 'tblPrEx'
            # ignore for now...found in Ch. 7 first
          else
            other << c
          end
        end
        if other.any?
          puts other
          raise "Unknown elements in tr"
        end
      end
      rows
    end
  
    def create_grid
      # return unless tbl.at('p:contains("Entered by user")')
      col_skips = col_widths.map { nil }
      rows.each_with_index do |row, i|
        row_offset = 0
        row.xml_cells.each_with_index do |tc, j|
          this_cell = Cell.new
          this_cell.xml = tc.children
          row.cells << this_cell
          cell_props = tc.css('tcPr')
          vmerge = cell_props.css('vMerge')
          if vmerge.any?
            restart = vmerge.attribute('val')&.value == 'restart'
            if restart
              col_skips[j] = this_cell
            else
              col_skips[j].colspan += 1
              this_cell.blank = true
            end
          end
          gridspan = cell_props.css('gridSpan')
          this_cell.rowspan = gridspan.attribute('val').value.to_i if gridspan.any?
        end
      end
      # rows.each do |r|
      #   # puts r.inspect
      #   begin
      #     txt = r.cells.map do |c|
      #       str = c.blank ? '    ' : "#{c.colspan} #{c.rowspan} "
      #       (c.rowspan - 1).times { str << '     ' }
      #       str << '|'
      #     end.join
      #   rescue
      #     puts r
      #     raise
      #   end
      #   puts txt
      # end
      # puts '='*33
      rows
    end
    
    def add_colgroup
      html << '<colgroup>'
      col_width_percentages(col_widths).each do |percentage|
        html << "<col span='1' style='width: #{percentage};'/>"
      end
      html << '</colgroup>'
    end
  
    def process_row(row, index)
      start_tr = '<tr'
      if row.html_props.any?
        # puts Rainbow(row.html_props.inspect).orange if row.html_props.any?
        start_tr << ' '
        row.html_props.each { |k, v| start_tr << "#{k}='#{v}'".strip }
      end
      start_tr << '>'
      row_html =  ["#{start_tr}" ]
      row.cells.each { |c| row_html << process_cell(c, index == 0) }
      row_html << '</tr>'
      row_html.join
    end
    
    def process_cell(cell, first = false)
      html_props = nil
      paragraphs = []
      other = []
      cell.xml.each do |c|
        case c.name
        when 'p'
          pg = Docx2HTML::Processor.new(c, @opts).process(:debug => true, :raw => true, :chapter => @chapter)
          # puts pg;puts
          paragraphs << pg
        when 'tcPr'
          html_props = extract_cell_properties(c)
          # puts "html_props"
          # pp html_props
        when 'bookmarkEnd'
          # do nothing
        else
          other << c
        end
      end
      if other.any?
        puts other
        raise "Unknown elements in tc"
      end
      tx = first ? 'th' : 'td'
      tx = 'td'
      start_tx = "<#{tx}"
      if html_props
        # puts Rainbow(html_props.inspect).orange
        # puts Rainbow(@global_cell_borders).cyan
        props_str = html_props.map { |k,v| "#{k}='#{v}'" }.join(' ')
        start_tx << ' ' + props_str
      end
      start_tx << '>'
      cell_html = "#{start_tx}#{paragraphs.join}</#{tx}>"
      # puts Rainbow(cell_html.inspect).orange;puts
      cell_html
    end
    
    def extract_tc_borders(cell_node)
      borders_hash = @global_cell_borders.dup
      borders_node = cell_node.at_css('tcBorders')
      borders_hash.merge!(node2hash(borders_node)) if borders_node
      # pp hash
      cell_style = []
      borders_hash.each do |edge, data|
        cell_style << tc_border(edge, data)
      end
      cell_style.any? ? cell_style.join : nil
    end
  
    def node2hash(node)
      pr = {}
      node.children.each do |child_node|
        pr[child_node.name.to_sym] = {}
        child_node.attributes.each do |name, attribute|
          pr[child_node.name.to_sym][attribute.name.to_sym] = attribute.value
        end
      end
      pr
    end
    
    def extract_cell_properties(node)
      html_props = {}
      style = ''
      classes = []
      
      cell_borders = extract_tc_borders(node)
      style << cell_borders if cell_borders

      tcPr = node2hash(node)
      deletables = [:cantSplit, :vMerge, :tcBorders]
      deletables.each { |d| tcPr.delete(d) }

      if tcPr[:gridSpan]
        html_props['colspan'] = tcPr[:gridSpan][:val].to_s
        tcPr.delete(:gridSpan)
      end
      if tcPr[:shd]
        if tcPr.dig(:shd, :fill)
          shdval = tcPr[:shd][:val]
          fill   = tcPr[:shd][:fill]
          if fill == 'FFFFFF'
            case shdval
            when 'nil'
              # do nothing
            when 'pct10'
              style << "background-color: #E6E6E6; "
            else
              "What to do with grey shade val of #{shdval}?"
            end
          else
            case shdval
            when 'nil', 'clear'
              style << "background-color:##{fill}; "
              # do nothing
            when 'pct10'
              style << "background-color:#E1E1E1; "
            when 'pct20'
              style << "background-color:#CDCDCD; "
            when 'pct50'
              style << "background-color:gray; "
            when 'diagStripe'
              style << "background-color:#708090; " # replacing with slate gray for now
              classes << 'stippled-gray-background' # maybe we can do something with this later...?
            else
              puts "What to do with non-grey shade val of #{tcPr[:shd][:val]}?"
            end
          end
        end
        # tcPr['background-color'] = tcPr[:shd][:fill] if tcPr.dig(:shd, :fill) && !tcPr[:shd][:fill] == 'FFFFFF'
        style << "color:#{tcPr[:shd][:color]}; " if tcPr.dig(:shd, :color) && !tcPr[:shd][:color] == 'auto'
        puts Rainbow("Table cell pattern is #{tcPr[:shd][:val]}") if tcPr.dig(:shd, :val) && !tcPr[:shd][:val] == 'clear'
        tcPr.delete(:shd)
      end
      if tcPr[:tcW]
        style << "width:#{col_twips_to_percentage(tcPr[:tcW][:w])}; " if tcPr[:tcW][:w]
        puts Rainbow("Table cell width not dxa -- #{tcPr[:tcW][:type]}").orange unless tcPr.dig(:tcW, :type) == 'dxa'
        tcPr.delete(:tcW)
      end
      if tcPr[:vAlign]
        style << "vertical-align:#{tcPr[:vAlign][:val]}"
        tcPr.delete(:vAlign)
      end
      if tcPr[:tcMar]
        # ignore for now...
        tcPr.delete(:tcMar)
      end
      if tcPr[:hideMark]
        # ignore for now...
        tcPr.delete(:hideMark)
      end
      if tcPr[:textDirection]
        classes << 'rotate-text-270'
        tcPr.delete(:textDirection)
      end
      unprocessed_keys = tcPr.keys.select { |k| k.is_a?(Symbol) }
      unless unprocessed_keys.empty?
        puts 'Unprocessed tcPr keys ' + Rainbow(unprocessed_keys).red 
        puts node
        raise
      end
      html_props['style'] = style unless style.empty?
      html_props['class'] = classes.join(' ') if classes.any?
      # pp html_props
      html_props
    end

    def extract_row_properties(node)
      pr = node2hash(node)
      deletables = [:cantSplit]
      deletables.each { |d| pr.delete(d) }
      # consolidations = {:trHeight => :val}
      # consolidations.each { |key, val| pr[key] = pr[key][val] if pr[key] }
      html_props = {}
      style = ''
      classes = []

      if pr[:tblHeader]
        # puts node
        classes << 'v2-table-header'
        pr.delete(:tblHeader)
      end
      if pr[:jc]
        # TODO do we need to do anything for this?
        puts Rainbow("jc is #{pr[:jc][:val]}").orange unless pr[:jc][:val] == 'center'
        pr.delete(:jc)
      end
      if pr[:trHeight]
        # pr['height'] = pr[:trHeight][:val] if pr.dig(:trHeight, :val) # FIXME OOXML spec says this value is twentieths of a point but vals from docx are way too small for this to be correct.  Omitting due to discrepency
        pr.delete(:trHeight)
      end
      if pr[:wAfter]
        # ignore for now...
        pr.delete(:wAfter)
      end
      if pr[:gridAfter]
        # ignore for now...
        pr.delete(:gridAfter)
      end
      if pr[:tblCellSpacing]
        # can we ignore????
        pr.delete(:tblCellSpacing)
      end
      if pr[:trPrChange]
        # can we ignore????
        pr.delete(:trPrChange)
      end
      if pr[:textDirection]
        classes << 'rotate-text-270'
        pr.delete(:textDirection)
      end
      unprocessed_keys = pr.keys.select { |k| k.is_a?(Symbol) }
      unless unprocessed_keys.empty?
        puts 'Unprocessed trPr keys ' + Rainbow(unprocessed_keys).red 
        puts node
        raise
      end
      html_props['style'] = style unless style.empty?
      html_props['class'] = classes.join(' ') if classes.any?
      # pp html_props
      html_props
    end

    def tbl_borders(node)
      borders_node = node.at_css('tblBorders')
      return nil unless borders_node
      hash = node2hash(borders_node).select { |edge,_| %i{top bottom left right}.include?(edge) }
      border_style = []
      hash.each do |edge, data|
        border_style << tbl_border(edge, data)
      end
      border_style.any? ? border_style.join : nil
    end
    
    def global_cell_borders(node)
      borders_node = node.at_css('tblBorders')
      return {} unless borders_node
      all_borders = node2hash(borders_node)
      gcb = {}
      if all_borders[:insideH]
        gcb[:top]    = all_borders[:insideH]
        gcb[:bottom] = all_borders[:insideH]
      end
      if all_borders[:insideV]
        gcb[:right] = all_borders[:insideV]
        gcb[:left]  = all_borders[:insideV]
      end
      gcb
    end
    
    def tbl_border(edge, data)
      sz = data[:sz]
      width  = sz ? (sz.to_i+3)/4 : 1
      border = "border-#{edge}: #{width}px "
      style = data[:val]
      if style && style != 'nil' && style != 'single'
        puts Rainbow("Cell border style is #{style}").red unless style == 'double'
        border << "#{style} "
      else
        border << 'solid '
      end
      color = data[:color]
      if color && color != 'auto'
        border << color
      else
        border << 'black'
      end
      border << '; '
      # pp v
      data.each do |k, v|
        case k
        when :val, :sz, :color
        when :space
          puts "Table border space is #{v}" unless v == '0'
        else
          raise Rainbow(k.inspect).red
        end
      end
      border    
    end
    
    def tc_border(edge, data)
      style = data[:val]
      return "border-#{edge}:none; " if style == 'nil'
      sz    = data[:sz]
      puts "Border size is #{sz}" if sz.to_i > 6
      width = sz ? (sz.to_i+5)/6 : 1        
      border = "border-#{edge}: #{width}px "
      if style && style != 'single'
        puts Rainbow("Cell border style is #{style}").red unless style == 'double'
        border << "#{style} "
      else
        border << 'solid '
      end
      color = data[:color]
      if color && color != 'auto' && color != '000000'
        border << "##{color}; "
      else
        border << "black; "
      end
      # pp v
      data.each do |k, v|
        case k
        when :val, :sz, :color
        when :space
          puts "Cell border space is #{v}" unless v == '0'
        else
          raise Rainbow(k.inspect).red
        end
      end
      border
    end
    
    def col_width_percentages(cols)
      # 1440 twips = 1 inch
      # max width of table on page (inside margins) is 6.5 inch = 9360twips
      cols.map { |cw| col_twips_to_percentage(cw) }
    end
  
    def calculate_twips(cols)
      cols.reduce(:+).to_f
    end
    
    def table_width
     "#{(twips / PAGE_TWIPS) * 100.0}%".gsub(/(\d+\.\d\d).*%/, '\1%')
    end
  
    def col_twips_to_percentage(w)
      # puts "#{w} - #{twips}"
      "#{(w.to_i / twips) * 100.0}%".gsub(/(\d+\.\d\d).*%/, '\1%')
    end
  end
  
  class Row
    attr_accessor :cells, :html_props, :xml_cells
    def initialize
      @cells   = []
      @xml_cells = []
      # @classes = []
      # @style   = ''
      @html_props = {}
    end
  end
  
  class Cell
    attr_accessor :rowspan, :colspan, :content, :classes, :style, :xml, :blank
    def initialize
      @rowspan = 1
      @colspan = 1
      @content = ''
      @classes = []
      @style = ''
    end
  end
end
