module V2Web
  class TabSet
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      'TabSet: ' + (title ? title : tabs.map(&:type).map(&:value).join(', '))
    end
  
    # tab_set_index working correctly is dependent on there being only one tabset per section
    def hl7_page_content(parent, root_dir, link, tab_set_index)
      tabs_id = (link.sub('.html', '')) + '-tab_set' + parent.number.gsub('.', '-')
      tabs_data = []
      tabs.each_with_index { |tab, index| tabs_data << tab.to_hl7_site(tabs_id, index, root_dir, link) }
      tabs_labels  = tabs_data.map { |tab| tab[:label] }.join("\n")
      tabs_content = tabs_data.map { |tab| tab[:content] }.join("\n")
      locals = {:tabs_id => tabs_id, :tabs_content => tabs_content, :tabs_labels => tabs_labels}
      set = V2Web.render_with_locals(:tabs, locals)
      set
    end
    
    def configure(config, tab_files)
      old_tabs = tabs
      # FIXME this is expediant but may leave a lot of cruft if it doesn't crush the old content
      if old_tabs.any?
        ChangeTracker.start
        old_tabs.each { |tab| tab.destroy }
        ChangeTracker.commit
      end
      new_tabs = []
      config.children.select{ |c| c.name == 'tab' }.each do |tab_config|
        puts Rainbow(tab_config).yellow
        f = tab_files[tab_config['file']]
        puts Rainbow(f.pretty_inspect).green
        gbp_file = V2Web.make_gbp_file(f)
        ChangeTracker.start
        t = V2Web::Tab.create(:title => tab_config['title'])
        raise unless f
        t.file = gbp_file
        t.save
        ChangeTracker.commit
        new_tabs << t
      end
      ChangeTracker.start
      self.tabs = new_tabs
      save
      ChangeTracker.commit
    end
  
    # def set_number(parent)
    #   parent.subsets.select { |ss| ss.is_a?(WebDoc::TabSet) }.index { |ss| ss.id == id }
    # end
    # def hl7_page_content(parent)
    #   tabs_id = parent.url_title + 'tab_set' + set_number(parent)
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
      code_type = type&.value
      tab_index = index == 0 ? '0' : '-1'
      selected  = index == 0 ? 'true' : 'false'
      tab_content_id = parent_id + '-folder' + (index + 1).to_s
      tab_label_id   = parent_id + '-label'  + (index + 1).to_s
      tab_url = location + '#' + tab_content_id
      tab_file_url = nil
      # the file property of the Tab object supercedes any content that the Tab object has
      # FIXME maybe it should be the other way around.
      if file
        data = file.binary_data&.data
        tab_content = data&.force_encoding(Encoding::UTF_8)
        tab_file_url = file.filename
        V2Web.create_download_file(data, tab_file_url, root_dir)
        code_type ||= file.filename.split('.').last.upcase
      elsif
        raise 'only files are supported for tabs at this time'# FIXME...other kind of content used
      end
      
      locals = {:tabs_id => parent_id, :tab_title => code_type, :tab_index => tab_index, :selected => selected, :tab_content_id => tab_content_id, :tab_label_id => tab_label_id, :tab_url => tab_url, :tab_content_inner_id => (tab_content_id + '-inner'), :tab_content => tab_content}
      locals[:tab_file_url] = tab_file_url if tab_file_url
    
      content_html = case
      when code_type =~ /XML|XSD|FHIR Structure Definition/
        V2Web.render_with_locals(:tab_content_xml, locals)
      when code_type =~ /Message|HTML/ # FIXME for now, this is an HTML table pasted in just for demonstration purposes
        V2Web.render_with_locals(:tab_content, locals)
      when code_type =~ /ER7/
        # FIXME
      when code_type =~ /JPG|PNG|GIF/
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
