#!/usr/bin/env ruby
puts "use of pry.rb is DEPRECATED.  Use the bin/start script instead!"
exit 1
require_relative 'show_rainbow'
require 'lodepath'
LodePath.add_project_lib
if ARGV[0] =~ /test|dev/i
  puts Rainbow('Pry started with development libraries!').orange
  ARGV.shift
  LodePath.amend
else
  puts Rainbow('Pry started with without development libraries!').cyan
end
LodePath.display
require LodePath.find(File.join('v2web', 'meta_info.rb'))
require LodePath.find(File.join('v2web', 'app_options.rb'))

require 'gui_site/launcher'
require 'html_gui_builder'
Gui.run(V2Web, :server => :setup_only)
require 'gui_site/server_config'
require 'pry'
puts '--------------- Rainbow Colors ----------------'; showcolors; puts '----------------------------------------'
binding.pry