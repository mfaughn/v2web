module HL7::Vocab
  class Concept    
    def to_row
      locals = {
        :code       => self.code,
        :display    => self.display,
        :definition => self.definition,
        :deprecated => self.version_deprecated
      }
      V2Pub.render_with_locals(:concept, :row, locals)
    end
  end  
end
