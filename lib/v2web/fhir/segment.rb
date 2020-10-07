module FHIR2Obj
  def self.create_segment(data)
    if data['segment']
      Segment.new(data)
    elsif data['sequence']
      SegmentSequence.new(data)
    elsif data['choice']
      SegmentChoice.new(data)
    elsif data['exampleSegment']
      ExampleSegment.new(data)
    else
      puts data.keys
      raise
    end
  end
  
  class AbstractSegment
    attr_accessor :repeat, :optional, :status, :any_hl7_segment
    def initialize(data)
      @repeat   = data['mayRepeat']&.first&.[]('value') == true
      @optional = data['optional']&.first&.[]('value')
      @status   = data['status']&.first&.[]('value')
      @any_hl7_segment = data['anyHl7Segment']&.first&.[]('value')
    end
  end
  
  class Segment < AbstractSegment
    attr_accessor :description, :definition
    def initialize(data)
      super(data)
      @description  = data['description']
      seg_url = data['segment']&.first&.[]('value')
      if seg_url
        @definition = FHIR2Obj.get_segement_definition(seg_url)
        raise "No segment definitions for #{seg_url}" unless @definition
      else
        puts "No segment definition specified..."
        pp data
      end
    end
  end
  
  class SegmentChoice < AbstractSegment
    attr_accessor :segments
    def initialize(data)
      super(data)
      choice = data['choice'].first
      @segments = choice['segmentEntry'].map { |se| FHIR2Obj.create_segment(se) }
    end
  end
  
  class SegmentSequence < AbstractSegment
    attr_accessor :name, :segments
    def initialize(data)
      super(data)
      seq = data['sequence'].first
      @name     = seq['name']&.first&.[]('value')
      @segments = seq['segmentEntry'].map { |se| FHIR2Obj.create_segment(se) }
    end
  end
  
  class ExampleSegment < AbstractSegment
    attr_accessor :name, :description
    def initialize(data)
      super(data)
      @name = data['exampleSegment'].first['name']&.first.[]('value')
      @description  = data['description']
    end
  end
  
end
