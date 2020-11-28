require 'zip'
require 'fileutils'
require_relative 'parse_common'
# V2Web::Standard.delete
# V2Web::Section.delete

FHIR::Composition.delete
FHIR::Section.delete
FHIR::Narrative.delete
FHIR::Basic.delete

sources = HL7Parse.data_sources(['1','2','2a'])

# sources = ['V29_CH09_MedRecords']

sources.each do |source|
  next if source == nil
  puts Rainbow('#####################################').orange
  puts Rainbow(source).orange
  chapter = source.slice(/(?<=CH)\d\dA?/)
  chapter.delete('0') if chapter[0] == '0' # get rid of leading zero
  extractor = V2Web::DocXtractor.new(chapter)
  docx_path = HL7Parse.docx_path(source)
  # html_path = HL7Parse.html_path(source)
  # zip_path  = HL7Parse.zip_path(source)
  # unzipped  = HL7Parse.unzip_path(source)

  # FileUtils.cp_r(docx_path, zip_path, :remove_destination => true) unless File.exist?(zip_path)
  # unless File.exist?("#{unzipped}/word/document.xml")
    # system "unzip -o #{zip_path} -d #{unzipped}"
    # # system "tidy -xml -indent -quiet -utf8 -o #{unzipped}/word/document.xml #{unzipped}/word/document.xml"
  # end
  doc = Docx::Document.open(docx_path)
  extractor.extract_chapter(doc.doc)
end
