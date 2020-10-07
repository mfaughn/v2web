module FHIR2Obj

  class AcknowledgmentChoreography
    attr_accessor :url, :code, :segments
    
    def initialize(data)
      pp data
      # @code    = data['messageType'].first['value']
      @url     = data['url'].first['value']
      FHIR2Obj.registry[:acks][@url][:obj] = self
      # @segments = data['segmentEntry']&.map { |se| FHIR2Obj.create_segment(se) }
    end
  end
  
end
