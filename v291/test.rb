module V291  
  
  module_function
  
  def test
    sections = V2Web::Section.all;
    puts sections.size
    level = nil
    last = nil
    sections.each do |s|
      color = :lime
      l = s.render_as.value
      if l =~ /Level/
        if l =~ /1/
          level = 1
        elsif l =~ /2/
          level = 2
        elsif l =~ /3/
          level = 3
        elsif l =~ /4/
          level = 4
        else
          raise "What do I do with #{l}"
        end
      else
        if l =~ /Message/
          level = 5
        elsif l =~ /Subsection/
          color = :yellow
          if last =~ /Subsection/
            level = level
          else
            level = level + 1
          end
        else
          raise "What do I do with #{l}"
        end
      end
      last = l   
         
      label = ' '*(level-1)
      # label << Rainbow(s.breadcrumbs).send(color)
      label << Rainbow(s.title).send(color)
      label << " #{s.original_number.to_s}" if s.original_number
      label << " #{l}"
      
      puts label
    end
  end
  
end
