module V2Web
  class Code
    derived_attribute(:identifying_text, ::String)
    def identifying_text
      title
    end
  end
end
