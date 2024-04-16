load File.expand_path('../lib/v2web/model_extensions.rb', __dir__)
load File.expand_path('general_helpers.rb', __dir__)
Dir.glob(File.join(__dir__, 'import291', '**', '*.rb'), &method(:load))

module V291
  module_function
  
  def v2
    @v2 ||= V2AD.v2
  end

end
