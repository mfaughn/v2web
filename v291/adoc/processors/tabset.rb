class MessageTabsBlockProcessor < Asciidoctor::Extensions::BlockProcessor
  use_dsl

  named :"message-tabs"
  on_context :paragraph
  # parse_content_as :simple
  parse_content_as :raw

  def process(parent, reader, attrs)
    html = "<span color='red'>TABSET - #{attrs.inspect}</span>"
    puts Rainbow(html).lime
    create_paragraph(parent, html, attrs)
  end
end
