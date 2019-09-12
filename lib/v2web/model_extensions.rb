require_relative 'model_extensions/rendering.rb'
require_relative 'model_extensions/string.rb'
Dir[File.join(__dir__, 'model_extensions/content', '*.rb')].each { |file| require file }
