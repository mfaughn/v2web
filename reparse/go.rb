module Reparse
  module_function
  
  def fhir_folder
    '/Users/mfaughn/projects/v2fhir/v2_plus_'
  end
  
  def registry
    @registry ||= {}
  end
  
  def image_counter
    @image_counter ||= 0
    @image_counter += 1
  end
  
  def reset_img_counter
    @image_counter = nil
  end
  
  def clear_msgs_acks_events
    V2::Message.all { |m| ChangeTracker.commit { m.destroy } }
    HL7::AcknowledgmentChoreography.all { |m| ChangeTracker.commit { m.destroy } }
    HL7::Event.all { |m| ChangeTracker.commit { m.destroy } }
  end
  
  def parse_compositions
    folder = fhir_folder + 'compositions'
    files  = Dir[folder + '/*']
    files.each do |file|
      reset_img_counter
      doc = File.open(file) { |f| Nokogiri::XML(f) }
      xml = doc.css('Composition')
      # url  = xml.at_css('url').attr('value')
      title = xml.at_css('title').attr('value')
      # next unless title == "Query"
      puts "Parsing #{title}"
      sections = parse_sections(xml)
      ChangeTracker.start
      domain = V2Web::Standard.new(title:title)
      domain.render_as = 'v2+ domain'
      domain.content = sections
      ChangeTracker.commit
    end
  end
  
  def parse_sections(input)
    if input.is_a?(Array)
      ss = input
    else
      ss = input.children.select { |n| n.name == 'section' }
    end
    # puts ss.map(&:children).flatten.map(&:name).flatten.uniq
    # text - the div
    # title - the title
    # code - what kind of section it is
    # section - child sections
    returned_content = []
    ss.each do |s|
      type = s.at_css('code text').attr('value')
      case type
      when 'clause', 'pre'
        title    = s.at_css('title').attr('value')
        ChangeTracker.start
        clause = V2Web::Section.new(title:title)
        clause.render_as = type
        clause.save
        ChangeTracker.commit

        kids         = s.children
        sub_sections = kids.select { |n| n.name == 'section' }
        text_divs    = kids.select { |n| n.name == 'text' }.select { |n| n.at_css('div') }
        
        if sub_sections.any? && text_divs.any?
          subclauses = false
          kids.each do |k|
            subclauses = subclauses || k.name == 'section'
            next unless subclauses
            if k.name == 'text'
              next if k.text.strip.empty?
              puts s
              puts '*******************'
              puts k
              raise "Text after Section!"
            end
          end
        end
        
        if text_divs.size > 1
          puts s
          puts '_______________'
          text_divs.each do |tv|
            puts tv
            puts '^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^'
          end
          raise Rainbow("Too many text divs!").red
        end
        content_from_div = process_content_div(text_divs.first&.at_css('div'))
        if content_from_div
          ChangeTracker.start
          content_from_div.each { |cfd| clause.add_content(cfd) }
          ChangeTracker.commit
        end
                
        if sub_sections.any?
          sub_clauses = parse_sections(sub_sections)
          ChangeTracker.start
          sub_clauses.each { |sub_section| clause.add_content(sub_section) }          
          ChangeTracker.commit
        end
        
        returned_content << clause
      
      when 'segment-definition', 'datatype-definition'
        # title  = s.at_css('title').attr('value')
        ChangeTracker.start
        ref = V2Web::Reference.new
        ref.render_as = type
        ref.save
        ChangeTracker.commit
        url = s.at_css('entry reference').attr('value')
        obj = registry[map_type(type)][url]
        if obj
          ChangeTracker.start
          ref.ref = obj
          ChangeTracker.commit
          if s.children.map(&:name).include?('section')
            puts s
            raise "#{type} has children!"
          end
        else
          if url =~ /segment-usage-in-vaccine-messages/
            obj = HL7::SegmentDefinition.new(name:'FIXME: Segment Usage In Vaccine Messages', code:'RXA1FIXME')
            registry[obj.class][url] = obj
          else
            raise "No obj for #{url}" 
          end
        end
        returned_content << ref
      else
        puts s
        raise "#{type} is not yet handled"
      end
    end
    returned_content.any? ? returned_content : nil      
  end
  
  def process_content_div(xml)
    return nil unless xml
    content = []
    paragraphs = []
    xml.children.each do |node|
      css = remove_v2_from_node_css!(node)
      case node.name
      when 'text'
        t = node.text.strip
        if t[0]
          puts t
          raise "text node not empty"
        end
      when 'p'
        paragraph = '<p'
        if css.any?
          paragraph << ' class="' + css.join(' ')
        end
        paragraph << '">' + node.text + '</p>'
        paragraphs << paragraph
      when 'ul', 'ol', 'table', 'br'
        paragraphs << node.to_html
      when 'div'
        content << text_section(paragraphs.join("\n")) if paragraphs.any?
        paragraphs = []
        case css.first
        when 'insert-msg-table'
          content << reference_message_table(node)
          # puts node; raise "What to do with #{css.inspect}"
        when 'v2-note'
          note_css = css - ['v2-note']
          puts Rainbow("Note had #{note_css}").orange if note_css.any?
          content << note_section(node.children)
          # puts node; raise "What to do with #{css.inspect}"
        when 'v2-image'
          content << parse_image(node) # returns a V2Web::Figure
        else
          puts node; raise "What to do with #{css.inspect}"
        end
      else
        puts xml
        puts Rainbow("Don't know how to process this kind of element: #{node.name}").yellow
        puts node
        raise "oops"
      end
    end
    content << text_section(paragraphs.join("\n")) if paragraphs.any?
    content
  end

  def chapter_name(node)
    parent = node.parent
    if parent.is_a?(Nokogiri::XML::Document)
      parent.at_css('Composition title').attr('value')
    else
      chapter_name(parent)
    end
  end

  def parse_image(node)
    img = node.at_css('img')
    src = img['src']
    type, bin_data = src.split(';base64,')
    type = type.split('/').last
    bin_data.strip!
    ch = chapter_name(node)
    ChangeTracker.start
    bd   = GBP::BinaryData.new(data:bin_data)
    fn = "#{ch}-#{image_counter}.#{type}"
    puts fn
    file = GBP::File.new(filename:fn, mime_type:'image/' + type)
    file.binary_data = bd
    fig = V2Web::Figure.new
    fig.file = file
    # fig.caption = ???
    ChangeTracker.commit
    fig
  end

  # WARNING this changes the classes of the node
  def remove_v2_from_node_css!(node)
    css = node.attr('class')&.split(/\s/)&.reject { |v| v == 'v2' }
    node['class'] = css&.[](0) ? css.join(' ') : nil
    css
  end
  
  def reference_message_table(node)
    code = node.text.split('^')[0..1].join('_')
    # Hacks to handle irregular cases
    code =  case code
            when 'ACK_varies'
              'ACK'
            else
              code
            end
            
    msgs = V2::Message.where(code:code).all
    return create_reference(msgs.first, 'message table') if msgs.size == 1
    if msgs.size > 1
      puts "Multiple messages for #{code}"
      puts msgs.inspect
      raise
    end
    # Hacks to fix stuff
    case code
    when 'QBP_Znn'
      msg = create_qbp_znn
      return create_reference(msg, 'message table')
    when 'RDY_Znn'
      msg = get_rdy_znn
      return create_reference(msg, 'message table')
    when 'RSP_Znn'
      msg = get_rsp_znn
      return create_reference(msg, 'message table')
    end
    
    puts Rainbow("No message with code #{code}").orange
    raise
  end
  
  # FIXME based on ellipses issue
  def get_rsp_znn
    msg = V2::Message.where(Sequel.ilike(:name, 'RSP^Znn%')).first
    if msg.structure.code == 'RTB_Knn'
      # FIXME...create a new structure w/ code RSP_Znn.  Only difference with RTB_Knn is that ellipses has square brackets (i.e., is optional)
    end
    # puts struct.simple_render
    # raise 'nope'
    # ack = msg.acknowledgment_choreography
    # puts ack.inspect
    # puts ack.original_acks.map(&:code).inspect
    # puts ack.msh15_acks.map(&:code).inspect
    # puts ack.msh16_acks.map(&:code).inspect
    return msg
  end
  
  def get_rdy_znn
    msg = V2::Message.where(Sequel.ilike(:name, 'RDY^Znn^RDY_K15%')).first
    ChangeTracker.start
    msg.code = 'RDY_Znn'
    msg.save
    ChangeTracker.commit
    msg
  end
  
  def create_qbp_znn
    generic_ack = V2::Message.where(code:'ACK').first
    ChangeTracker.start
    qbp_znn = V2::Message.new(code:'QBP_Znn', name:"QBP^Znn^QBP_Qnn: Query Grammar: QBP Message")
    rtb_znn = V2::Message.new(code:'RTB_Znn', name:"RTB^Znn^RTB_Knn: Response Grammar: Widget Dispense Message")
    qbp_qnn = V2::MessageStructure.where(code:"QBP_Qnn").first
    rtb_knn = V2::MessageStructure.where(code:"RTB_Knn").first
    qbp_znn.structure = qbp_qnn
    rtb_znn.structure = rtb_knn
    
    qbp_ack = HL7::AcknowledgmentChoreography.new(ack_immediate:false, imm_ack_name:'ACK^Znn^ACK')
    qbp_ack.add_original_ack(rtb_znn)
    qbp_ack.add_msh15_ack(generic_ack)
    qbp_ack.msh16 = 'AL'
    qbp_ack.add_msh16_ack(rtb_znn)
    qbp_ack.save
    qbp_znn.acknowledgment_choreography = qbp_ack
    
    rtb_ack = HL7::AcknowledgmentChoreography.new(ack_immediate:false, imm_ack_name:'ACK^Znn^ACK')
    # rtb_ack.add_original_ack(FIXME) # there is nothing in the standard for original mode ack message
    rtb_ack.add_msh15_ack(generic_ack)
    rtb_ack.msh16 = 'AL'
    # rtb_ack.add_msh16_ack(FIXME) # there is nothing in the standard for enhanced mode ack message
    rtb_ack.save
    rtb_znn.acknowledgment_choreography = rtb_ack
    rtb_znn.save
    ChangeTracker.commit
    qbp_znn
  end
  
  def create_reference(obj, rendering)
    ChangeTracker.start
    ref = V2Web::Reference.new
    ref.render_as = rendering
    ref.ref = obj
    ref.save
    ChangeTracker.commit
    ref
  end
  
  def _text_section(content, type)
    ChangeTracker.start
    t = type.new
    t.content = Gui_Builder_Profile::RichText.create(:content => content)
    t.save
    ChangeTracker.commit
    t
  end
  
  def text_section(content)
    _text_section(content, V2Web::Text)
  end
   
  def note_section(nodes)
    content = []
    nodes.each do |n|
      remove_v2_from_node_css!(n)
      content << n.to_html
    end
    _text_section(content.join("\n"), V2Web::Note)
  end
  
  def example_section(content)
    _text_section(content, V2Web::Example)
  end
  
  def map_type(type)
    case type
    when 'segment-definition'
      HL7::SegmentDefinition
    when 'datatype-definition'
      HL7::DataType
    else
      raise 'Cannot map ' + type
    end
  end
  
  def parse_dt
    folder = fhir_folder + 'data_types'
    files  = Dir[folder + '/*']
    files.each do |file|
      doc = File.open(file) { |f| Nokogiri::XML(f) }
      xml = doc.css('DataTypeDefinition')
      # hash = XmlSimple.xml_in(file, { 'KeyAttr' => 'name' })
      # pp hash
      url  = xml.at_css('url').attr('value')
      name = xml.at_css('name').attr('value')
      abbr = xml.at_css('abbreviation').attr('value')
      # puts abbr
      objs = HL7::DataType.where(code:abbr).all
      obj = objs.first if objs.size == 1
      raise "#{objs.size} entries in DB for DataType #{abbr} - #{name}" unless obj
      registry[obj.class] ||= {}
      registry[obj.class][url] = obj
      components = xml.css('component')
      puts Rainbow('Components size different for ' + abbr).red unless obj.components_count == components.size
      div = xml.at_css('description div')
      withdrawn = xml.at_css('withdrawn').attr('value')
    end
  end
  
  def parse_de
    folder = fhir_folder + 'data_elements'
    files  = Dir[folder + '/*']
    files.each do |file|
      doc = File.open(file) { |f| Nokogiri::XML(f) }
      xml = doc.css('DataElementDefinition')
      # hash = XmlSimple.xml_in(file, { 'KeyAttr' => 'name' })
      # pp hash
      url  = xml.at_css('url').attr('value')
      name = xml.at_css('name').attr('value')
      num  = xml.at_css('itemNumber').attr('value')
      # puts num
      objs = HL7::DataElement.where(item_number:num).all
      obj = objs.first if objs.size == 1
      raise "#{objs.size} entries in DB for DataElement #{num} - #{name}" unless obj
      registry[obj.class] ||= {}
      registry[obj.class][url] = obj
      # div = xml.at_css('description div')
    end
  end
  
  def parse_segdefs
    folder = fhir_folder + 'segment_definitions'
    files  = Dir[folder + '/*']
    files.each do |file|
      doc = File.open(file) { |f| Nokogiri::XML(f) }
      xml = doc.css('SegmentDefinition')
      # hash = XmlSimple.xml_in(file, { 'KeyAttr' => 'name' })
      # pp hash
      url  = xml.at_css('url').attr('value')
      name = xml.at_css('name').attr('value')
      abbr = xml.at_css('abbreviation').attr('value')
      # puts abbr
      objs = HL7::SegmentDefinition.where(code:abbr).all
      obj = objs.first if objs.size == 1
      raise "#{objs.size} entries in DB for DataElement #{num} - #{name}" unless obj
      registry[obj.class] ||= {}
      registry[obj.class][url] = obj
      fields = xml.css('field')
      puts Rainbow('Field size different for ' + abbr).red unless obj.fields_count == fields.size
      div = xml.at_css('description div')
      withdrawn = xml.at_css('withdrawn').attr('value')
    end
  end
  
  def parse_msg_structures
    folder = fhir_folder + 'message_structures'
    files  = Dir[folder + '/*']
    files.each do |file|
      doc = File.open(file) { |f| Nokogiri::XML(f) }
      xml = doc.css('MessageStructure')
      # hash = XmlSimple.xml_in(file, { 'KeyAttr' => 'name' })
      # pp hash
      url  = xml.at_css('url').attr('value')
      # name = xml.at_css('name').attr('value')
      code = xml.at_css('messageType').attr('value')
      objs = V2::MessageStructure.where(code:code).all
      obj = objs.first if objs.size == 1
      segs = xml.children.select { |n| n.name == 'segmentEntry' }
      if obj
        unless obj.segments_count == segs.size
          puts Rainbow('Segment size different for ' + code).red
          puts Rainbow('Existing').yellow
          obj.simple_render
          alt_obj = recreate_msg_structure(segs, code)
          puts Rainbow('From FHIR').cyan
          alt_obj.simple_render
        end
      else
        ChangeTracker.start
        obj = recreate_msg_structure(segs, code)
      end
      registry[obj.class] ||= {}
      registry[obj.class][url] = obj
    end
  end
  
  def parse_msgs
    folder = fhir_folder + 'messages'
    files  = Dir[folder + '/*']
    files.each do |file|
      doc = File.open(file) { |f| Nokogiri::XML(f) }
      xml = doc.css('MessageDefinition')
      url  = xml.at_css('url').attr('value')
      name = xml.at_css('name').attr('value')
      # code = xml.at_css('code').attr('value')
      code = url.split('/').last.upcase.gsub('-', '_')
      # objs = V2::Message.where(code:code).all
      # objs = V2::Message.where(name:name).all
      # obj = objs.first if objs.size == 1
      # puts Rainbow("Found Message #{code} - #{name}").green if obj
      # if objs.size > 1# && code != 'ACK'
      #   puts xml
      #   pp objs
      #   raise "#{objs.size} entries in DB for Message #{code} - #{name}"
      # end
      obj = recreate_msg(xml, code, name)
      registry[obj.class] ||= {}
      registry[obj.class][url] = obj
    end
  end

  def fix_msgs
    folder = fhir_folder + 'messages'
    files  = Dir[folder + '/*']
    files.each do |file|
      doc = File.open(file) { |f| Nokogiri::XML(f) }
      xml = doc.css('MessageDefinition')
      url  = xml.at_css('url').attr('value')
      name = xml.at_css('name').attr('value')
      # code = xml.at_css('code').attr('value')
      code = url.split('/').last.upcase.gsub('-', '_')
      # objs = V2::Message.where(code:code).all
      objs = V2::Message.where(name:name).all
      obj = objs.first if objs.size == 1
      if obj
        # puts Rainbow("Found Message #{code} - #{name}").green
        puts xml; return
      else
        puts Rainbow("No Message obj for #{code} - #{name}").red
      end

      # if objs.size > 1# && code != 'ACK'
      #   puts xml
      #   pp objs
      #   raise "#{objs.size} entries in DB for Message #{code} - #{name}"
      # end
    end
  end

  def parse_acks
    folder = fhir_folder + 'acknowledgment_choreographies'
    files  = Dir[folder + '/*']
    files.each do |file|
      doc = File.open(file) { |f| Nokogiri::XML(f) }
      xml = doc.css('AcknowledgmentChoreography')

      subj = xml.at_css('subject').attr('value')
      msg  = registry[V2::Message][subj]
      if msg
        ack = msg.acknowledgment_choreography
        if ack
          # Do Nothing?
        else
          # puts Rainbow("No ACK for #{msg.code}").magenta
          ack = recreate_ack(xml, msg.code)
          ChangeTracker.start
          msg.acknowledgment_choreography = ack
          ChangeTracker.commit
        end
      else
        # Problem is bigger than this method can handle.
      end
    end
  end
  
  def lookup_msg(url)
    msg = registry[V2::Message][url]
    puts Rainbow("No Message for #{url}").red unless msg
    msg
  end

  def lookup_msg_structure(url)
    msgstruct = registry[V2::MessageStructure][url]
    puts Rainbow("No MessageStructure for #{url}").red unless msgstruct
    msgstruct
  end

  def recreate_msg(xml, code, name)
    ChangeTracker.start
    msg = V2::Message.new(code:code, name:name)
    msg.structure = lookup_msg_structure(xml.at_css('structure').attr('value'))
    msg.save
    ChangeTracker.commit
    # puts "Created Message #{code}"
    msg
  end
  
  def recreate_ack(xml, for_code)
    oatype = xml.at_css('originalModeAckType').attr('value')
    oaurls = xml.css('originalModeAcknowledgement').map { |n| n.attr('value') }
    msh15  = xml.css('msh15AllowedValue').map { |n| n.attr('value') }.sort.join
    msh16  = xml.css('msh16AllowedValue').map { |n| n.attr('value') }.sort.join
    eiurls = xml.css('enhancedModeImmediateAcknowledgment').map { |n| n.attr('value') }
    eaurls = xml.css('enhancedModeApplicationAcknowledgment').map { |n| n.attr('value') }
    ChangeTracker.start
    ack = HL7::AcknowledgmentChoreography.new
    ack.ack_immediate = oatype == 'immediate'
    if msh15 == 'ALERSU'
      # ack.msh15 = 'Always'
    elsif msh15 == 'NE'
      ack.msh15 = 'Never'
    elsif msh15 == 'AL'
      ack.msh15 = 'Always'
    else
      puts Rainbow("Ack MSH15 for #{for_code} is: #{msh15}")
    end
    if msh16 == 'ALERSU'
      # ack.msh16 = 'Always'
    elsif msh16 == 'NE'
      ack.msh16 = 'Never'
    elsif msh16 == 'AL'
      ack.msh16 = 'Always'
    else
      puts Rainbow("Ack MSH16 for #{for_code} is: #{msh16}")
    end
    oaurls.each { |url| ack.add_original_ack(lookup_msg(url)) }
    eiurls.each { |url| ack.add_msh15_ack(lookup_msg(url)) }
    eaurls.each { |url| ack.add_msh16_ack(lookup_msg(url)) }
    ack.save
    ChangeTracker.commit
    ack
  end
  
  def recreate_msg_structure(segs, code)
    ChangeTracker.start
    obj = V2::MessageStructure.new(code:code)
    obj.save
    ChangeTracker.commit
    segs.each do |seg|
      seg_obj = reparse_seg(seg)
      ChangeTracker.start
      obj.add_segment(seg_obj)
      ChangeTracker.commit
    end
    obj
  end
  
  def reparse_seg(xml)
    rep = xml.at_css('mayRepeat').attr('value') != 'false'
    opt = xml.at_css('optional').attr('value')  != 'false'
    any = xml.at_css('anyHl7Segment').attr('value')  != 'false'
    status = xml.at_css('status')&.attr('value')
    
    seq = xml.at_css('sequence')
    if seq
      reparse_seg_seq(seq, rep, opt, any, status)
    else
      choice = xml.at_css('choice')
      if choice
        reparse_seg_choice(choice, rep, opt, any, status)
      else
        example = xml.at_css('exampleSegment')
        if example
          reparse_example_seg(example)
        else
          recreate_seg(xml, rep, opt, any, status)
        end
      end
    end
  end
  
  def recreate_seg(xml, rep, opt, any, status)
    url   = xml.at_css('segment').attr('value')
    paras = xml.css('description div p')
    if paras.size > 1
      puts Rainbow(paras).yellow;puts
    end
    desc = paras.text
    segdef = @registry[HL7::SegmentDefinition][url]
    raise "No segdef for #{url}" unless segdef
    ChangeTracker.start
    segment = HL7::Segment.new(repeat:rep, optional:opt, status:status, description:desc)
    segment.type = segdef
    ChangeTracker.commit
    segment
  end
  
  def reparse_seg_list(xml, rep, opt, any, status, type)
    ChangeTracker.start
    obj = type.new(repeat:rep, optional:opt, status:status)
    name = xml.at_css('name')&.attr('value')
    if name
      obj.name = name
    else
      # puts "No name for:"
      # puts xml
    end 
    obj.save
    ChangeTracker.commit
    segs = xml.children.select { |n| n.name == 'segmentEntry' }
    segs.each do |seg|
      seg_obj = reparse_seg(seg)
      ChangeTracker.start
      obj.add_segment(seg_obj)
      ChangeTracker.commit
    end
    obj
  end
  
  def reparse_seg_seq(xml, rep, opt, any, status)
    reparse_seg_list(xml, rep, opt, any, status, HL7::SegmentSequence)
  end
  
  def reparse_seg_choice(xml, rep, opt, any, status)
    reparse_seg_list(xml, rep, opt, any, status, HL7::SegmentChoice)
  end
  
  def reparse_example_seg(xml)
    ChangeTracker.start
    obj = HL7::ExampleSegment.new
    obj.name = xml.at_css('name').attr('value')
    obj.save
    ChangeTracker.commit
    obj
  end
  
  def go
    @registry = nil
    parse_dt
    parse_de
    parse_segdefs
    parse_msg_structures

    clear_msgs_acks_events

    parse_msgs
    parse_acks
    parse_compositions
  end
end
def getmsg(code)
  V2::Message.where(code:code).first
end
def getstruct(code)
  V2::MessageStructure.where(code:code).first
end
# Reparse.go
Reparse.fix_msgs