module V2Plus
  class Basic
    def self.make(doc, identifier = nil)
      this = new
      this
    end
        
    def to_web()
      locals = {
        :content => content
      }
      V2Plus.render_with_locals(:basic, :base, locals)
    end
  end # Basic
end # V2Plus
