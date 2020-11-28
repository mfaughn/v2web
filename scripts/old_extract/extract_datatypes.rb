
class OldDatatypeExtraction
  def find_datatypes_from_html
    @html.at('body').children.each do |node|
      if node.name == 'h3'
        abbrv, name = split_title(node.text)
        @current_html_dt = name.strip
        @html_dt[@current_html_dt] = []
      end
      next unless @current_html_dt
      @html_dt[@current_html_dt] << node unless node.name == 'text'
    end
    # @html_dt.keys.sort.each {|k| p k}
  end
  def add_to_component(node)
    return
    @component_num += 1
    title = extract_text(node).gsub(/\(.*\)/, '').strip
    @component = @datatype.components.find { |c| c.name.downcase == title.downcase }
    msg = "#{@datatype.code}: #{@component_num} - #{title}"
    if @component
      # puts Rainbow(msg).green
    else
      p @datatype.components.map { |c| c.name }.sort
      puts Rainbow(msg).red
      puts node
    end
  end
  
  def find_component_definitions(html, type = nil)
    # lets get everything after the table
    table_seen = false
    html = html.drop_while { |n| !(table_seen = n.name == 'table') } # drop everything before the table
    html.shift # table is now first so drop that
    defns = {}
    seq_num = nil
    html = html.take_while { |node| !(['h1', 'h2', 'h3'].include?(node.name)) }  # in case we ran into the next section
    counter = 1
    html.each do |node|
      # return defns if ['h1', 'h2', 'h3'].include?(node.name)
      if node.name == 'h4'
        t = node.text.strip
        return defns if t == 'hiddentext' # ARRGGHHH I hate MS Word.  I hope this is not a problem...
        # puts t
        # HACK because of stupid hidden crap in .docx
        next if t =~ /\w{3}\s+.?\s?[F|f]ields? [D|d]efinitions?/
        unless t.empty?
          title    = (t.slice(/.+(?=\()/)&.strip) || t
          title = title.gsub('–', '-')
          seq_num = counter
          counter += 1
          title.gsub!(/^[A-Z0-9]+[-]\d+/, '')
          title.delete!("’'")
          title.strip!
          # puts t
          # puts Rainbow(title).green
          # puts Rainbow(field_id).yellow
          # puts Rainbow(seq_num).cyan
          defns[seq_num.to_i] = { :title => title, :seq_num => seq_num, :nodes => [] }
        end
      else
        next unless seq_num
        defns[seq_num.to_i][:nodes] << node unless node.name == 'text' || node.text.strip.empty?
      end
    end
    defns
  end
  
  def check
    return unless @datatype
    names = Hash.new(0)
    @datatype.components.each { |c| names[c.name] += 1 }
    dupes = names.select { |_,v| v > 1 }
    if dupes.any?
      puts Rainbow(@datatype.code).green
      puts dupes.keys
      puts
    end
  end
end
  
