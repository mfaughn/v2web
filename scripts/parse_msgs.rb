require 'docx'
load File.join(__dir__, 'nokogiri_extensions.rb')
load File.join(__dir__, 'extractor.rb')
load File.join(__dir__, 'extract_msgs.rb')
load File.join(__dir__, 'headers_footers.rb')
load File.join(__dir__, 'extractor_helpers.rb')

HL7::MessageDefinition.delete
HL7::SegmentSequence.delete
HL7::SegmentChoice.delete
HL7::Segment.delete

this_dir = File.expand_path(File.dirname(__FILE__))
source_dir = File.join(this_dir, '../test_data/v2.9_Dec16')
# source_dir = File.join(this_dir, '../test_data/v2.9_Dec16_orig')
# Dir[File.join(source_dir, '*')].each do |e|
#   puts e.split('/').last if File.file?(e)
# end
sources = [
'V29_CH03_PatientAdmin',
'v29_CH04_Orders',
'V29_CH04A_Orders',
'V29_CH05_Queries',
'V29_CH06_FinancialMngmt',
'V29_CH07_Observations',
'V29_CH08_MasterFiles',
'V29_CH09_MedRecords',
'V29_CH10_Scheduling',
'V29_CH11_PatientReferral',
'V29_CH12_PatientCare',
'V29_CH13_ClinicalLabAuto',
'V29_CH14_AppMngmt',
'V29_CH15_PersMngmt',
'V29_CH16_eClaims',
'V29_CH17_MaterialsMngmt',
nil
]

sources.each do |source|
  next if source == nil
  puts Rainbow("## Parse Messages from #{source} ##").magenta
  chapter = source.slice(/(?<=CH)\d\dA?/)
  chapter.delete('0') if chapter[0] == '0' # get rid of leading zero
  extractor = V2Web::DocXtractor.new(chapter)
  docx_path = File.join(source_dir, source) + '.docx'
  html_path = File.join(source_dir, source) + '.html'
  # stdout, stderr, status = Open3.capture3("pandoc -s #{docx_path} -o #{html_path}")
  # puts stderr if stderr && !stderr =~ /WARNING/i
  doc = Docx::Document.open(docx_path)
  extractor.extract_messages(doc.doc, html_path)
end

