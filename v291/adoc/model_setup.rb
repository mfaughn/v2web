require_relative '../../bin/show_rainbow'
#!/usr/bin/env ruby
require_relative '../../bin/determine_exec_env'
# This is intended to start rtm web server or pry within a Docker container...and nowhere else!
docker = DetermineExecEnv.in_container?

db_location = docker ? File.expand_path("/database/SQL.db") : File.expand_path("../../database/SQL.db", __dir__)

require 'lodepath'
LodePath.add_project_lib

puts Rainbow("Started asciidoc build with development libraries!").orange
LodePath.amend

if docker # this is a hack because lodepath isn't getting them on its own for some reason
  $:.unshift '/gem_override/gui_site/lib'
  $:.unshift '/gem_override/gui_spec/lib'
  $:.unshift '/gem_override/gui_director/lib'
  $:.unshift '/gem_override/html_gui_builder/lib'
end

LodePath.display

require LodePath.find(File.join('v2web', 'meta_info.rb'))
require LodePath.find(File.join('v2web', 'app_options.rb'))

require 'gui_site/launcher'
opts = {:db_location => db_location}

puts '--------------- Rainbow Colors ----------------'; showcolors; puts '----------------------------------------'

require 'html_gui_builder'
opts[:server] = :setup_only
Gui.run(V2Web, opts)
require 'gui_site/server_config'