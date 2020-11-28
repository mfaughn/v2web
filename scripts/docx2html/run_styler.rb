module Docx2HTML
      
  class RunStyler    
    HYPERLINK_STYLES = ['HyperlinkText', 'ReferenceDataType', 'ReferenceAttribute', 'Hyperlink', 'ReferenceHL7Table', 'referencehl7table', 'ReferenceUserTable', 'HTMLCite']
    
    # FootnoteReference is handled earlier
    # HyperlinkTable is going to be automatically handled in the website builder for all value sets
    IGNORED_STYLES = ['FootnoteReference', 'HyperlinkTable', 'AttributeTableBodyChar']    
    
    def style(runs, opts)
      current_styles = []
      output = ''
      runs.each do |r|
        r_styles = adjust_styles(r.styles, opts)
        completed_styles = current_styles - r_styles
        completed_styles.each { |s| output << end_style(s) }
        new_styles = r_styles - current_styles
        new_styles.each { |s| output << begin_style(s, r) }
        output << r.text
        current_styles = r_styles # I think...
      end
      current_styles.each { |s| output << end_style(s) }
      output
    end
    
    def adjust_styles(styles, opts)
      return [] unless styles
      styles = styles - IGNORED_STYLES
      styles = styles - HYPERLINK_STYLES if opts[:suppress_links]
      styles
    end
    
    def end_style(style)
      if HYPERLINK_STYLES.include?(style)
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
      if HYPERLINK_STYLES.include?(style)
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
      anchor = run.is_a?(LinkedRun) ? run.link : "BROKEN#{run.text}"
      case style
      when 'Hyperlink', 'HyperlinkText', 'HTMLCite'
        "<a href='#{anchor}'>"
      when 'ReferenceDataType'
        "<a href='REFERENCE_DATATYPE#{anchor}'>"
      when 'ReferenceAttribute'
        "<a href='REFERENCE_ATTRIBUTE#{anchor}'>"
      when 'ReferenceHL7Table', 'ReferenceUserTable', 'referencehl7table'
        "<a href='REFERENCE_VALUE_SET#{anchor}'>"
      end
    end
  end
end
