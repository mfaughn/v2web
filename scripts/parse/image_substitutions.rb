module HL7Parse
  module_function
  
  def image_substitutions
    {
      '1' => {
        'rId8' => :remove
      },
      '2' => {
        'rId8' => :remove,
        # embeds
        'rId13' => :replace,
        'rId15' => :replace
      },
      '2A' => {
        'rId8' => :remove,
        # embeds
        'rId290' => :replace,
      },
      '3' => {
        'rId8' => :remove,
        # embeds
        'rId401' => :replace,
        'rId406' => :replace,
        'rId408' => :replace,
        'rId396' => :replace,
        'rId399' => :replace
      },        
      '4' => {
        'rId8' => :remove,
        # embeds
        'rId11'  => :replace,
        'rId161' => :replace,
        'rId163' => :replace,
        'rId165' => :replace,
        'rId167' => :replace,
        'rId169' => :replace,
        'rId171' => :replace,
        'rId173' => :replace,
        'rId100' => :replace
      },
      '4A' => {
        'rId8' => :remove,
        # embeds
        'rId95' => :replace
      },
      '5' => {
        'rId8' => :remove,
        # embeds
        'rId11' => :replace,
        'rId37' => :replace
      },
      '6' => {
        'rId8' => :remove
        # embeds
      },
      '7' => {
        'rId8' => :remove,
        # embeds
        'rId111' => :replace,
      },
      '8' => {
        'rId8' => :remove,
        # embeds
        'rId187' => :replace,
      },
      '9' => {
        'rId8' => :remove
        # embeds
      },
      '10' => {
        'rId8' => :remove,
        # embeds
        'rId10' => :replace,
      },
      '11' => {
        'rId8' => :remove,
        # embeds
        'rId11' => :replace,
      },
      '12' => {
        'rId8' => :remove
        # embeds
      },
      '13' => {
        'rId8' => :remove,
        # embeds
        'rId11' => :replace,
        'rId13' => :replace,
        'rId15' => :replace,
        'rId17' => :replace,
        'rId19' => :replace,
        'rId56' => :replace
      },
      '14' => {
        'rId8' => :remove
        # embeds
      },
      '15' => {
        'rId8' => :remove
        # embeds
      },
      '16' => {
        'rId8' => :remove
        # embeds
      },
      '17' => {
        'rId8' => :remove
        # embeds
      }
    }
  end

end