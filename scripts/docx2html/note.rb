module Docx2HTML
  class Note

    def self.known_styles
      ['note']
    end
    
    def initialize(opts = {})
      # raise ListError if style == 'normallistalpha' && numId == '5'
      @chapter = opts[:chapter]
      # @classes = ['v2', 'v2-note']
      @entries = []
    end
    
    def add(entry)
      @entries << entry
    end
    
    def html(opts = {})
      note_html = []
      note_start = '<div class="v2-note">'
      # if classes.any?
      #   note_start << ' class="' + classes.join(' ') + '"'
      # end
      note_html << note_start
      @entries.each { |entry| note_html << entry }
      note_html << "</div><br/>"
      note_html.join
    end
  end
  
end
