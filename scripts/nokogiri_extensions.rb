require 'rainbow'
require 'nokogiri'
module Nokogiri::XML
  class Document
    def display_structure(indent = 0)
      puts ('  ' * indent) + name.to_s
      children.each { |c| c.display_structure(indent + 1)}
    end
    def collect_styles
      styles = children.map { |c| c.map_styles}.flatten.uniq.sort
    end
    # def extract
    #   extractor = SDoc::DocXtractor.new
    #   extractor.extract(self)
    #   # children.each { |c| c.extract(extractor)}
    # end
  end
  class Element
    def display_structure(indent = 0)
      info = ('  ' * indent) + name.to_s
      case name
      when 'tab'
      when 'tabs'
      when 'sz'
        
      else
      end
      puts info
      attributes.each do |a|
        # puts a.inspect
        a.last.display_structure(indent + 1)
      end
      children.each do |c| 
        if c.respond_to?(:display_structure)
          c.display_structure(indent + 1)
        else
          puts ('  ' * (indent + 1)) + c.class.name
        end
      end
    end
    def collect_styles
      styles = children.map { |c| c.map_styles}.flatten
      if name == 'pStyle'
        val = attributes.find { |a| a.first == 'val' }
        # puts inspect
        # puts Rainbow(name).green
        # puts to_xml if val.nil?
        styles << val.last.value
      end
      styles
    end
    # def extract(extractor)
    #   extractor.extract(self)
    #   children.each { |c| c.extract(extractor)}
    # end
  end
  class Text
    def display_structure(indent = 0)
      puts ('  ' * indent) + 'TEXT: ' + content[0..33]
    end
    def collect_styles
      return []
    end
    # def extract(extractor)
    #   extractor.extract(self)
    # end
  end
  class Attr
    def display_structure(indent = 0)
      puts Rainbow(('  ' * indent) + "#{name}: #{value}").yellow
    end
  end
end
