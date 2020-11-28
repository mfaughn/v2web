module HL7Parse
  module_function
  def set_list_styles(chapter)
    Docx2HTML::List.set_numId_map(list_style_map[chapter])
  end
  
  def list_style_map
    {
      '1' => {
        '16' => 'disc',
        '17' => 'disc',
        '3'  => 'lower-alpha',
        '24' => 'disc',
        '21' => 'disc'
      },
      '2' => {
        '43' => 'decimal',
        '44' => 'decimal',
        '45' => 'disc',
        '46' => 'disc',
        '47' => 'disc'
        
      },
      '2A' => {
        '5' => 'normallistalpha',
        '7' => 'disc',        
        '8' => 'disc',        
        '17' => 'disc',        
        '21' => 'disc',
        '9' => 'decimal',
        '12' => 'lower-alpha',
        '13' => 'lower-alpha',
        '18' => 'lower-alpha',
        '19' => 'lower-alpha'
      },
      '3' => {
      },        
      '4' => {
        '0'  => 'none',
        '16' => 'disc',
        '17' => 'disc'
      },
      '4A' => {
      },
      '5' => {
        '18' => 'decimal'
      },
      '6' => {
      },
      '7' => {
        '28' => 'disc'
      },
      '8' => {
        '26' => 'disc',
        '29' => 'disc'
      },
      '9' => {
      },
      '10' => {
      },
      '11' => {
      },
      '12' => {
      },
      '13' => {
      },
      '14' => {
      },
      '15' => {
      },
      '16' => {
        '0' => 'none'
      },
      '17' => {  
      }
    }
  end
end