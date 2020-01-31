require 'csv'
module V2Web
  class Document
    def subsections
      content.select { |c| c.is_a?(V2Web::Section) }
    end
  end
end
require 'fileutils'
def stub_xml(site)
  config_dir = File.join( __dir__, '..','config')
  FileUtils.mkdir_p(config_dir)
  folder_dir = File.join( config_dir, 'v2conformance')
  FileUtils.mkdir_p(folder_dir)
  csv = CSV.open(File.join(config_dir, 'v2conformance.csv'), 'w')
  csv << ['Header 1', 'Header 2', 'Header 3', 'Header 4', 'Header 5', 'Tab 1', 'Tab 2', 'Tab 3', 'Tab 4', 'Tab 5']
  f   = File.open(File.join(config_dir, 'v2conformance_config.xml'), 'w')
  f.puts '<?xml version="1.0" encoding="UTF-8" standalone="yes"?>' + "\n"
  f.puts "<standard title=#{site.title.inspect}>\n"
  site.subsections.each_with_index do |ss, i|
    # no tabsets at this level...
    stub_section(ss, i + 1, f, folder_dir, csv, site)
  end
  csv.close
  f.puts "</standard>\n"
  f.close
end

def stub_section(section, position, file, parent_folder_dir, csv, parent, parent_section = nil)
  csv_row = Array.new(10)
  depth = parent_section.to_s.split('.').count + 1
  if parent_section.nil?
    location = position.to_s
  else
    location = parent_section + '.' + position.to_s
  end
  numbered_title = location + ' - ' + section.title.hl7
  csv_row[depth - 1] = numbered_title
  csv << csv_row
  # because Windoz can't handle long strings in paths...
  if depth < 3
    folder_title = numbered_title
  else
    folder_title = location
  end
  folder_dir = File.join(parent_folder_dir, folder_title)
  FileUtils.mkdir_p(folder_dir)
  xml_content = section.content.select { |c| c.is_a?(V2Web::Section) || c.is_a?(V2Web::TabSet) }
  
  entry = "<section location=#{location.inspect} title=#{section.title.inspect}"
  if depth < 3
    url = section.url_title + '.html'
    entry <<  " localUrl=#{url.inspect}"
  end
  if xml_content.any?
    file.puts ('  ' * depth) + entry + ">"
    subsection_position = 1

    xml_content.each do |xc, i|
      if xc.is_a?(V2Web::Section)
        stub_section(xc, subsection_position, file, folder_dir, csv, section, location)
        subsection_position += 1
      else
        stub_tabset(xc, file, location)
      end
    end
    file.puts ('  ' * depth) + "</section>"
  else
    file.puts ('  ' * depth) + entry + "/>"
  end
end

def stub_tabset(tabset, file, parent_section)
  depth = parent_section.to_s.split('.').count + 1
  entry = "<tabSet"
  entry << " title=#{tabset.title.inspect}" if tabset.title && !tabset.title.empty?
  file.puts ('  ' * depth) + entry + ">"
  tabset.tabs.each { |tab| stub_tab(tab, file, depth + 1) }
  file.puts ('  ' * depth) + "</tabSet>"
end

def stub_tab(tab, file, depth)
  if tab.file
    file.puts ('  ' * depth) + "<tab title=#{tab.title.inspect} file=#{tab.file_filename.inspect}/>"
  else
    file.puts ('  ' * depth) + "<tab title=#{tab.title.inspect}/>"
  end
end

