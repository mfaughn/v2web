module V2Plus

  class Message    
    def self.initialize(data)
      this = self
      this.name = data['name'].first['value']
      this.code = data['code'].first['value']
      this.url  = data['url'].first['value']
      structure_url = data['structure'].first['value']
      this.structure = FHIR2Obj.get_message_structure(structure_url)
      unless this.structure
        puts "No structure for Message"
        pp data
        puts FHIR2Obj.registry[:message_structures].keys.sort
        raise
      end
      FHIR2Obj.registry[:message_defs][this.url][:obj] = this
      this
    end
  end
  
end
