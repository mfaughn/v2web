require 'nokogiri'
main_folder = File.expand_path('~/projects/utg/input/sourceOfTruth/REPLACE/codeSystems')
subfolders  = ['v2', 'v3', 'fhir', 'unified']

def stewardless(subfolders, main_folder)
  answer = {}
  subfolders.each do |sf|
    answer[sf] ||= []
    folder = main_folder.sub('REPLACE', sf)
    files  = Dir[folder + '/*.xml']
    files.each do |file|
      cs = File.open(file) { |f| Nokogiri::XML(f) }.at_css('CodeSystem')
      extensions = cs.children.select { |node| node.name == 'extension' }
      stewards = extensions.select do |ext|
        url = ext.attr('url')
        next unless url
        url =~ /structuredefinition-wg/
      end
      next if stewards.any?
      url  = cs.at_css('url').attr('value')
      name = cs.at_css('name').attr('value')
      desc = cs.at_css('description').attr('value')
      answer[sf] << [name, url, desc]
    end
  end
  headers = [
    'Realm',
    'CodeSystem Name',
    'URL',
    'Description'
  ]
  csv_file = File.expand_path(File.join(__dir__, "stewardless_codesystems.csv"))
  csv = CSV.open(csv_file, "wb")
  csv << headers
  answer.each do |realm,data|
    data.each do |row|
      csv << [realm] + row
    end
  end
  csv.close
end
stewardless(subfolders, main_folder)

def steward_inspect(subfolders, main_folder)
  folders = subfolders.map { |f| main_folder.sub('REPLACE', f) }
  files = folders.map { |folder| Dir[folder + '/*.xml'] }.flatten
  # types = []
  # all_codes = []
  puts files.size
  groups = []
  vocabs = []
  total  = []
  multi  = []
  files.each do |file|
    cs = File.open(file) { |f| Nokogiri::XML(f) }.at_css('CodeSystem')
    extensions = cs.children.select { |node| node.name == 'extension' }
    stewards = extensions.select do |ext|
      url = ext.attr('url')
      next unless url
      url =~ /structuredefinition-wg/
    end
    total << file if stewards.any?
    multi << file if stewards.size > 1
    stewards.each do |s|
      group = s.at_css('valueCode').attr('value')
      groups << group
      if group == 'vocab'
        vocabs << file
        puts s
      end
    end
  end

  puts groups.uniq.sort.inspect
  puts total.size
  puts vocabs
  puts multi.size
end
