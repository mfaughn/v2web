module V2Plus
  class TabSet
    attr_accessor :tabs
    attr_reader   :html_id
    def initialize(html_id)
      @html_id = html_id
      @tabs    = []
    end
    def add_tab(tab)
      tab.tabset = self
      @tabs << tab
    end
  
    def to_composition_content
      tabs_data = []
      tabs.each_with_index { |tab, index| tabs_data << tab.to_composition_content(index) }
      tabs_labels  = tabs_data.map { |tab| tab[:label] }.join("\n")
      tabs_content = tabs_data.map { |tab| tab[:content] }.join("\n")
      locals = {
        :tabs_id      => html_id,
        :tabs_content => tabs_content,
        :tabs_labels  => tabs_labels
      }
      V2Plus.render_with_locals(:web_elements, :tabs, locals)
    end
    
  end # class TabSet

  class Tab
    attr_accessor :tabset
    def initialize(label, content)
      @content = content
      @label   = label
    end
    
    def to_composition_content(index)
      # tabset_id = tabset.html_id
      # code_type = type&.value
      # tab_index = index == 0 ? '0' : '-1'
      # selected  = index == 0 ? 'true' : 'false'
      tab_content_id = tabset.html_id + '-folder-' + (index + 1).to_s
      # tab_label_id   = tabset_id + '-label'  + (index + 1).to_s
      # tab_url        = location + '#' + tab_content_id
      # tab_file_url = nil
      # # the file property of the Tab object supercedes any content that the Tab object has
      # # FIXME maybe it should be the other way around.
      # if file
      #   data = file.binary_data&.data
      #   tab_content = data&.force_encoding(Encoding::UTF_8)
      #   tab_file_url = file.filename
      #   V2Web.create_download_file(data, tab_file_url, root_dir)
      #   code_type ||= file.filename.split('.').last.upcase
      # elsif
      #   raise 'only files are supported for tabs at this time'# FIXME...other kind of content used
      # end
      
      locals = {
        # :tabs_id        => tabset_id,
        :tab_title      => @label,
        # :tab_index      => tab_index,
        # :selected       => selected,
        :tab_content_id => tab_content_id,
        # :tab_label_id   => tab_label_id,
        # :tab_url        => tab_url,
        :tab_content    => @content,
        # :tab_content_inner_id => (tab_content_id + '-inner')
      }
      # content_html = case
      # when code_type =~ /XML|XSD|FHIR Structure Definition/
      #   V2Plus.render_with_locals(:message, :tab_content_xml, locals)
      # when code_type =~ /Message|HTML/ # FIXME for now, this is an HTML table pasted in just for demonstration purposes
      #   V2Plus.render_with_locals(:message, :tab_content, locals)
      # when code_type =~ /ER7/
      #   # FIXME
      # when code_type =~ /JPG|PNG|GIF/
      #   fn = File.join(root_dir, 'images', tab_content_id + '_' + file_filename)
      #   File.open(fn, "w+b") { |file| file.puts tab_content }
      #   locals[:img_src] = fn
      #   V2Plus.render_with_locals(:message, :tab_content_image, locals)
      # else
      #   V2Plus.render_with_locals(:message, :tab_content, locals)
      # end
      content_html = V2Plus.render_with_locals(:web_elements, :tab_content, locals)
      label_html   = V2Plus.render_with_locals(:web_elements, :tab_label, locals)
      {:content => content_html, :label => label_html}
    end
  end # class Tab
end