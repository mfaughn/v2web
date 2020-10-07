module FHIR2Obj

  class MessageStructure  
    attr_accessor :url, :code, :segments
    
    def initialize(data)
      @code    = data['messageType'].first['value']
      @url     = data['url'].first['value']
      FHIR2Obj.registry[:message_structures][@url][:obj] = self
      @segments = data['segmentEntry']&.map { |se| FHIR2Obj.create_segment(se) }
    end
  end
  
end
