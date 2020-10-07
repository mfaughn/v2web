module FHIR2Obj
  class DataType  
    attr_accessor :name, :abbreviation, :withdrawn, :description, :components, :url
    
    def initialize(data)
      @name         = data['name'].first['value']
      @abbreviation = data['abbreviation'].first['value']
      @withdrawn    = data['withdrawn'].first['value']
      @description  = data['description']
      @url          = data['url'].first['value']
      FHIR2Obj.registry[:data_types][@url][:obj] = self
      @components   = data['component']&.map { |c| Component.new(c) }
    end
    
  end
end
