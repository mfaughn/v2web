organizer(:Details, Snelick::Section) do
  string('identifying_text', :label => 'Identifier', :disable => true)
  reorder('identifying_text', :to_beginning => true)
end

collection(:Summary, Snelick::Subsection) do
  string('identifying_text', :label => 'Identifier', :disable_search => true)
  reorder('identifying_text', :to_beginning => true)
end
