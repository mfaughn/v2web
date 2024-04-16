require 'xmlsimple'
require 'ostruct'
require 'indentation'
require 'htmlentities'
Dir["#{File.join(__dir__, 'model_extensions')}/**/*.rb"].each { |file| load file }
GBP = Gui_Builder_Profile unless defined?(GBP)
V2  = HL7::V2 unless defined?(V2)
Vocab = HL7::Vocab unless defined?(Vocab)
HL7::Vocab::VSD = HL7::Vocab::ValueSetDefinition  unless defined?(HL7::Vocab::VSD)

def pbug(str, color = nil)
  if color
    puts Rainbow(str).send(color.to_sym)
  else
    puts str
  end
end
