module Docx2HTML
      
  class RunStyler    
    def self.hyperlink_styles
      ['HyperlinkText', 'ReferenceDataType', 'ReferenceAttribute', 'Hyperlink', 'ReferenceHL7Table', 'referencehl7table', 'ReferenceUserTable', 'HTMLCite']
    end
    
    # FootnoteReference is handled earlier
    # HyperlinkTable is going to be automatically handled in the website builder for all value sets
    def self.ignored_styles
      ['FootnoteReference', 'HyperlinkTable', 'AttributeTableBodyChar', 'CharChar', 'FootnoteTextChar']
    end
    
    def style(runs, opts)
      @opts = opts
      current_styles = []
      output = ''
      runs.each do |r|
        r_styles = adjust_styles(r.styles, opts)
        completed_styles = current_styles - r_styles
        completed_styles.reverse.each { |s| output << end_style(s) }
        new_styles = r_styles - current_styles
        new_styles.each { |s| output << begin_style(s, r) }
        output << r.text
        current_styles = r_styles # I think...
      end
      current_styles.reverse.each { |s| output << end_style(s) }
      output
    end
    
    def adjust_styles(styles, opts)
      return [] unless styles
      styles = styles - RunStyler.ignored_styles
      styles = styles - RunStyler.hyperlink_styles if opts[:suppress_links]
      styles
    end
    
    def end_style(style)
      if RunStyler.hyperlink_styles.include?(style)
        '</a>'
      else
        case style
        when 'Emphasis'
          '</em>'
        when 'Strong'
          '</strong>'
        when 'NormalIndentedChar', 'NormalIndentedChar1'
          '</span>'
        else
          puts "Can't end style #{style}"
          raise "Can't end style #{style}"
        end
      end
    end
    
    def begin_style(style, run)
      if RunStyler.hyperlink_styles.include?(style)
        ret = begin_link(style, run)
        # puts ret
        return ret
      end
      case style
      when 'Emphasis'
        '<em>'
      when 'Strong'
        '<strong>'
      when 'NormalIndentedChar'
        # puts 'NormalIndentedChar ' + Rainbow(run.text.inspect).yellow
        '<span class="v2-normal-indented-char">'
      when 'NormalIndentedChar1'
        # puts 'NormalIndentedChar1 ' + Rainbow(run.text.inspect).yellow
        '<span class="v2-normal-indented-char1">'
      else
        puts Rainbow(run.text.inspect).red
        raise "Can't begin style #{style}"
      end
    end
    
    def begin_link(style, run)
      if run.is_a?(LinkedRun)
        anchor = run.link
      else
        anchor = HL7Parse.decrypt_link(run, run.text, @opts)
      end
      # puts caller[6]
      # ret = '<a.v2-' + style.downcase + ' href="' + anchor + '">'
      ret = '<a href="' + anchor + '">'
      # puts "      #{ret}"
      return ret
      case style
      when 'Hyperlink', 'HyperlinkText', 'HTMLCite'
        "<a.v2-#{style.downcase} href='#{anchor}'>"
      when 'ReferenceDataType'
        "<a.v2-#{style.downcase} href='#{anchor}'>"
      when 'ReferenceAttribute'
        "<a.v2-#{style.downcase} href='#{anchor}'>"
      when 'ReferenceHL7Table', 'ReferenceUserTable', 'referencehl7table'
        "<a.v2-#{style.downcase} href='#{anchor}'>"
      end
    end
  end
end
