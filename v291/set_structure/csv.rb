module V291
  module Structure
    module_function
  
    def full
      File.expand_path('V2+ Chapter Structure - SiteMap.csv', __dir__)
    end
  
    def test
      File.expand_path('V2+ Chapter Structure - SiteMapTest.csv', __dir__)
    end
  
    def minitest
      File.expand_path('V2plusStructureTest - Test1.csv', __dir__)
    end
  end
  
end
