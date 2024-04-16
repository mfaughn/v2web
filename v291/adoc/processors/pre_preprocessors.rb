# TODO make something that actually registers these things and then runs all registered preprocessors

# NOTE this preprocessors are executed BEFORE asciidoctor is invoked and are distinct from Asciidoctor::Extensions::Preprocessor subclasses
module WriteAdoc
  
  module_function
  
  def preprocess(str)
    charfix(str)
  end
  
  def charfix(str)
    regex = /–/
    if regex.match(str)
      str.gsub!(regex) { |match|
        case
        when match == '–'; '&ndash;'
        # when match == '^'
        #   '&#x5e;'
        end
      }
      # puts Rainbow(str).magenta
    end
    str
  end
  
end
