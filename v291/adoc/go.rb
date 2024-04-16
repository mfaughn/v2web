require_relative 'model_setup'
load File.expand_path('../set_structure.rb', __dir__)
load File.expand_path('build.rb', __dir__)

module V291
  module_function
  def go
    system("cls") || system("clear")
    extract(true)
    return
    # V2AD.analyze_sections
    #  FIXME we're going to need to do the import291 also but not doing it now for the sake of speed during development
    translate

    # puts Rainbow('Translating Texts').cyan
    # V291.translate_texts # We have to go ahead and translate all the texts anyway...FIXME turn this off when we go ahead and do the entire import

    slurp

    # V291.test

    WriteAdoc.build
  end
end
V291.go
