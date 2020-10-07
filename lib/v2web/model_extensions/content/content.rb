module V2Web
  class Content
    def reference_url
      relative_url(guess_link_root.relative_url)
    end
    
    def relative_url(base_url)
      "#{base_url}##{html_id}"
    end

    # depth first...much less than an ideal way to determine this stuff.  completely unreliable if there are multiple parents
    def guess_link_root(from = parents)
      return nil unless parents.any?
      from.find { |parent| parent.is_a?(V2Web::Section) && parent.render_as&.value == 'linked_page' } || guess_link_root(from.map(&:parents).flatten.compact)
    end
    
  end
end
