organizer(:Details, V2Web::Section) do
  # string('identifying_text', :label => 'Identifier', :disable => true)
  view_ref(:Summary, 'subsections', V2Web::Section, :label => 'Subsections')
  reorder('title', :to_beginning => true)
  relabel('fhir_composition', 'FHIR Composition')
  relabel('fhir', 'FHIR Section (backbone element)')
  relabel('parents', 'Parent Section(s)')
  reorder('remarks', 'subsections', 'content', 'parents', 'fhir_composition', 'fhir', 'original', 'ooxml', :to_end => true)
  reorder('title', 'version', 'rendering_as', :to_beginning => true)
end
organizer(:Details, V2Web::Standard) do
  inherits_from_spec(:Details, V2Web::Section)
  hide('ooxml')
  reorder('remarks', 'subsections', 'content', 'parents', 'fhir_composition', 'fhir', 'original', 'ooxml', :to_end => true)
  reorder('title', 'version', 'rendering_as', :to_beginning => true)
end

collection(:Summary, V2Web::SubsectionContent) do
  string('identifying_text', :label => 'Identifier', :disable_search => true)
  order('identifying_text', :to_beginning => true)
end

# TODO make a collection of all the possible containers and show that (read-only)
organizer(:Details, V2Web::Table) do
  hide('title', 'xref', 'source_file', 'boxes', 'list', 'cell', 'tab')
  relabel('fhir', 'FHIR Section')
  # message('html_simple')
  # reorder('html_simple', :to_beginning => true)
  reorder('caption', 'style', 'cols', 'rows', :to_beginning => true)
  reorder('ooxml', 'rendering_as', :to_end => true)
end

collection(:Summary, V2Web::Cell) do
  string('identifying_text', :label => 'Content', :disable_search => true)
  order('identifying_text', :to_beginning => true)
end

collection(:Summary, V2Web::Row) do
  string('identifying_text', :label => 'Content', :disable_search => true)
  order('identifying_text', :to_beginning => true)
end
