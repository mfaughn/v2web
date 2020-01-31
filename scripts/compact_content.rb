module V2Web
  class DocXtractor
        
    def compact_content(section)
      replacement = []
      orphans     = []
      current = nil
      section.content.each do |c|
        case c.class.name
        when 'V2Web::Text'
          if current
            merge_content(current, c)
            orphans << c
          else
            replacement << c
            current = c
          end
        when 'V2Web::Section'
          current = nil
          replacement << compact_content(c)
        else
          current = nil
          replacement << c
        end
      end
      ChangeTracker.start
      orphans.each { |o| o.destroy }
      rclasses = replacement.collect { |x| x.class }.reject { |x| x =~ /V2Web/ }
      # if rclasses.any?
      #   pp replacement
      #   puts section.inspect
      # end
      section.content = replacement
      section.save
      ChangeTracker.commit
      section
    end
    
    def merge_content(collector, donor)
      text = collector.content.content + donor.content.content
      ChangeTracker.start
      collector.content = Gui_Builder_Profile::RichText.create(:content => text)
      collector.save
      ChangeTracker.commit
    end
    
  end # class DocXtractor
end # module V2Web