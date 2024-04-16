class ER7TreeProcessor < Asciidoctor::Extensions::TreeProcessor
  def process(document)
    paragraphs = document.find_by(context: :paragraph)
    paragraphs.each do |pg|
      c = pg.content
      if has_er7?(c) || has_message_identifier?(c)
        puts Rainbow(pg.content).cornflower
        replaced_content = c.gsub('^', '&#x5e;')
        replacement_paragraph = create_paragraph(pg.parent, replaced_content, pg.attributes)
        children = pg.parent.blocks
        i = children.index(pg)
        pg.parent.blocks[i] = replacement_paragraph
        puts Rainbow(pg.parent.blocks[i].content).lime
      end
    end
    nil
  end

  def has_er7?(content)
    !!content.match(/[A-Z]{3}\|.*\|/)
  end
  
  def has_message_identifier?(content)
    !!content.match(/^([A-Z]{3})\^[A-Z0-9]{3}\^(ACK|[A-Z]{3}_[A-Z0-9]{3})/)
  end
end
