module V2Plus
  class Narrative
    def self.make(nodeset, base = nil)
      puts "Change Narrative nodeset to node" if nodeset.is_a?(Nokogiri::XML::Element)
      this = new
      this.div = Gui_Builder_Profile::Code.new(:content => nodeset.css('div')&.to_html) # gets the entire div
      this
    end
    
    def to_web
      div.content
      # locals = {
      #   :content => div.content
      # }
      # V2Plus.render_with_locals(:narrative, :narrative, locals)
    end
            
  end # Narrative
end
