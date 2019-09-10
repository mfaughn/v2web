module SDoc
  class Document
    def subclauses
      content.select { |c| c.is_a?(SDoc::Clause) }
    end
  end
end
require 'fileutils'
def stub_folders(site)
  d = site.doc
  base = File.join( __dir__, '..','stubs', d.title)
  FileUtils.mkdir_p(base)
  d.subclauses.each { |sc| _stub_folders(sc, base, d) }
end

def _stub_folders(clawz, parent_dir, doc, depth = 0)
  return if depth > 1
  # n = clawz.number_in(doc)
  nums = (clawz.containers + clawz.documents).collect do |container|
    container.subclauses.index { |sc| sc.id == clawz.id }
  end
  nums.uniq!
  num = nums.first if nums.count == 1
  raise "Multiple Containers for #{clawz.inspect}" unless num
  # puts "N is #{num}"
  dir = File.join(parent_dir, "#{num + 1} - #{clawz.title}")
  # puts dir
  FileUtils.mkdir_p(dir)
  clawz.subclauses.each { |sc| _stub_folders(sc, dir, doc, depth + 1) }
end
