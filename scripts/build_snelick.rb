def indicate_page_linkages(site)
  # TODO do something with all the content that isn't a Clause
  main_subsections = site.subsections
  main_subsections.each { |sect| link_section(sect, true) }
end

def link_section(sect, linked = false)
  ChangeTracker.start
  sect.render_as = 'linked_page' if linked
  sect.save
  ChangeTracker.commit
  sect.subsections.each { |ss| link_section(ss) }
end

conformance = V2Web::Standard.where(Sequel.ilike(:title, '%Conformance Methodology%')).last
indicate_page_linkages(conformance)
conformance.to_hl7_site

# datatypes   = V2Web::Standard.where(Sequel.ilike(:title, '%DataType Specializations%')).last
# indicate_page_linkages(datatypes)
# datatypes.to_hl7_site
