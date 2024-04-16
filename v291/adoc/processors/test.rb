class TestPostprocessor < Asciidoctor::Extensions::Postprocessor
  def process(document, output)
    if document.basebackend?('html')
      puts Rainbow(output).cornflower
    end
    output
  end
end
