input  = File.expand_path('~/projects/v2web/test_data/v2plus_extras/llp.html')
output = File.expand_path('~/projects/v2web/test_data/v2plus_extras/lower-layer-protocol.html')
raise unless File.exist?(input)
html = Nokogiri::HTML(File.read(input)) { |c| c.strict }
File.open(output, 'w+') { |f| f.puts html.to_s }
