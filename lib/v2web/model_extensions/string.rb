require 'htmlentities'
module V2Web
  @htmlentities = HTMLEntities.new
  def self.htmlize(string)
    @htmlentities.encode(string).hl7
  end
end

HTMLEntities.new
class String
  unless const_defined?("HTML_ENTITY_CODES")
    HTML_ENTITY_CODES = {
      '–' => '&ndash;',
      '—' => '&ndash;',
      '©' => '&copy;',
      '®' => '&reg;',
      '“' => '&ldquo;',
      '”' => '&rdquo;',
      '’' => '&rsquo;',
      " " => '&nbsp;',
      "√" => '&check;',
      '≤' => '&#8804;',
      '≥' => '&#8805;',
      "≠" => '&#8800;'#,
      # Adding these completely messes up xml tags
      # ">" => '&#62;',
      # "<" => '&#60;'
    }
  end
  
  def hl7
    self.gsub(/#{HTML_ENTITY_CODES.keys.join('|')}/) { |m| HTML_ENTITY_CODES[m] }        
  end
end
