organizer(:Details, V2Web::Standard) do
  # button('test_generation', :label => 'Generate v2+ Standard -> ', :button_text => 'Test Me', :display_result => :web_page)
  # reorder('test_generation', :to_beginning => true)
  view_ref(:Summary, 'subsections', V2Web::Section, :label => 'Subsections')
  relabel('fhir_composition', 'Mapped FHIR Composition')
end

organizer(:Details, V2Web::Section) do
  # string('identifying_text', :label => 'Identifier', :disable => true)
  view_ref(:Summary, 'subsections', V2Web::Section, :label => 'Subsections')
  reorder('title', :to_beginning => true)
  relabel('fhir', 'FHIR')
  reorder('remarks', 'subsections', 'content', 'fhir', 'source', :to_end => true)
  reorder('identifying_text', :to_beginning => true)
end

collection(:Summary, V2Web::SubsectionContent) do
  string('identifying_text', :label => 'Identifier', :disable_search => true)
  order('identifying_text', :to_beginning => true)
end

organizer(:Details, V2Web::Table) do
  message('html_simple')
  reorder('html_simple', :to_beginning => true)
end
