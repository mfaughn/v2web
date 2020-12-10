module HL7
  class ValueSet

    def fhir_url
      "www.hl7.org/fhir/v2/#{table_id.to_s.rjust(4, '0')}/index.html"
    end
    
  end # ValueSet
end # module HL7
