require 'csv'
require 'active_support/core_ext/string/inflections'
load File.expand_path('import291.rb', __dir__)
load File.expand_path('test.rb', __dir__)
Dir.glob(File.join(__dir__, 'set_structure', '**', '*.rb'), &method(:load))
# extract(true)
# #  FIXME we're going to need to do the import291 also but not doing it now for the sake of speed during development
