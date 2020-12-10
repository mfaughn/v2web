require_relative 'parse_common'

extra_comps = ['HL7 over HTTP Specification', 'XML_Encoding_Rules_for_HL7_v2_Messages_Rel2_v03']
extra_comps = ['XML_Encoding_Rules_for_HL7_v2_Messages_Rel2_v03']

ChangeTracker.start
extra_comps.each do |ec|
  c = FHIR::Composition.where(title:c).first
  c.destroy if c
end
ChangeTracker.commit

# V2Web::DocXtractor.new.extract_extra('HL7_over_HTTP_Specification', 'hl7-over-http')
V2Web::DocXtractor.new.extract_extra('XML_Encoding_Rules_for_HL7_v2_Messages_Rel2_v03', 'xml-encoding-rules')
