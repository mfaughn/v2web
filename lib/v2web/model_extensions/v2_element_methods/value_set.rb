module ValueSetMethods
  def fhir_url
    "www.hl7.org/fhir/v2/#{local_url_name}/index.html"
  end
  def local_url_name
    table_id.to_s.rjust(4, '0')
  end
  def to_resource
    ''
  end
end
