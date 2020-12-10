module SectionMethods
  def to_composition_section
    xml = HL7.get_instance_template(:composition, 'section')
    xml.sub!('TITLE', CGI.escapeHTML(title))
    xml.sub!('CODE', code)
    xml.sub!('TEXT', resource_text)
    xml.sub!('ENTRY', resource_entry) # FIXME do we actually need to put something here? When?
    xml.sub!('EMTPY_REASON', '') # FIXME do we actually need to put something here? When?
    sections_xml = []
    sections.each { |ss| sections_xml << ss.to_composition_section }
    xml.sub!('SECTIONS', sections_xml.join)
    # puts xml;puts '*********************************************************'
    # nxml = Nokogiri::XML(xml) { |config| config.strict.noblanks }.root.to_s
    # if title =~ /Message construction rules/
    #   puts xml.gsub(/^$\s*\n/, '');puts '*********************************************************'
    # end
    err = Nokogiri::XML(xml).errors
    if err.any?
      puts xml
      puts err
      raise
    end
    xml
  end
  
  def resource_entry
    return '' unless entry
    xml = HL7.get_instance_template(:composition, 'entry')
    xml.gsub('VALUE', entry)
  end
  
  def resource_text
    html = text&.div&.content
    # puts Rainbow(html).yellow if html =~ /GROUP2/
    return '' unless html&.[](0) # return empty string unless there is a non-empty narrative
    nhtml = Nokogiri::HTML.fragment(html) {|config| config.noblanks.noent }.to_xml # .html_entity_code_to_entity_number
    # puts Rainbow(nhtml).cadetblue if nhtml =~ /GROUP2/
    xml = HL7.get_instance_template(:composition, 'narrative')
    xml.sub('VALUE', nhtml)
  end
end
