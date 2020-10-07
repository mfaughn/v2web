require_relative 'parse_common'

HL7::AcknowledgmentChoreography.delete

HL7Parse.data_sources.each do |source|
  next if source == nil
  puts Rainbow("## Parse Acknowledgment Choreographies from #{source} ##").magenta
  chapter = source.slice(/(?<=CH)\d\dA?/)
  chapter.delete('0') if chapter[0] == '0' # get rid of leading zero
  extractor = V2Web::DocXtractor.new(chapter)
  docx_path = HL7Parse.docx_path(source)
  html_path = HL7Parse.html_path(source)
  # stdout, stderr, status = Open3.capture3("pandoc -s #{docx_path} -o #{html_path}")
  # puts stderr if stderr && !stderr =~ /WARNING/i
  doc = Docx::Document.open(docx_path)
  extractor.extract_acs(doc.doc, html_path)
end

