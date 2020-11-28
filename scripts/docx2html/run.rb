module Docx2HTML
  class Run
    attr_accessor :text, :styles
    def initialize(text, styles, opts = {})
      @text = text
      @styles = [styles].flatten.compact
    end
  end
  
  class LinkedRun < Run
    attr_accessor :link
    def initialize(text, link, styles = nil)
      super(text, styles)
      @link = link
    end
  end
end
