class ER7BlockProcessor < Asciidoctor::Extensions::BlockProcessor
  use_dsl

  named :er7
  on_context :paragraph
  parse_content_as :raw

  def process(parent, reader, attrs)
    puts "yes"
    content = reader.lines.join("\n")
    if is_hl7_er7(content)
      create_block(parent, :example, content, attrs, content_model: :raw)
    else
      create_paragraph(parent, content, attrs)
    end
  end

  def is_hl7_er7(content)
    !!content.match(/^([A-Z]{3})\|.*\|$/)
  end
end
