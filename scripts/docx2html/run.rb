module Docx2HTML
  class Run
    # attr_accessor 
    attr_reader   :node, :nodes, :text, :styles
    def initialize(node, text, styles, opts = {})
      @node   = node
      @nodes  = [node]
      @text   = text
      @styles = [styles].flatten.compact
    end
  end
  
  class LinkedRun < Run
    attr_accessor :link
    def initialize(nodes, text, link, styles = nil, opts = {})
      @nodes  = nodes
      @node   = nodes.first
      @text   = text
      @styles = [styles].flatten.compact
      @link   = HL7Parse.decrypt_link(self, link, opts)
    end
  end

end
