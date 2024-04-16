collection(:Summary, HL7::V2::DataType) do
  order('code', 'name', 'definition', 'withdrawn', :to_beginning => true)
  # hide(html_source) # FIXME crashes page when this is on...WTF?!?!?!
end

collection(:Summary, HL7::V2::SegmentDefinition) do
  order('code', 'name', 'description', 'withdrawn', 'origin', :to_beginning => true)
  hide('source')
  relabel('origin', 'From Chapter')
end

organizer(:Details, HL7::V2::Message) do
  order('code', 'name', 'description', 'withdrawn', 'origin', :to_beginning => true)
  hide('source')
  relabel('origin', 'From Chapter')
end

collection(:Summary, HL7::V2::Referenceable) do
  string('name', :label => 'Name')#, :disable_search => true)
  relabel('ref', 'V2 Element')
  hide('cell', 'boxes', 'footnotes', 'tab', 'list')
end

organizer(:Details, HL7::V2::Referenceable) do
  relabel('ref', 'V2 Element')
  relabel('parents', 'Publication Elements that Reference V2 Element')
  hide('cell', 'boxes', 'footnotes', 'tab', 'list')
end
