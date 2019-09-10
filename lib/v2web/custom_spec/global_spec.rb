global_spec_modifier do |view|
  kontent = view.content
  view_classifier = view.data_classifier
  content_index = nil
  kontent.each do |w|
    if w.is_a?(Gui::Widgets::Text) && w.getter.to_s == 'content'
      content_index = kontent.index(w)
    end
  end
  if content_index
    kontent.delete_at(content_index)
    view.ckeditor('content', :label => 'Content')
    view.reorder('content', :to_beginning => true)
  end
end
