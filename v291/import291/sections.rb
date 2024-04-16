module V291
  module_function

  def translate_sections
    v2.sections.each do |num, s|
      ctstart
      obj = V2Web::Section.new
      obj.render_as = v291original
      obj.original_number = num
      txt = s.adoc.lines.map(&:chomp)
      if txt.first =~ /^=+\s+\*?\d+(\.\d+)?\*?/
        x = txt.shift
        obj.title = x.sub(/^=+\s+\*?\d+A?(\.\d+)*\*?\s+/, '').strip
      else
        puts Rainbow("No title for #{num}").orange
        puts txt
      end
      if txt.any?
        # puts txt.join("\n")
        txt_obj = V2Web::Text.new
        gbptext = Gui_Builder_Profile::RichText.new(:content => txt.join("\n"))
        gbptext.markup_language = asciidoc_lang
        gbptext.save
        txt_obj.content = gbptext
        txt_obj.save
        obj.add_content(txt_obj)
        s.adoc.sequel = txt_obj
      end
      obj.save
      ctcommit
      s.sequel = obj
    end
  end

end
