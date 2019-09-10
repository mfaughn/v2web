require_relative 'label_procs'
#Homepage
homepage_item :'SDoc::Document'
homepage_item :'SDoc::Clause'
homepage_item :'SDoc::Abbreviation'
homepage_item :'SDoc::Definition'
homepage_item :'SDoc::NormativeReference', :getter => 'normative_references'
homepage_item :'SDoc::Table'
homepage_item :'SDoc::Text'
homepage_item :'SDoc::Example'
homepage_item :'SDoc::Note'
homepage_item :'SDoc::Code'
homepage_item :'SDoc::Figure'
homepage_item :'SDoc::List'
homepage_item :'FHIR::Composition'
homepage_item :'FHIR::Section'
homepage_item :'FHIR::Narrative'
homepage_item :'WebDoc::Homepage'
homepage_item :'Snelick::Site', :getter => 'snelicks'
homepage_item :'HL7::DataType', :getter => 'data_types'
homepage_item :'HL7::Component', :getter => 'components'
homepage_item :'HL7::ValueSet', :getter => 'value_sets'
homepage_item :'HL7::Value', :getter => 'values'

organizer(:Details, Home) {
  html(:label => 'hl7_section', :html => S_Doc::HL7_SECTION_LABEL)
  view_ref(:Summary, 'data_types',              :label => 'Data Types')
  view_ref(:Summary, 'components',              :label => 'Data Type Components')
  view_ref(:Summary, 'value_sets',              :label => 'Value Sets')
  view_ref(:Summary, 'values',              :label => 'Value Set Values')
  html(:label => 'websites_section', :html => S_Doc::WEBSITES_LABEL)
  view_ref(:Summary, 'snelicks',               :label => 'Website Specifications')
  html(:label => 'hl7v2link', :html => S_Doc::HL7_LINK_LABEL)
  view_ref(:Summary, 'documents',               :label => 'Documents')
  view_ref(:Summary, 'clauses',                 :label => 'Clauses')
  # view_ref(:Summary, 'normative_references',    :label => 'Normative References')
  # view_ref(:Summary, 'abbreviations',           :label => 'Abbreviations')
  # view_ref(:Summary, 'definitions',             :label => 'Definitions')
  # view_ref(:Summary, 'notes',                   :label => 'Notes')
  # view_ref(:Summary, 'examples',                :label => 'Examples')
  view_ref(:Summary, 'figures',                 :label => 'Figures')
  view_ref(:Summary, 'tables',                  :label => 'Tables')
  view_ref(:Summary, 'lists',                   :label => 'Lists')
  # view_ref(:Summary, 'codes',                   :label => 'Code Snippets')
  view_ref(:Summary, 'texts',                   :label => 'Text Sections')
  html(:label => 'fhir_link', :html => S_Doc::FHIR_LINK_LABEL)
  view_ref(:Summary, 'compositions',            :label => 'Composition Resources')
  view_ref(:Summary, 'sections',                :label => 'Sections')
  view_ref(:Summary, 'narratives',              :label => 'Narratives')
  # reorder(:to_beginning => true)
  reorder('fhir_link', 'compositions', 'sections', 'narratives', :to_end => true)
}
