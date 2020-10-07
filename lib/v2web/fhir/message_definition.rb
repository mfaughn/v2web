module FHIR2Obj

  class MessageDefinition 
    attr_accessor :url, :code, :name
    
    def initialize(data)
      @name      = data['name'].first['value']
      @code      = data['code'].first['value']
      @url       = data['url'].first['value']
      structure_url = data['structure'].first['value']
      @structure = FHIR2Obj.get_message_structure(structure_url)
      unless @structure
        puts "No structure for Message"
        pp data
        puts FHIR2Obj.registry[:message_structures].keys.sort
        raise
      end
      FHIR2Obj.registry[:message_defs][@url][:obj] = self
    end
  end
  
end
