module V2Web
  class Document
    def subsections
      content.select { |c| c.is_a?(V2Web::Section) }
    end
  end
end
require 'fileutils'
def stub_folders(site)
  base = File.join( __dir__, '..','config/v2conformance')
  FileUtils.mkdir_p(base)
  d.subsections.each { |sc| _stub_folders(sc, base, d) }
end

def _stub_folders(clawz, parent_dir, doc, depth = 0)
  return if depth > 1
  # n = clawz.number(doc)
  nums = (clawz.containers + clawz.documents).collect do |container|
    container.subsections.index { |sc| sc.id == clawz.id }
  end
  nums.uniq!
  num = nums.first if nums.count == 1
  raise "Multiple Containers for #{clawz.inspect}" unless num
  # puts "N is #{num}"
  dir = File.join(parent_dir, "#{num + 1} - #{clawz.title}")
  # puts dir
  FileUtils.mkdir_p(dir)
  clawz.subsections.each { |sc| _stub_folders(sc, dir, doc, depth + 1) }
end
