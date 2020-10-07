def smash_styles(table)
  table.rows.each do |r|
    r.cells.each do |c|
      stylz = c.styles.map(&:value)
      if stylz.include?('emphasis-column')
        ChangeTracker.start
        c.remove_all_styles
        c.save
        ChangeTracker.commit
      end
    end
  end
end

(1403..1414).to_a.each { |n|
  t = V2Web::Table[n]
  smash_styles(t)
  ChangeTracker.start
  t.add_style('striped-rows')
  t.save
  ChangeTracker.commit
}
