organizer(:Details, SDoc::Document) do
  # button('test_generation', :label => 'Generate v2+ Site -> ', :button_text => 'Test Me', :display_result => :web_page)
  # reorder('test_generation', :to_beginning => true)
  view_ref(:Summary, 'clauses', SDoc::Clause, :label => 'Clauses')
  relabel('fhir', 'Mapped FHIR Resource')
end

collection(:Summary, SDoc::ClauseContent) do
  string('identifying_text')
  order('identifying_text', :to_beginning => true)
end

organizer(:Details, SDoc::Clause) do
  view_ref(:Summary, 'subclauses', SDoc::Clause, :label => 'SubClauses')
  reorder('title', :to_beginning => true)
  hide('documents', 'containers')
  relabel('fhir', 'FHIR')
  relabel('groups', 'HL7 Site Groups')
  relabel('sections', 'HL7 Site Sections')
  reorder('remarks', 'subclauses', 'content', 'groups', 'sections', 'fhir', 'source', :to_end => true)
end

organizer(:Details, SDoc::Table) do
  message('html_simple')
  reorder('html_simple', :to_beginning => true)
end
