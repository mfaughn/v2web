def render_plant_uml(opts = {})
  destination = opts[:destination] || __dir__
  uml = opts[:uml]
  name = opts[:name]
  unless uml
    file = opts[:file] || relative("test.puml")
    uml = File.read(file)
    name ||= file.split('/').last.split('.')[0..-2].join('.')
  end
  name ||= 'test'
  uml_file = File.join(destination, "uml/#{name}.uml")
  puts "plantUML uml_file: #{uml_file}"
  # svg_file = File.join(destination, "uml/#{name}.svg")
  FileUtils.mkdir_p(File.dirname(uml_file))
  File.open(uml_file, 'w+') do |f|
    f.write("@startuml\n")
    f.write(uml)
    f.write("\n@enduml")
  end
  # system("plantuml -tsvg #{uml_file}")
  system("plantuml #{uml_file}")
end
