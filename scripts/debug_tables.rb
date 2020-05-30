module V2Web
  class DocXtractor
    def extract_tr(row)
      cells = row.children.select { |n| n.name == 'tc' }.map { |cell| extract_tc(cell) }
    end
    
    def extract_tc(cell)
      cell_content = ''
      cell.children.each do |c|
        case c.name
        when 'p'
          cell_content << extract_p(c)
        when 'tcPr'
          result = extract_tcPr(c)
          cell_content << result if result
        else
          puts Rainbow(c.name).orange
          puts c.to_s;puts
        end
      end
      cell_content 
    end
    
    def extract_tcPr(node)
      result = ''
      node.children.each do |c|
        case c.name
        when 'tcBorders'
        when 'tcW'
        when 'shd'
          # unless c.to_s == '<shd val="clear" color="auto" fill="FFFFFF"/>'
          #   puts Rainbow(c.to_s).cyan
          # end
        when 'textDirection'
          puts c.to_s unless c.to_s == '<textDirection val="btLr"/>'
        else
          puts Rainbow(c.name).orange
          puts c.to_s;puts
        end
      end
      result.empty? ? result : nil
    end
    
    def display_tbl(rows)
      puts Terminal::Table.new(:rows => rows)
      puts Rainbow('*'*20).magenta
    end
  end
end
