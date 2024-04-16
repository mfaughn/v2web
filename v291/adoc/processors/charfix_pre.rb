class CharFixPreprocessor < Asciidoctor::Extensions::Preprocessor
  def process document, reader
    lines = reader.lines # get raw lines
    lines = lines.each do |line|
      regex = /–/
      if line =~ regex
        line.gsub!(regex) do |match|
          case
          when match == '–'; '&ndash;'
          end
        end
      end
    end
    reader
  end  
end
