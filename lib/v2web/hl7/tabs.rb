# TabSet
# tabs_id
# tabs_labels
# tabs_content
#
# Tabs
# tab_title
# tab_id
# tab_label_id
# tab_content_id
# tab_content
# tab_content_inner_id
# selected - 'true' if first tab, else 'false'
# tab_index - '0' if selected (i.e. first), else '-1'
# tab_url - same as tab_content_id, prepended w/ octothorpe
require_relative 'tabs'
module WebDoc
  
  class TabSet
    def set_number(parent)
      parent.subsets.select { |ss| ss.is_a?(WebDoc::TabSet) }.index { |ss| ss.id == id }
    end
    def hl7_page_content(parent)
      tabs_id = parent.doc.link_title + 'tab_set' + set_number(parent)
      tabs_data = tabs.map { |t| t.to_hl7_site }
      tabs_labels = tabs_data.map { |t| t[:label] }
      tabs_content = tabs_data.map { |t| t[:content] }
      locals = {:tabs_id => tabs_id, :tabs_content => tabs_content, :tabs_labels => tabs_labels}
      set = HL7Site.render_with_locals(:tabs, locals)
    end
  end
  
  class Tab
    def to_hl7_site
    end
  end
  
end
