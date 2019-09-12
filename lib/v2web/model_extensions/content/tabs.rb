module V2Web
  class TabSet
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      tabs.map(&:type).map(&:value).join(', ')
    end
  
    def hl7_page_content(parent, root_dir, link, tab_set_index)
      tabs_id = (link.sub('.html', '')) + '-tab_set' + tab_set_index.to_s
      tabs_data = []
      tabs.each_with_index { |tab, index| tabs_data << tab.to_hl7_site(tabs_id, index, root_dir, link) }
      tabs_labels  = tabs_data.map { |tab| tab[:label] }.join("\n")
      tabs_content = tabs_data.map { |tab| tab[:content] }.join("\n")
      locals = {:tabs_id => tabs_id, :tabs_content => tabs_content, :tabs_labels => tabs_labels}
      set = V2Web.render_with_locals(:tabs, locals)
    end
  
    # def set_number(parent)
    #   parent.subsets.select { |ss| ss.is_a?(WebDoc::TabSet) }.index { |ss| ss.id == id }
    # end
    # def hl7_page_content(parent)
    #   tabs_id = parent.doc.link_title + 'tab_set' + set_number(parent)
    #   tabs_data = tabs.map { |t| t.to_hl7_site }
    #   tabs_labels = tabs_data.map { |t| t[:label] }
    #   tabs_content = tabs_data.map { |t| t[:content] }
    #   locals = {:tabs_id => tabs_id, :tabs_content => tabs_content, :tabs_labels => tabs_labels}
    #   set = V2Web.render_with_locals(:tabs, locals)
    # end
  end # class TabSet

  class Tab
    def to_hl7_site(parent_id, index, root_dir, link)
      location  = File.join(root_dir, link)
      code_type = type.value
      tab_index = index == 0 ? '0' : '-1'
      selected  = index == 0 ? 'true' : 'false'
      tab_content_id = parent_id + '-folder' + (index + 1).to_s
      tab_label_id   = parent_id + '-label'  + (index + 1).to_s
      tab_url = location + '#' + tab_content_id
      # code in the code property of the Tab object supercedes any file that the Tab object has
      # FIXME maybe it should be the other way around.  if it is an image file we definitely want that and no goop that may be in @code
      tab_content = code.content
      if (tab_content.nil? || tab_content.strip.empty?) && file
        tab_content = file.binary_data&.data
      end
      if (tab_content.nil? || tab_content.strip.empty?)
        tab_content = 'Content Missing'
      end
      locals = {:tabs_id => parent_id, :tab_title => code_type, :tab_index => tab_index, :selected => selected, :tab_content_id => tab_content_id, :tab_label_id => tab_label_id, :tab_url => tab_url, :tab_content_inner_id => (tab_content_id + '-inner'), :tab_content => tab_content}
    
      content_html = case
      when code_type =~ /XML|XSD|FHIR Structure Definition/
        V2Web.render_with_locals(:tab_content_xml, locals)
      when code_type =~ /Message/ # FIXME for now, this is an HTML table pasted in just for demonstration purposes
        V2Web.render_with_locals(:tab_content, locals)
      when code_type =~ /ER7/ # FIXME for now, this is an image file -- just for demonstration purposes
        fn = File.join(root_dir, 'images', tab_content_id + '_' + file_filename)
        File.open(fn, "w+b") { |file| file.puts tab_content }
        locals[:img_src] = fn
        V2Web.render_with_locals(:tab_content_image, locals)
      else
        V2Web.render_with_locals(:tab_content, locals)
      end
      label_html = V2Web.render_with_locals(:tab_label, locals)
      {:content => content_html, :label => label_html}
    end
  end # class Tab
end
