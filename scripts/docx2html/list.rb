module Docx2HTML
  class List
    
    def self.set_numId_map(hash)
      @numId_map = hash
    end
    
    def self.numId_map
      @numId_map
    end
    
    def self.known_styles
      ['none', 'list', 'normallistalpha', 'normallistnumbered', 'normallistbullets', 'listbullet2', 'listbullet3', 'listparagraph', 'normallist']
    end
      
    
    attr_accessor :items, :type, :classes, :style_type
    def initialize(style, numId = nil, opts = {})
      # raise ListError if style == 'normallistalpha' && numId == '5'
      @chapter = opts[:chapter]
      @items   = []
      @classes = ['v2', 'v2-list']
      @classes << ['v2-sublist'] if opts[:sublist]
      if style
        translate_style(style)
      else
        translate_numId(numId)
      end
    end
    
    def add(item)
      @items << item
    end

    def translate_style(style)
      case style
      when 'none', 'normallist'
        @type = 'ul'
        @style_type = 'none'
      when 'normallistalpha'
        # FIXME 'normallistalpha' is used in Ch.2A in RFR.  There are other paragraphs interspersed in the list and I have no idea how to programmatically determine that they are part of the content of the list item.
        @type = 'ol'
        @style_type = 'lower-alpha'
      when 'normallistbullets'
        # FIXME 'normallistbullets' is used in Ch.4 in TQ2.  How it gets rendered there is all over the place.  Sometimes it is roman numerals, sometimes bullets.  Going to make it bullets because that is what the title says it should be.
        @type = 'ul'
        @style_type = 'disc'
      when 'normallistnumbered'
        @type = 'ol'
        @style_type = 'decimal'
      when 'disc', 'listbullet2', 'listbullet3'
        @type = 'ul'
        @style_type = 'disc' # this only works if it is first level, otherwise should be circle. fixed w/ CSS downstream in HTML
      when 'decimal'
        @type = 'ol'
        @style_type = 'decimal'
      when 'list', 'lower-alpha', 'listparagraph'
        @type = 'ol'
        @style_type = 'lower-alpha'
      else
        raise "Unknown list style #{style}"
      end
      @classes << "v2-#{@style_type}-list-#{style}"
    end
    
    # these numbers aren't consistent across docx files. you have to set them for each file...
    def translate_numId(numId)
      style = List.numId_map[numId]
      if style
        translate_style(style)
      else
        # puts Rainbow("Unknown numId style #{numId}").red
        raise ListError, "Unknown numId style #{numId}"
      end
    end
    
    
    
    def html(opts = {})
      list_html = []
      list_start = "<#{type}"
      if classes.any?
        list_start << ' class="' + classes.join(' ') + '"'
      end
      if style_type
        list_start <<' style="list-style: ' + style_type + '"'
      end 
      list_start << '>'
      list_html << list_start
      items.each do |li|
        if li.list
          list_html << '<li class="v2 v2-li">' + (li.content || '') # content can be nil
          list_html << li.list.html
          list_html <<'</li>'
        else
          list_html << '<li class="v2 v2-li">' + li.content + '</li>'
        end
      end
      list_html << "</#{type}>"
      # puts list_html.class
      # list_html.each { |lh| puts Rainbow(lh.inspect).cyan if lh =~ /\n/ }
      # output = Nokogiri::HTML::fragment(list_html.join).to_xhtml(indent: 2)
      output = list_html.join
      # puts Rainbow(output.inspect).lime if output =~ /\n/
      output
    end
    
    
  end
  
  class ListItem
    attr_accessor :content, :list
    def initialize(content = nil)
      @content = content
      # @list = nil
    end
  end
  
  class ListError < StandardError
  end
end
