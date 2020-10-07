texts = V2Web::Text.all.select { |t| t.content.content =~ /<span style="font-size:12px; font-family:Courier New,Courier,monospace">(\s+)(\S+)<\/span>/ };

texts.each do |t|
  tc = t.content_content
  m = /<span style="font-size:12px; font-family:Courier New,Courier,monospace">(\s+)(\S+)<\/span>/.match(tc)
  space = m[1].gsub(/\s/, '&nbsp;')
  puts tc
  newtc = '<span style="font-size:12px; font-family:Courier New,Courier,monospace">' + space + m[2] + '</span>'
  puts newtc
  ChangeTracker.start
  t.content_content = newtc
  t.save
  # puts '<span style=\"font-size:12px; font-family:Courier New,Courier,monospace\">' + space + m[2] + '<\/span>'
  # puts
  # puts t.content.content
  ChangeTracker.commit
  t.refresh
  puts t.content_content
  puts
end;