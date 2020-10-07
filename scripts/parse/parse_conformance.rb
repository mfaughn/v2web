clear_tables

file_name = 'V2_CONFORM_R1_N1_PUBLISH_2020MAY_mf'
title = 'HL7v2 Conformance Methodology R1 N1 Publish - May 2020'

extractor = V2Web::DocXtractor.new
path = HL7Parse.get_source(file_name, HL7Parse.test_data_dir)
extractor.extract_rels(path)
extractor.extract_headers(path)
extractor.extract_footers(path)
file = path + '.docx'
doc = Docx::Document.open(file)
extractor.extract_document(doc.doc, title)

headers_hack
empty_sections_hack