require 'base64'
module V2IG
    
  def self.template_dir
    @template_dir ||= File.join(__dir__, '../ig_templates')
  end
  def self.template_dir=(val)
    @template_dir = val
  end

  def self.render(template, substitutions)
    output = File.read(File.join(template_dir, template))
    substitutions.each do |key, val|
      puts template.to_s if key.nil?
      output = output.gsub(key.to_s.upcase, val)
    end
    output
  end
end
