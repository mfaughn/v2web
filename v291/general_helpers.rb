def create_text_with_asciidoc_richtext(str)
  # puts Rainbow(str).lime
  ChangeTracker.start
  text = V2Web::Text.new
  text.content = create_asciidoc_richtext(str)
  text.save
  # TODO get V2AD::Text with same section
  ChangeTracker.commit
  text
end

def create_asciidoc_richtext(str)
  rt = Gui_Builder_Profile::RichText.new
  rt.content = str
  rt.markup_language = 'AsciiDoc'
  rt.save
  rt
end