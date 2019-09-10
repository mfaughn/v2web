module WebDoc
  class Level
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      groups.map { |g| g.identifying_text }.join(' & ')
    end
  end
  
  class LevelGroup
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      doc&.title || 'No Document Associated'
    end
  end
  
  class Section
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      doc&.title || 'No Document Associated'
    end
  end
end
