collection(:Summary, HL7::DataType) do
  order('code', 'name', 'definition', 'withdrawn', :to_beginning => true)
  # hide(html_source) # FIXME crashes page when this is on...WTF?!?!?!
end

collection(:Summary, HL7::SegmentDefinition) do
  order('code', 'name', 'description', 'withdrawn', 'origin', :to_beginning => true)
  hide('source')
  relabel('origin', 'From Chapter')
end

organizer(:Details, HL7::Message) do
  order('code', 'name', 'description', 'withdrawn', 'origin', :to_beginning => true)
  hide('source')
  relabel('origin', 'From Chapter')
end
