module V2Web
  HL7_SECTION_LABEL = proc do
    haml = <<-EOS
    %div.v2_homepage_label_style
      HL7 v2+ Definitions
    EOS
    Haml::Engine.new(haml.reset_indentation).render(self)
  end
  
  WEBSITES_LABEL = proc do
    haml = <<-EOS
    %div.v2_homepage_label_style
      HL7 v2+ Web Publications / Specifications
    EOS
    Haml::Engine.new(haml.reset_indentation).render(self)
  end
  
  HL7_LINK_LABEL = proc do
    haml = <<-EOS
    %div.hl7_link_style
      %a{:href => 'https://hl7.org', :target=> '_blank'} HL7 (click to visit)
    EOS
    Haml::Engine.new(haml.reset_indentation).render(self)
  end

  FHIR_LINK_LABEL = proc do
    haml = <<-EOS
    %div.hl7_link_style
      %a{:href => 'https://www.hl7.org/fhir/', :target=> '_blank'} FHIR (click to visit)
    EOS
    Haml::Engine.new(haml.reset_indentation).render(self)
  end
end
