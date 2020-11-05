# require_relative 'parse_common'
load File.expand_path(File.join(__dir__, 'parse_common.rb'))

HL7::SegmentDefinition.delete
HL7::DataElement.delete
HL7::Field.delete

# HL7Parse.name_mismatchs.clear
sources = HL7Parse.data_sources('2')
# sources = HL7Parse.data_sources
sources.each do |source|
  next if source == nil
  puts Rainbow('#####################################').orange
  puts Rainbow(source).orange
  chapter = source.slice(/(?<=CH)\d\dA?/)
  chapter.delete('0') if chapter[0] == '0' # get rid of leading zero
  extractor = V2Web::DocXtractor.new(chapter)
  docx_path = HL7Parse.docx_path(source)
  html_path = HL7Parse.html_path(source)
  unless File.exist?(html_path)
    stdout, stderr, status = Open3.capture3("pandoc -s #{docx_path} -o #{html_path}")
    puts stderr if stderr && !stderr =~ /WARNING/i
  end
  doc = Docx::Document.open(docx_path)
  extractor.extract_segments_1(doc.doc, html_path)
end
ChangeTracker.start
HL7::SegmentDefinition.all.select { |sd| sd.fields_count == 0 }.each do |sd|
  sd.destroy
end
ChangeTracker.commit

# check to see if there are any fields that aren't withdrawn and have data elements with no data type
HL7::Field.all do |field|
  next if field.optionality&.value == 'W'
  fde = field.data_element
  sd = field.segment_definition
  if fde
    unless fde.data_type
      puts Rainbow("Segment #{sd.code} from #{sd.origin} has field #{field.sequence_number} with a data element #{fde.item_number} that is missing a data type.").red
      others = fde.fields.map { |df| sd = df.segment_definition; "#{sd.code} #{sd.origin} field #{df.sequence_number}"}.sort
      puts "The data element is found in #{others}"
    end
  else
    if sd
      puts Rainbow("Field without data element -- #{sd.code} #{sd.origin} field #{field.sequence_number}").yellow
    else
      puts Rainbow("Orphan field\n#{field.pretty_inspect}").yellow
    end
  end
end

# puts HL7Parse.name_mismatchs
