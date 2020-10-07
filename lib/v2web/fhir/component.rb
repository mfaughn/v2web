module FHIR2Obj
  class Component
    attr_accessor :name, :sequence_number, :min_length, :conf_length, :may_truncate, :data_type, :table
    def initialize(data)
      @name            = data['name'].first['value']
      @sequence_number = data['sequenceNumber'].first['value']
      @min_length      = data['minLength'].first['value'] if data['minLength']
      @conf_length     = data['confLength'].first['value'] if data['confLength']
      @may_truncate    = data['mayTruncate'].first['value'] == 'true'
      # pp data
      dt_url = data['dataType']&.first&.[]('value')
      if dt_url
        @data_type = FHIR2Obj.get_data_type(dt_url) || FHIR2Obj._reconstitute_element(:data_types, dt_url)
      end
      @table = data['dataType']&.first&.[]('binding')&.first&.[]('value')
    end
  end
end
