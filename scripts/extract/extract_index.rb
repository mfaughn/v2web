require 'json'
require_relative 'extractor_helpers'
module V2Web
  class DocXtractor    
    def extract_index(doc)
      doc.remove_namespaces!
      @docx = doc
      create_index
    end
    
    def create_index
      top = nil
      @docx.at('body').children.each do |node|
        if node.name == 'p'
          style = node.xpath('.//pPr/pStyle').first&.attribute('val')&.value
          next unless style =~ /Heading/
          txt = extract_plain_text(node).strip
          puts node unless txt
          
          s = HL7Parse::Section.new(txt)
          depth = style.slice(/\d/)
          if depth == '1'
            txt = txt.sub(/^\.\s*/, '').sub(/\n/, '').strip
            puts Rainbow(depth + ': ' + txt.inspect).red
            top ||= HL7Parse::Section.new("Chapter #{@chapter.to_s} - #{txt}")
          else
            case depth.to_s
            when '2'
              puts Rainbow(depth + ': ' + txt.inspect).orange
            when '3'
              puts Rainbow(depth + ': ' + txt.inspect).yellow
            when '4'
              if txt =~ /\w{3}\s+.?\s?[F|f]ields? [D|d]efinitions?/
                puts Rainbow("Skipping bad field definition section ").red + depth + ': ' + txt.inspect
                next
              end
              puts Rainbow(depth + ': ' + txt.inspect)
            when '5'
              puts Rainbow(depth + ': ' + txt.inspect).violet
            when '6'
              puts Rainbow(depth + ': ' + txt.inspect).blue
            else
              puts Rainbow(depth + ': ' + txt.inspect).blink
              raise
            end
            if txt.empty? || txt =~ /hidden/
              puts Rainbow('^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^').red
            else
              top.add(s,depth.to_i - 1)
            end
          end          
        end
      end
      top
    end
  end # DocXtractor
end # V2Web

module HL7Parse
  class Section
    attr_accessor :sections, :parent, :title
    def initialize(title)
      @title = title
      @sections = []
    end
    def depth
      parent ? parent.depth + 1 : 0
    end
    def last(d)
      l = sections.last
      if l.depth < depth
        l.last(depth)
      elsif l.depth == depth
        l
      else
        raise "Depth is already #{depth}"
      end
    end
    def add(s, d)
      if d - 1 == depth
        sections << s
        s.parent = self
      else
        last_section = sections.last
        if last_section.depth < d
          last_section.add(s, d)
        else
          raise "Can't add a section at depth #{d} to a section at depth #{depth}"
        end
      end
    end
    
    def to_toc_file(chapter)
      path = File.expand_path(File.join('~/projects/v2web/test_data/chapter_indices', "Chapter#{chapter.rjust(2,'0')}.txt"))
      File.open(path, 'w+') { |f| f.puts to_toc(chapter) }
    end
    
    def to_json_index(chapter)
      path = File.expand_path(File.join('~/projects/v2web/test_data/chapter_indices', "Chapter#{chapter}.json"))
      File.open(path, 'w+') { |f| f.puts JSON.dump(to_index(chapter)) }
    end
    
    def to_toc(prefix)
      # puts Rainbow(prefix).red if depth == 0
      entries = []
      txt = "#{prefix}  #{title}"
      entry =  "  "*depth + txt
      entries << entry
      sections.each_with_index do |s, i|
        # next_prefix = [prefix,(i+1).to_s].join('.')
        entries += s.to_toc(prefix + '.' + (i+1).to_s)
      end
      entries
    end
    
    def to_index(prefix, entries = {})
      # puts Rainbow(prefix).red if depth == 0
      txt = "#{prefix}  #{title}"
      entry =  "  "*depth + txt
      puts "#{title} already exists" if entries[title]
      entries[title] = prefix 
      sections.each_with_index do |s, i|
        # next_prefix = [prefix,(i+1).to_s].join('.')
        s.to_index(prefix + '.' + (i+1).to_s, entries)
      end
      entries
    end
  end
end