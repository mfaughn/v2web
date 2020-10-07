# tbls = V2Web::Table.all
tbls = V2Web::Table[1384]

def center_cols(tbls)
  tbls = [tbls].flatten
  tbls.each do |tbl|
    print Rainbow("Do \"#{tbl.caption}\" ?>").green
    input = gets.chomp
    next unless input.downcase == 'y'
    mtrx = tbl.matrix  
    tbl.num_cols.times do |i|
      col_num = i + 1
      data = tbl._col_data(mtrx, col_num)
      puts data[:content]
      print "Center column #{col_num} ?>"
      input = gets.chomp
      if input.downcase == 'y'
        ChangeTracker.start
        data[:ids].each do |id|
          cell = V2Web::Cell[id]
          cell.add_style('centered')
          cell.save
        end
        ChangeTracker.commit
      elsif input.downcase == 'remove'
        ChangeTracker.start
        data[:ids].each do |id|
          cell = V2Web::Cell[id]
          centered = V2Web::Style.where(value:'centered').first
          cell.remove_style(centered)
          cell.save
        end
        ChangeTracker.commit
      else
      end
    end
  end
end
center_cols tbls

#  5.16 is still a weird one

