def delete_snelick
  Snelick.classes(:no_imports => true).each do |c|
    next unless c < Sequel::Model
    next if c.enumeration?
    if DB.tables.include?(c.table_name)
      c.delete
    end
  end
end
load File.join(__dir__, 'headers_hack.rb')
headers_hack
delete_snelick
conformance = SDoc::Document.where(Sequel.ilike(:title, '%Conformance Methodology%')).last
# datatypes   = SDoc::Document.where(Sequel.ilike(:title, '%DataType Specializations%')).last

ChangeTracker.start
csite = Snelick::Site.create(:name => 'Conformance Methodology R1 - September 2019')
csite.doc = conformance
csite.save
# dsite = Snelick::Site.create(:name => 'Data Type Speciailizations')
# dsite.doc = datatypes
# dsite.save
ChangeTracker.commit

def site_from_doc(site)
  # TODO do something with all the content that isn't a Clause
  main_clauses = site.doc.content.select { |c| c.is_a?(SDoc::Clause) }
  main_clauses.each { |clause| create_section(clause, site, true) }
end

def create_section(clause, parent_site_element, linked = false)
  # puts "#{doc.title} -- #{clause.title}"
  ChangeTracker.start
  section = Snelick::Section.create
  section.render_as = 'linked_page' if linked
  section.doc = clause
  section.save
  if parent_site_element.is_a?(Snelick::Site)
    parent_site_element.add_content(section)
  else
    parent_site_element.add_subsection(section)
  end
  ChangeTracker.commit
  clause.subclauses.each { |sc| create_section(sc, section) }
end

site_from_doc(csite)
csite.to_hl7_site
# site_from_doc(dsite)
# dsite.to_hl7_site
