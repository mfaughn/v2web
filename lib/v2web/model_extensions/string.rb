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
      '&' => '&#38;',
      '–' => '&#8211;', #'&ndash;',
      '©' => '&#169;',
      '®' => '&#174;',
      '“' => '&#8220;',
      '”' => '&#8221;',
      '’' => '&#8217;',
      " " => '&#160;', #'&nbsp;',
      "√" => '&#10003;', #'&check;',
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
  unless const_defined?("ENTITY_CODE_MAP")
    ENTITY_CODE_MAP = {
      '&amp;'   => '&#38;',
      '&ndash;' => '&#8211;',
      '&copy;'  => '&#169;',
      '&reg;'   => '&#174;',
      '&ldquo;' => '&#8220;',
      '&rdquo;' => '&#8221;',
      '&rsquo;' => '&#8217;',
      '&nbsp;'  => '&#160;',
      # "√"       => '&#10003;',
      '&check;' => '&#10003;', #"√"
      '&le;'    => '&#8804;', # '≤'
      '&ge;'    => '&#8805;', # '≥'
      '&ne;'    => '&#8800;', # "≠"
      '&gt;'    => '&#62;',
      '&lt;'    => '&#60;'
    }
  end
  def html_entity_code_to_entity_number
    self.gsub(/#{ENTITY_CODE_MAP.keys.join('|')}/) { |m| ENTITY_CODE_MAP[m] }        
  end
end



=begin
#		&#35;	Number sign
$		&#36;	Dollar sign
%		&#37;	Percent sign
&	&amp;	&#38;	Ampersand
'		&#39;	Apostrophe
(		&#40;	Opening/Left Parenthesis
)		&#41;	Closing/Right Parenthesis
*		&#42;	Asterisk
+		&#43;	Plus sign
,		&#44;	Comma
-		&#45;	Hyphen
.		&#46;	Period
/		&#47;	Slash
0		&#48;	Digit 0
1		&#49;	Digit 1
2		&#50;	Digit 2
3		&#51;	Digit 3
4		&#52;	Digit 4
5		&#53;	Digit 5
6		&#54;	Digit 6
7		&#55;	Digit 7
8		&#56;	Digit 8
9		&#57;	Digit 9
:		&#58;	Colon
;		&#59;	Semicolon
<	&lt;	&#60;	Less-than
=		&#61;	Equals sign
>	&gt;	&#62;	Greater than
?		&#63;	Question mark
@		&#64;	At sign

[		&#91;	Opening/Left square bracket
\		&#92;	Backslash
]		&#93;	Closing/Right square bracket
^		&#94;	Caret
_		&#95;	Underscore
`		&#96;	Grave accent

{		&#123;	Opening/Left curly brace
|		&#124;	Vertical bar
}		&#125;	Closing/Right curly brace
~		&#126;	Tilde
=end