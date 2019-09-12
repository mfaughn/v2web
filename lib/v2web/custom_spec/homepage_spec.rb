require_relative 'label_procs'
#Homepage
homepage_item :'V2Web::Site', :getter => 'sites'
homepage_item :'V2Web::Section', :getter => 'web_sections'
homepage_item :'V2Web::Box', :getter => 'boxes'
homepage_item :'V2Web::Table'
homepage_item :'V2Web::Text'
# homepage_item :'V2Web::Example'
# homepage_item :'V2Web::Note'
homepage_item :'V2Web::Code'
homepage_item :'V2Web::Figure'
homepage_item :'V2Web::List'
homepage_item :'FHIR::Composition'
homepage_item :'FHIR::Section', :getter => 'fhir_sections'
homepage_item :'FHIR::Narrative'
homepage_item :'HL7::Event', :getter => 'events'
homepage_item :'HL7::MessageDefinition', :getter => 'message_definitions'
homepage_item :'HL7::SegmentType', :getter => 'segment_definitions'
homepage_item :'HL7::DataType', :getter => 'data_types'
homepage_item :'HL7::Component', :getter => 'components'
homepage_item :'HL7::ValueSet', :getter => 'value_sets'
homepage_item :'HL7::Value', :getter => 'values'

organizer(:Details, Home) {
  html(:label => 'hl7_section', :html => V2Web::HL7_SECTION_LABEL)
  # html(:label => 'hl7v2link', :html => V2Web::HL7_LINK_LABEL)
  view_ref(:Summary, 'events', :label => 'Events')
  view_ref(:Summary, 'message_definitions', :label => 'Message Definitions')
  view_ref(:Summary, 'segment_definitions', :label => 'Segment Definitions')
  view_ref(:Summary, 'data_types', :label => 'Data Type Definitions')
  view_ref(:Summary, 'components', :label => 'Data Type Components')
  view_ref(:Summary, 'value_sets', :label => 'Value Sets')
  view_ref(:Summary, 'values',     :label => 'Value Set Values')
  html(:label => 'websites_section', :html => V2Web::WEBSITES_LABEL)
  view_ref(:Summary, 'sites',      :label => 'Website Specifications')
  view_ref(:Summary, 'web_sections',   :label => 'Sections')
  view_ref(:Summary, 'boxes',      :label => 'Boxes')
  view_ref(:Summary, 'figures',    :label => 'Figures')
  view_ref(:Summary, 'tables',     :label => 'Tables')
  view_ref(:Summary, 'lists',      :label => 'Lists')
  view_ref(:Summary, 'codes',      :label => 'Code Snippets')
  view_ref(:Summary, 'texts',      :label => 'Text Sections')  
  html(:label => 'fhir_link', :html => V2Web::FHIR_LINK_LABEL)
  view_ref(:Summary, 'compositions',            :label => 'Composition Resources')
  view_ref(:Summary, 'fhir_sections',                :label => 'Sections')
  view_ref(:Summary, 'narratives',              :label => 'Narratives')
  # reorder(:to_beginning => true)
  reorder('fhir_link', 'compositions', 'sections', 'narratives', :to_end => true)
}
