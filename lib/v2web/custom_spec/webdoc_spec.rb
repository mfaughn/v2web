# collection(:Summary, WebDoc::Level) do
#   string('identifying_text')
#   order('identifying_text', :to_beginning => true)
# end

organizer(:Details, WebDoc::Level) do
  # string('identifying_text', :label => 'Level For', :disabled => true)
  # order('identifying_text', :to_beginning => true)
  hide('homepage')
end

collection(:Summary, WebDoc::LevelGroup) do
  string('identifying_text')
  order('identifying_text', :to_beginning => true)
end

organizer(:Details, WebDoc::LevelGroup) do
  string('identifying_text', :label => 'Group For', :disabled => true)
  order('identifying_text', :to_beginning => true)
  hide('level')
  relabel('doc', 'Linked Document Content')
end

collection(:Summary, WebDoc::Section) do
  string('identifying_text')
  order('identifying_text', :to_beginning => true)
end

organizer(:Details, WebDoc::Section) do
  string('identifying_text', :label => 'Section For', :disabled => true)
  order('identifying_text', :to_beginning => true)
  hide('containers')
  relabel('doc', 'Linked Document Content')
end
