# require 'open3'
# puts Rainbow('Loaded TidyHTML_Postprocessor').cornflower
require 'tidy'
# see https://github.com/Flameeyes/tidy?tab=readme-ov-file
class TidyHTML_Postprocessor < Asciidoctor::Extensions::Postprocessor
  def process document, output
    if output.nil?
      pp document
    end
    if document.basebackend? 'html5'
      Tidy.open({:show_warnings => true, :indent => "yes"}) do |tidy|
        output = tidy.clean(output)
        # puts output
        # puts '______________________________'
      end
      # puts Rainbow(output).green
      # puts '--------------------'
      # stdin, stdout, stderr, wait_thr = Open3.popen3("tidy #{output}")
      # output = stdout
      # puts output
      # puts '--------------------'
    end
    output
  end
end
