require 'cgi'
require 'loofah'
module V2Web
  class Table
    def all_texts
      # Assumes that all cell content is Text objects
      rows.map(&:cells).flatten.map(&:content).flatten.select { |item| item.is_a?(V2Web::Text) }
    end
    # 1440 twips = 1 inch
    # max width of table on page (inside margins) is 6.5 inch = 9360twips
    def to_hl7_site(_ = nil)
      html_caption = caption && !caption.strip.empty? ? V2Web.htmlize(caption) : nil
      headers, data_rows = rows.partition { |r| r.header }
      headers = headers.map { |r| r.to_hl7_site(_col_styles, r.header) }.join("\n")
      body =  data_rows.map { |r| r.to_hl7_site(_col_styles, r.header) }.join("\n")
      # locals = { :content => html.join("\n"), :column_widths => _col_widths, :styles => "width: #{width || 'auto'};", :table_id => html_id }
      locals = { :headers => headers, :body => body, :column_widths => _col_widths, :styles => "width: #{width || 'auto'};", :table_id => html_id , :caption => html_caption}
      locals[:classes] = styles.map(&:value).join(' ')
      # puts locals[:classes] unless locals[:classes]&.empty?
      html = V2Web.render_with_locals(:table, locals)
      # if title =~ /Table 5\.12/
      #   puts html
      # end
      html
    end
    
    def html_id
      "v2web_table-#{id}"
    end
    
    def _col_widths
      widths = []
      cols.each { |col| widths << col.width }
      widths.compact.any? ? widths : nil
    end
    
    def _col_styles
      col_styles = {}
      cols.each_with_index { |col, i| col_styles[i] = col.styles }
      col_styles
    end
    
    def to_v2_html_test(_ = nil)
      to_hl7_site
    end

    derived_attribute(:title, ::String)
    alias_method :title, :caption
    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      if caption
        caption
      else
        header_row_simple
      end
    end
    
    def to_html
      html_simple
    end
    
    derived_attribute :html_simple, String
    def html_simple
      html = []
      html << '<table>' # style="width:100%"
      html << "<caption>#{caption.hl7}</caption>" if caption
      rows.each_with_index do |row, index|
        # Hack to get rid of empty rows
        cell_check = row.cells.map(&:html_content).join.strip
        puts "Cell Check: #{cell_check.inspect}"
        next if cell_check.empty?
        cell_type = (index == 0 && caption && !caption.empty?) ? 'th' : 'td'
        html << '<tr>'
        row.cells.each do |cell|
          html << "<#{cell_type}>#{cell.html_content}</#{cell_type}>"
        end
        html << '</tr>'
      end
      html << '</table>'
      html = html.join("\n").strip
      puts html
      html
    end
    
    def header_row_simple
      html = []
      rows.first.cells.each do |cell|
        html << Loofah.fragment(cell.html_content).scrub!(:prune).text
      end
      puts html
      'Table: ' + html.join(" | ")[0..50]
    end
    
    def num_cols
      rows.map(&:cells_count).sort.last
    end
    
    def matrix
      num_rows = rows.count
      matrix = Array.new(num_rows) {Array.new(num_cols)}
      seen_cells = []
      rows.each_with_index do |r, ri|
        r.cells.each_with_index do |c, ci|
          rs = (c.rowspan || 1)
          # puts "rs = #{rs}"
          rs.times do |xrep|
            x = ri + xrep
            cs = (c.colspan || 1)
            # puts "cs = #{cs}"
            cs.times do |yrep|
              y = ci + yrep
              next_empty = matrix[x].index(nil)
              # pp matrix
              # puts Rainbow("#{x},#{y} -> doing #{x}, #{next_empty}").green
              if seen_cells.include?(c.id)
                matrix[x][next_empty] = 0
              else
                matrix[x][next_empty] = c.id
                seen_cells << c.id
              end
              # puts Rainbow(matrix[x][next_empty].inspect).cyan
              # pp matrix; puts '*'*11
            end
          end
        end
      end
      matrix
    end
    
    def col_data(col_num, include_header = false)
      _col_data(matrix, col_num, include_header)
    end
    
    def _col_data(mtrx, col_num, include_header = false)
      cell_ids = mtrx.map { |row| row[col_num -1] }
      cells    = cell_ids.map { |cid| V2Web::Cell[cid] }.compact
      ids      = []
      content  = []
      cells.each do |cell|
        next if cell.row&.header && !include_header
        ids << cell.id
        content << cell.html_content
      end
      { :content => content, :ids => ids }
    end
    
    def col_content(col_num, include_header = false)
      col_data(col_num, include_header)[:content]
    end
        
  end
  
  class Row
    def to_hl7_site(col_styles, header = false)
      content = []
      cells.each_with_index { |c, i| content << c.to_hl7_site(col_styles[i], header) }
      locals = {:content => content.join("\n"), :styles => '', :classes =>  styles.map(&:value).join(' ')}
      V2Web.render_with_locals(:tr, locals)
    end
    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      cells.map { |c| c.html_content }.inspect
    end
  end
  
  class Cell
    def to_hl7_site(col_styles, header = false)
      tag = header ? :th : :td
      locals = {:content => content.map { |c| c.to_hl7_site(self) }.join("\n") }
      # TODO add rowstyles too
      locals[:classes] = (col_styles + styles).map(&:value).join(' ')
      locals[:colspan] = colspan.to_i > 1 ? colspan : nil
      locals[:rowspan] = rowspan.to_i > 1 ? rowspan : nil
      V2Web.render_with_locals(tag, locals)
    end
    
    derived_attribute(:html_content, ::String)
    derived_attribute(:identifying_text, ::String)
    def html_content
      content.map { |c| c.to_html }.join("\n")
    end
    alias_method :identifying_text, :html_content
  end
end
# def td2
#   data = {:caption => caption, :cols => num_cols}
#   rowspan_buffer = {}
#   (1..num_cols).each { |n| rowspan_buffer[n] = 1 }
#   rows.each_with_index do |row, row_index|
#     data[row_index + 1] = {:header => row.header, :id => row.id}
#     col_counter = 0
#     colspan_buffer = 0
#     pp rowspan_buffer
#     row.cells.each do |cell|
#       col_counter += 1
#       puts "#{(row_index + 1)} -- #{col_counter}"
#       if rowspan_buffer[col_counter] > 1
#         rowspan_buffer[col_counter] -= 1
#         col_counter += 1
#       else
#         rowspan_buffer[col_counter] = cell.rowspan || 1
#       end
#
#       if colspan_buffer > 0
#         colspan_buffer -= 1
#         next
#       end
#
#       cspan = cell.colspan || 1
#       data[row_index + 1][col_counter] = {:id => cell.id, :colspan => cspan, :rowspan => cell.rowspan || 1, :content => cell.html_content}
#       colspan_buffer = colspan_buffer + (cspan - 1)
#     end
#   end
#   data
# end

# def row_data
#   table_data.select { |k,_| k.is_a?(Integer) }
# end