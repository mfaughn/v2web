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
    
    def create_message_definition(name)
      code, event_code, structure = name.slice(/\w{3}\^\w+\^\w{3}(_\w{3})?/).split('^')
      raise name unless code && event_code && structure
      event_code.strip!
      # puts Rainbow(code).green + ' ' + Rainbow(event).yellow + ' ' + Rainbow(structure)

      skip_event = event_code == 'Znn'
      event = HL7::Event.where(:code => event_code).first unless skip_event

      ChangeTracker.start
      message_def = HL7::Message.create(:name => name, :code => code, :origin => @chapter)
      unless skip_event
        event ||= HL7::Event.create(:code => event_code.strip, :origin => @chapter)
        # puts "Created Event #{event_code.strip<tt>}"</tt>
        looks_like_ack = name =~ /ACK\^/
        looks_like_response = !looks_like_ack && name =~ /Acknowledg|Response/
        if event.trigger.nil? && !looks_like_ack
          event.trigger = message_def
          if looks_like_response
            # puts Rainbow("Is #{name} really the trigger for #{event.name}").orange
          elsif looks_like_ack 
            puts Rainbow("Is #{name} really the trigger for #{event.code}").red
          end
        else
          if looks_like_ack && !event.ack
            event.ack = message_def
          elsif looks_like_response && !event.response
            event.response = message_def
          elsif !event.response
            event.response = message_def
            # puts Rainbow("Set #{name} as response for #{event.code}").magenta
          else
            puts Rainbow("What to do with #{name} with respect to  #{event.code}").red
          end
        end
      end
  
      ChangeTracker.commit
      message_def
    end
    
    def get_message_structure(name)
      code, event_code, structure = name.slice(/\w{3}\^\w+\^\w{3}(_\w{3})?/).split('^')
      raise name unless code && event_code && structure
      if structure == 'PIN_I01'
        puts Rainbow('Changing PIN_I01 to RQI_I01 during search').green
        structure = 'RQI_I01'
      end
      msg_structure = HL7::MessageStructure.where(:code => structure).first
    end
        
    def create_message_structure(name)
      code, event_code, structure = name.slice(/\w{3}\^\w+\^\w{3}(_\w{3})?/).split('^')
      raise name unless code && event_code && structure
      if structure == 'PIN_I01'
        puts Rainbow('Changing PIN_I01 to RQI_I01').green
        structure = 'RQI_I01'
      end
      ChangeTracker.start
      msg_structure = HL7::MessageStructure.create(:code => structure, :origin => @chapter)
      # puts Rainbow("Create MessageStructure #{msg_structure.code}").magenta
      ChangeTracker.commit
      msg_structure
    end
    
    def get_identical_structures_for(structure)
      # puts "Checking #{structure.code}"
      other_structures = HL7::MessageStructure.all
      other_structures = other_structures - [structure]
      other_structures.select! { |os| os.segments.count == structure.segments.count }
      other_structures.select! do |os|
        segment_pairs = os.segments.zip(structure.segments)
        segment_pairs.all? { |a,b| a.same_as?(b) } 
      end
      if other_structures.any?
        unless other_structures.count == 1 && other_structures.first.code == structure.code
          # puts "Structure #{structure.code} is the same as #{other_structures.map(&:code).join(', ')}"
        end
      end
      other_structures
    end
    
    def diff_structures(a,b)
      a.diff(b)
      # segment_pairs = a.segments.zip(b.segments)
      # segment_pairs.each do |a,b|
      #   a.diff(b)
      # end
    end
    
    
  end # DocXtractor
end # V2Web
