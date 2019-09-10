def headers_hack_strings
  [
    'Conformance Co-chair: Principle Author',
    'Craig Newman'
  ]
end

def headers_hack
  V2Web::Row.where(:header => true).all.each do |row|
    row_text = row.cells.first.content.first.content_content
    headers_hack_strings.each do |str|
      if row_text =~ /#{str}/
        ChangeTracker.start
        row.header = false
        row.save
        ChangeTracker.commit
        break
      end
    end
  end
end
