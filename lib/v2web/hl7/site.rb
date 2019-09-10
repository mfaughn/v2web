# require 'ostruct'
require 'base64'
require_relative 'webdoc'
require_relative 'sdoc'
require_relative 'string'
module HL7Site
  def self.template_dir
    @template_dir ||= File.join(__dir__, 'haml')
  end
  def self.template_dir=(val)
    @template_dir = val
  end

  def self.render_with_locals(template_type, locals)
    engine = Haml::Engine.new(File.read(File.join(template_dir, (template_type.to_s + '.haml'))))
    output = engine.render(Object.new, locals)
  end

  def self.create_site_file(content, location)
    location ||= relative('../pages/public/v2plus_test.html')
    File.open(location, 'w+') { |f| f.puts render_site(content) }   
  end
  
  def self.render_site(content)
    locals = {:content => content}
    render_with_locals(:v2, locals)
  end
end
