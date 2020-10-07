module FHIR2Obj
  class SegmentDefinition  
    attr_accessor :name, :abbreviation, :withdrawn, :description, :fields, :url
    
    def initialize(data)
      @name         = data['name'].first['value']
      @abbreviation = data['abbreviation'].first['value']
      @withdrawn    = data['withdrawn'].first['value']
      @description  = data['description']
      @url          = data['url'].first['value']
      FHIR2Obj.registry[:segment_defs][@url][:obj] = self
      @fields       = data['field']&.map { |c| Field.new(c) }
    end
      
  end
  
  class Field  
    attr_accessor :sequence_number, :min_cardinality, :max_cardinality, :must_support, :optionality, :repitition, :addendum_type, :data_element
    def initialize(data)
      if (data.keys - ["sequenceNumber","mustSupport","minCardinality","maxCardinality","dataElement"]).any?
        puts data
        raise
      end
      @sequence_number = data['sequenceNumber'].first['value']
      @min_cardinality = data['minCardinality']&.first&.[]('value')
      @max_cardinality = data['maxCardinality']&.first&.[]('value')
      @must_support    = data['mustSupport']&.first&.[]('value') == 'true'
      de_url = data['dataElement']&.first&.[]('value')
      if de_url
        @data_element = FHIR2Obj.get_data_element(de_url)
        raise "No data element for #{de_url}" unless @data_element
      else
        puts "No data element..."
      end
    end
      
  end
end
