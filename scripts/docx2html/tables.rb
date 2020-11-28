module Docx2HTML
  class Table
    PAGE_TWIPS = 9360.0
    
    attr_reader :tbl, :rows, :props, :twips, :col_widths, :chapter
    attr_accessor :html

    def initialize(tbl, opts = {})
      @chapter = opts[:chapter]
      @tbl     = tbl
      @opts    = opts
      @props   = tbl.css('tblPr')
      @border  = _tbl_borders(@props)
      @col_widths = tbl.css('tblGrid gridCol').map { |n| n['w'].to_i }
      @twips = calculate_twips(@col_widths)
      @rows  = extract_rows
      create_grid
      @html = ['<table class="v2">']
    end

    def process
      add_caption
      add_colgroup   
      rows.each_with_index { |row, i| html << process_row(row, i) }
      @html << '</table>'
      # html.each { |e| puts e.is_a?(String) ? e.class.name : Rainbow(e.class.name).red }
      @html = @html.join
      # puts Rainbow(html).magenta
      html
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
            row.html_props = extract_properties(c)
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
          paragraphs << Docx2HTML::Processor.new(c, @opts).process(:debug => true, :raw => true, :chapter => @chapter)
        when 'tcPr'
          html_props = extract_properties(c)
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
      start_tx = "<#{tx}"
      if html_props
        # puts Rainbow(html_props.inspect).orange
        props_str = html_props.map { |k,v| "#{k}='#{v}'" }.join(' ')
        start_tx << ' ' + props_str
      end
      start_tx << '>'
      cell_html = "#{start_tx}#{paragraphs.join}</#{tx}>"
      # puts Rainbow(cell_html.inspect).orange;puts
      cell_html
    end
    
    # <tcBorders>
    #   <top val="double" sz="4" space="0" color="auto"/>
    #   <left val="nil"/>
    #   <bottom val="single" sz="4" space="0" color="auto"/>
    #   <right val="nil"/>
    # </tcBorders>
    def extract_borders(node)
      style = ''
      hash = node2hash(node)
      # pp hash
      hash.each do |k, v|
        # pp v
        v.each do |k1, v1|
          next if v1 == 'nil'
          case k1
          when :val
            unless v1 == 'single'
              style << "border-#{k}-style:#{v1}; "
            end
          when :sz
            width = (v1.to_i+3)/4
            style << "border-#{k}-width:#{}px; " if width > 1
          when :color
            style << "border-#{k}-color:#{v1}; " unless v1 == 'auto'
          when :space
            puts "Border space is #{v1}" unless v1 == '0'
          else
            raise Rainbow(k.inspect).red
          end
        end
      end
      style
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
    
    def extract_properties(node)
      pr = node2hash(node)
      deletables = [:cantSplit, :vMerge, :tcBorders]
      deletables.each { |d| pr.delete(d) }
      # consolidations = {:trHeight => :val}
      # consolidations.each { |key, val| pr[key] = pr[key][val] if pr[key] }
      html_props = {}
      style = ''
      classes = []
  
      cell_borders = node.css('tcBorders').first
      if cell_borders
        style << extract_borders(cell_borders)
      end
    
      if pr[:tblHeader]
        # puts node
        classes << 'v2-table-header'
        pr.delete(:tblHeader)
      end
      if pr[:gridSpan]
        html_props['colspan'] = pr[:gridSpan][:val].to_s
        pr.delete(:gridSpan)
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
      if pr[:shd]
        pr['background-color'] = pr[:shd][:fill] if pr.dig(:shd, :fill) && !pr[:shd][:fill] == 'FFFFFF'
        style << "color:#{pr[:shd][:color]}; " if pr.dig(:shd, :color) && !pr[:shd][:color] == 'auto'
        puts Rainbow("Table cell pattern is #{pr[:shd][:val]}") if pr.dig(:shd, :val) && !pr[:shd][:val] == 'clear'
        pr.delete(:shd)
      end
      if pr[:tcW]
        style << "width:#{col_twips_to_percentage(pr[:tcW][:w])}; " if pr[:tcW][:w]
        puts Rainbow("Table cell width not dxa -- #{pr[:tcW][:type]}").orange unless pr.dig(:tcW, :type) == 'dxa'
        pr.delete(:tcW)
      end
      if pr[:vAlign]
        style << "vertical-align:#{pr[:vAlign][:val]}"
        pr.delete(:vAlign)
      end
      if pr[:tcMar]
        # ignore for now...
        pr.delete(:tcMar)
      end
      if pr[:hideMark]
        # ignore for now...
        pr.delete(:hideMark)
      end
      if pr[:wAfter]
        # ignore for now...
        pr.delete(:wAfter)
      end
      if pr[:gridAfter]
        # ignore for now...
        pr.delete(:gridAfter)
      end
      if pr[:textDirection]
        classes << 'rotate-text-270'
        pr.delete(:textDirection)
      end
      unprocessed_keys = pr.keys.select { |k| k.is_a?(Symbol) }
      unless unprocessed_keys.empty?
        puts Rainbow(unprocessed_keys).red 
        puts node
        raise
      end
      html_props['style'] = style unless style.empty?
      html_props['class'] = classes.join(' ') if classes.any?
      html_props
    end
  
    def _add_inline_style(property, value)
    end
  
    def _tbl_borders(node)
      borders = {}
      node.css('tblBorders').children.each do |b|
        borders[b.name.to_sym] = {}
        b.attributes.map do |name, battr|
          borders[b.name.to_sym][battr.name.to_sym] = battr.value
        end
      end
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
