# NOTE this may need to be applied before every HTML site build because CKEditor appears to change it back to &hellip;
texts = V2Web::Text.all;
texts.each do |t|
  next unless t.content_content =~ /&lsquo;|&rsquo;|‘|’/
  puts "#{t.id}"
  ChangeTracker.start
  t.content_content = t.content_content.gsub(/&lsquo;|‘/, '&#8216;').gsub(/&rsquo;|’/, '&#8217;')
  t.save
  ChangeTracker.commit
end
