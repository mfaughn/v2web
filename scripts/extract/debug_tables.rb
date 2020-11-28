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
          cell_content << extract_text(c)
          # cell_content << extract_p(c)
          # FIXME can't ignore footnotes in table cells but there is no way to store them in structure defs right now (especially true for MessageStructure)
          # cell_content << Docx2HTML::Processor.new(c, :ignore_footnotes => true).process
        when 'tcPr'
          begin
            result = extract_tcPr(c)
          rescue
            puts cell
            raise
          end
          cell_content << result if result
        else
          puts 'extract_tc ' + Rainbow(c.name.inspect).orange
          puts c.to_s;puts
        end
      end
      cell_content 
    end
    
    # this method only for extracting from tables where the contents are to be stored as unstyled data (i.e. in FHIR resource)
    def extract_raw_tc(cell)
      cell_content = ''
      cell.children.each do |c|
        case c.name
        when 'p'
          cell_content << extract_text(c)
          # cell_content << extract_p(c)
          # FIXME can't ignore footnotes in table cells but there is no way to store them in structure defs right now (especially true for MessageStructure)
          # cell_content << Docx2HTML::Processor.new(c, :ignore_footnotes => true).process
        when 'tcPr'
          # begin
          #   result = extract_tcPr(c)
          # rescue
          #   puts cell
          #   raise
          # end
          # cell_content << result if result
        else
          puts 'extract_tc ' + Rainbow(c.name.inspect).orange
          puts c.to_s;puts
        end
      end
      cell_content 
    end
    
    def extract_tcPr(node)
      result = ''
      node.children.each do |c|
        case c.name
        when 'tcBorders', 'tcMar'
          # ignore
        when 'tcW'
        when 'shd'
          # unless c.to_s == '<shd val="clear" color="auto" fill="FFFFFF"/>'
          #   puts Rainbow(c.to_s).cyan
          # end
        when 'textDirection'
          puts c.to_s unless c.to_s == '<textDirection val="btLr"/>'
        when 'hideMark'
          # see here: http://officeopenxml.com/WPhideMark.php
        when 'vAlign'
          # ignore for now since this method is just being used to pull values from tables
          # puts node;puts
        when 'gridSpan'
          # try to ignore but maybe this indicates a bad table.  first seen in Ch. 4 BPX and BTX
        else
          puts 'extract_tcPr ' + Rainbow(c.name).orange
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
