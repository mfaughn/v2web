module V2Web
  HL7_SECTION_LABEL = proc do
    haml = <<-EOS
    :sass
      .label_style
        // :text-align center
        :display block
        :font-size 16px
        :background-color #053aaa
        :border-radius 5px
        color: white
        text-align: center
        text-decoration: none
        margin-left: 20px

    %div.label_style
      HL7 v2+ Definitions
    EOS
    Haml::Engine.new(haml.reset_indentation).render(self)
  end
  
  WEBSITES_LABEL = proc do
    haml = <<-EOS
    :sass
      .label_style
        // :text-align center
        :display block
        :font-size 16px
        :background-color #053aaa
        :border-radius 5px
        color: white
        text-align: center
        text-decoration: none
        margin-left: 20px

    %div.label_style
      HL7 v2+ Website Specifications
    EOS
    Haml::Engine.new(haml.reset_indentation).render(self)
  end
  
  HL7_LINK_LABEL = proc do
    haml = <<-EOS
    :sass
      $color:   #84f9eb

      .hl7_link_style
        // :text-align center
        :display block
        :font-size 16px
        :background-color #053aaa
        :border-radius 5px
        a
          color: $color
          text-align: center
          text-decoration: none
          margin-left: 20px

          &:visited
            color: #9cd5f3
          &:hover
            color: $color

    %div.hl7_link_style
      %a{:href => 'https://hl7.org', :target=> '_blank'} HL7 (click to visit)
    EOS
    Haml::Engine.new(haml.reset_indentation).render(self)
  end
  
  FHIR_LINK_LABEL = proc do
    haml = <<-EOS
    :sass
      $color:   #84f9eb

      .div_style
        // :text-align center
        :display block
        :font-size 16px
        :background-color #053aaa
        :border-radius 5px
        a
          color: $color
          text-align: center
          text-decoration: none
          margin-left: 20px

          &:visited
            color: #9cd5f3
          &:hover
            color: $color

    %div.div_style
      %a{:href => 'https://build.fhir.org', :target=> '_blank'} FHIR (click to visit)
    EOS
    Haml::Engine.new(haml.reset_indentation).render(self)
  end
end
