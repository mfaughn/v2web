Dir.glob(File.join(__dir__, 'processors', '**', '*.rb'), &method(:load))

Asciidoctor::Extensions.register do
  preprocessor ER7Preprocessor
  preprocessor CharFixPreprocessor

  block MessageTabsBlockProcessor
  
  postprocessor TidyHTML_Postprocessor
end

Asciidoctor::Stylesheets.instance.write_primary_stylesheet '.'
