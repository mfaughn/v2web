# NOTE this may need to be applied before every HTML site build because CKEditor appears to change it back to &hellip;
texts = V2Web::Text.all;
puts texts.count
texts.each do |t|
  next unless t.content_content =~ /&hellip;|…|&#8230;/
  puts "#{t.id}"
  next unless t.content_content =~ /&hellip;|…/
  puts "Changing"
  ChangeTracker.start
  t.content_content = t.content_content.gsub(/&hellip;|…/, '&#8230;')
  t.save
  ChangeTracker.commit
end

e = V2Web::Text[72376].content_content
puts e.inspect