def empty_sections_hack
  # eids = []
  tids = []
  V2Web::Section.all.each do |s|
    # eids << s if s.content.empty?
    tids << s unless s.title[0]
  end
  ChangeTracker.start
  tids.each do |t|
    t.delete
  end
  ChangeTracker.commit
end
