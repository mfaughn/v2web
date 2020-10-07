module V2Web
  module_function
  def adjust_cells(table)
    cells = table.rows.map { |r| r.cells }.flatten
    cells.each do |cell|
      cell.content.each do |item|
        next unless item.is_a?(V2Web::Text)
        html = item.content_content
        
        next unless html =~ /font-size/
        puts html;puts
        ChangeTracker.start
        item.content_content = html.sub('font-size:12px; ', '')
        # item.save
        ChangeTracker.commit
      end
    end
  end
  def center_columns(table, column_indices)
    tcols = table.cols
    column_indices.each do |i|
      ChangeTracker.start
      tcols[i].add_style('centered')
      tcols[i].save
      ChangeTracker.commit
    end
  end
  def remove_cell_spans
    V2Web::Table.each do |table|
      puts "***** #{table.caption} *****"
      cells = table.rows.map { |r| r.cells }.flatten
      cells.each do |cell|
        cell.content.each do |item|
          next unless item.is_a?(V2Web::Text)
          html = item.content_content
          spans = html.scan(/<span.*?>/)
          next unless spans.any?
          remove = []
          spans.each do |span|
            remove << span unless (span =~ /color/) && (span !~ /color:#000000/)
          end
          spanless = html.dup
          remove.each do |removal|
            # puts Rainbow(removal).yellow
            # m = /#{removal}(.+?)<\/span>/.match(spanless)
            # puts m.inspect
            spanless = spanless.gsub(/#{removal}(.+?)<\/span>/, '\1')
          end
          puts html
          puts Rainbow(spanless).yellow
          ChangeTracker.start
          item.content_content = spanless
          item.save
          ChangeTracker.commit
          item.refresh
          # puts html
          puts Rainbow(item.content_content).green
        end
      end
    end
  end
end
# tbl = V2Web::Table[1379]
# V2Web.adjust_cells(tbl)
# V2Web.center_columns(tbl, [0,1,2,3,4,5,6,7])
V2Web.remove_cell_spans
