module FHIR2Obj
  class DataElement  
    attr_accessor :name, :item_number, :min_length, :max_length, :c_length, :may_truncate, :description, :url, :data_type
    
    def initialize(data)
      @name          = data['name'].first['value']
      @item_number   = data['itemNumber']&.first&.[]('value')
      @min_length    = data['minLength']&.first&.[]('value')
      @max_length    = data['maxLength']&.first&.[]('value')
      @c_length      = data['confLength']&.first&.[]('value')
      @may_truncate  = data['mayTruncate']&.first&.[]('value')
      # @withdrawn    = data['withdrawn'].first['value']
      @description   = data['description']
      @url           = data['url'].first['value']
      FHIR2Obj.registry[:data_elements][@url][:obj] = self
      dt_url = data['dataType']&.first&.[]('value')
      if dt_url
        @data_type = FHIR2Obj.get_data_type(dt_url)
        unless @data_type
          puts Rainbow(dt_url).red
          pp data
          raise
        end
      end
    end
    
  end
end
