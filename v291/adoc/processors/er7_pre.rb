class ER7Preprocessor < Asciidoctor::Extensions::Preprocessor
  def process document, reader
    lines = reader.lines # get raw lines
    lines = lines.each do |line|
      if line =~ /\^/ && (has_er7?(line) || has_message_identifier?(line))
        # puts Rainbow(line).cornflower
        line.gsub!('^', '&#x5e;')
        # puts Rainbow(line).lime
      end
    end
    reader
  end
  
  def has_er7?(content)
    !!content.match(/[A-Z]{3}\|.*\|/)
  end

  def has_message_identifier?(content)
    !!content.match(/^([A-Z]{3})\^[A-Z0-9]{3}\^(ACK|[A-Z]{3}_[A-Z0-9]{3})/)
  end
  
end
