module V2Web
  class Box    
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      content.first&.identifying_text
    end
      
    def to_hl7_site(_ = nil)
      locals = {:content => content.map { |c| c.to_hl7_site }.join("\n")}
      locals[:classes] = styles.map(&:value).join(' ')
      V2Web.render_with_locals(:box, locals)
    end
    
    def footnotes
      content.map(&:footnotes).flatten
    end
    
    def all_texts
      texts = []
      content.each { |item| texts << item if item.is_a?(V2Web::Text) }
      texts
    end
    
    def all_tables
      tables = []
      content.each { |item| tables << item if item.is_a?(V2Web::Table) }
      tables
    end
    
    def all_figures
      figures = []
      content.each { |item| tables << item if item.is_a?(V2Web::Figure) }
      figures
    end  
  end
end
