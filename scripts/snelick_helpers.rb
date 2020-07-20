def indicate_page_linkages(site)
  # TODO do something with all the content that isn't a Clause
  main_subsections = site&.subsections || []
  main_subsections.each { |sect| link_section(sect, true) }
end

def link_section(sect, linked = false)
  ChangeTracker.start
  sect.render_as = 'linked_page' if linked
  sect.save
  ChangeTracker.commit
  sect.subsections.each { |ss| link_section(ss) }
end