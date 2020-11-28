require 'fileutils'
require 'diffy'
module HL7Check
  def self.data_elements_with_multiple_definitions
    @des ||= all_data_elements.select { |de| de.definitions_count > 1 }
  end
  def self.all_data_elements
    @all_des ||= HL7::DataElement.all
  end

  def self.diff(first,second)
    t=second.chars; first.chars.map{|c| c == t.shift ? c : '^'}.join
  end
  
  def self.html_start
    "<!doctype html>\n<html lang=en>\n<head>\n<meta charset=utf-8>\n</head>\n<body>\n"
  end
  
  def self.html_end
    "</body>\n</html>\n"
  end

  def self.check_data_elements_with_multiple_definitions
    bars = '-'*10
    dir = File.expand_path(File.join(__dir__, '../test_data/data_element_descriptions_check'))
    FileUtils.mkdir_p(dir)
    f_collated = File.open(File.join(dir, "collated.html"), 'w+')
    f_collated.puts(html_start)
    dxs = HL7Check.data_elements_with_multiple_definitions
    total = {}
    kill = []
    all_multis = HL7Check.data_elements_with_multiple_definitions
    
    all_multis.sort_by {|de| de.item_number.to_s.rjust(4, '0')}.each do |de|
      next if de.item_number == 0
      dxs = de.definitions
      # first_definition = dxs.shift
      dxs2 = []
      msg2 = []
      eliminate = []
      counter = 0
      dxs.each do |dx|
        same = dxs2.find { |dx2| dx.definition_content == dx2.definition_content }
        if same
          eliminate << dx
          kill << dx
          # msg2 << "<h4 style='color:red;background-color:yellow'>Description from #{dx.chapter} #{dx.original_container} is the same as #{same.chapter} #{same.original_container}.</h4>"
          msg2 << "<h4 style='background-color:yellow'>Description from Ch.#{dx.chapter}: #{dx.original_container} is the same as that from Ch.#{same.chapter}: #{same.original_container} and has been eliminated.</h4>"
        else
          counter += 1
          msg2 << "<h4>#{' '*10}#{bars} #{counter.ordinalize} Description: Ch. #{dx.chapter} #{dx.original_container} #{bars}</h4>#{dx.definition_content}"
          dxs2 << dx
        end
      end
      puts Rainbow("DataElement #{de.item_number} - #{de.name} has #{dxs.count} definitions, of which #{eliminate.count} may be eliminated.").orange
      next unless dxs2.count > 1
      # dxs2.each { |dx| puts dx.definition_content.inspect; puts }
      path = File.join(dir,"#{de.item_number.to_s.rjust(4,'0')}-#{de.name.gsub(/\s+|\//,'_').gsub(/[\+\*\#]/, '').strip}-#{dxs2.count}_definitions.html")
      f = File.open(path, 'w+')
      f.puts(html_start)
      msg1 = "<h2>Data Element ##{de.item_number} - #{de.name}</h2><h3>#{dxs2.count} distinct definitions</h3><br/>"
      f_collated.puts msg1
      f.puts msg1
      f.puts msg2.join("<br/>")
      f.puts("<hr>")
      f_collated.puts("<hr>")
      f_collated.puts msg2.join("<br/>")
      dxs2.each_with_index do |first, i|
        dxs[i+1..-1].each_with_index do |second, j|
          diff = "<h4>#{' '*10}#{bars} DIFF b/w #{i+1} and #{i+j+2} #{bars}</h4>"
          diff << Diffy::Diff.new(first.definition_content, second.definition_content).to_s(:html)
          f.puts diff
          # f_collated.puts diff
        end
      end
      f.puts(html_end)
      f.close
      total[de] = dxs2 if dxs2.count > 1
    end
    "There are #{all_multis.count} data elements with multiple definitions."
    puts "There are #{total.keys.count} data elements with multiple *non-redundant* definitions.  This accounts for #{total.values.flatten.count} definitions."
    f_collated.puts(html_end)
    f_collated.close
  end
end
class Integer
  def ordinalize
    if (11..13).include?(self % 100)
      "#{self}th"
    else
      case self % 10
        when 1; "#{self}st"
        when 2; "#{self}nd"
        when 3; "#{self}rd"
        else    "#{self}th"
      end
    end
  end
end
HL7Check.check_data_elements_with_multiple_definitions

