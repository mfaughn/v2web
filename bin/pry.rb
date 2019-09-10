#!/usr/bin/env ruby

if ARGV[0] =~ /test|dev|local/i
  ARGV.shift
  require 'lodepath'
  LodePath.amend
  LodePath.display
end
require 'Foundation/load_path_management'
application_module = Foundation.setup_app('v2web', __FILE__)

require 'gui_site/launcher'
require 'gui_director'
require 'html_gui_builder'
Gui.run(application_module, :server => :setup_only)
require 'gui_site/server_config'
