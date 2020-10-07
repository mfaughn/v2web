module V2Web  
  module_function
  PAGE_TWIPS = 9360.0
  def add_table_widths
    # 1440 twips = 1 inch
    # max width of table on page (inside margins) is 6.5 inch = 9360twips
    V2Web::Table.each do |tbl|
      cwidths = tbl.ooxml_content.scan(/(?<=gridCol w=")\d+(?=")/).map(&:to_f)
      unless cwidths.count == tbl.cols.count
        puts Rainbow("Column count differs").red
        next
      end
      table_twips = cwidths.reduce(:+).to_f
      twp  = "#{(table_twips / PAGE_TWIPS) * 100.0}%".gsub(/(\d+\.\d\d).*%/, '\1%')
      cwps = cwidths.map { |cw| "#{(cw / table_twips) * 100.0}%".gsub(/(\d+\.\d\d).*%/, '\1%') }
      puts "#{tbl.caption}:"
      puts "  #{cwidths} = #{table_twips}"
      puts "  #{table_twips}: #{twp}"
      puts "  #{cwps}"
      puts
      ChangeTracker.start
      tbl.width = twp
      tbl.save
      tbl.cols.each_with_index do |col, i|
        col.width = cwps[i]
        col.save
      end
      ChangeTracker.commit
    end
  end
end
V2Web.add_table_widths;