require 'open3'
module V2Web
  class DocXtractor
    def split_title(str, type = nil)
      x = str.gsub(/WITHDRAWN\s+\(/, '')
      unless x =~ /(\([S|s]ets\))|(\(Proposed Example Only\)|\(Fields That Apply to Most Observations(\/Services)?\))/ # I don't remember why I was getting rid of the close parenthesis in the first place....
        x.gsub!(')', '')
      end
      ret = x.split(/\s+[-|–|‑]+\s+/)
      if ret.count > 2
        ret[1] = ret[1..-1].join(' - ')
      end
      ret = x.split(/(?<=[A-Z])\s+(?=[A-Za-z])/) if ret.count < 2
      ret
    end
    
    def get_html(node)
      input  = "docx_datatype.docx"
      output = File.join(__dir__, "docx_datatype.html")
      FileUtils.rm(input) if File.exist?(input)
      FileUtils.rm(output) if File.exist?(output)
      docx = Caracal::Document.new(input)
      docx.raw_xml(node.to_s)
      docx.save
      stdout, stderr, status = Open3.capture3("pandoc -s #{input} -o #{output}")
      puts stderr if stderr && !stderr =~ /WARNING/i
      FileUtils.rm(input) if File.exist?(input)
      html = File.open(output) { |f| Nokogiri::HTML(f) }.at('body').inner_html
      FileUtils.rm(output) if File.exist?(output)
      unless html =~ /^<p>/
        puts Rainbow(html).red;puts
      end
      html
    end
    
    def get_styles(node)
      style_nodes = node.xpath('.//pPr/pStyle')
      styles = style_nodes.collect do |sn|
        val_attr = sn.attributes.find { |a| a.first == 'val' }
        val_attr.last.value
      end
      styles.uniq
    end
    
    def apply_style(html, style)
      html = case style
      when :example
        html.gsub('<p', '<p class="hl7_example"')
      when :note
        html.gsub('<p', '<p class="hl7_note"')
      when :table_caption
        html.gsub('<p', '<p class="hl7_table_caption"')
      else
        puts Rainbow(style.to_s).yellow
        puts html;puts
        html
      end
      html
    end
    
    def find_inner_definitions(html, type = nil)
      defns = {}
      current = nil
      html.each do |node|
        return defns if ['h1', 'h2', 'h3'].include?(node.name) # in case we ran into the next section
        if node.name == 'h4'
          t = node.text.strip
          # HACK because of stupid hidden crap in .docx
          next if t =~ /\w{3}\s+[F|f]ield [D|d]efinitions?/
          unless t.empty?
            current = (t.slice(/.+(?=\()/)&.strip) || t
            current.gsub!(/^[A-Z0-9]+[-]\d+/, '')
            current.delete!("’'")
            current.strip!
            current = current.strip.gsub(/\d{5}$/, '').strip if type == :segment
            defns[current] = []
          end
        else
          next unless current
          defns[current] << node unless node.name == 'text' || node.text.strip.empty?
        end
      end
      defns
    end
  end # DocXtractor
end # V2Web
