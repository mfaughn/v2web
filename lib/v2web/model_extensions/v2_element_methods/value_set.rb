module ValueSetMethods
  def fhir_url
    "www.hl7.org/fhir/v2/#{table_id.to_s.rjust(4, '0')}/index.html"
  end
end
