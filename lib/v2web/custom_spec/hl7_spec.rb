collection(:Summary, HL7::DataType) do
  order('abbreviation', 'name', 'definition', 'withdrawn', :to_beginning => true)
  # hide(html_source) # FIXME crashes page when this is on...WTF?!?!?!
end

collection(:Summary, HL7::SegmentDefinition) do
  order('abbreviation', 'name', 'description', 'withdrawn', 'origin', :to_beginning => true)
  hide('source')
  relabel('origin', 'From Chapter')
end
