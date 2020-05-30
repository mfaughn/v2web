module FHIR
  def self.write_compositions
    output_dir ||= File.expand_path('~/projects/v2web/fhir_output/compositions')
    FileUtils.mkdir_p(output_dir)
    # stds = V2Web::Standard.all
    stds = [V2Web::Standard.first]
    stds.each do |standard|
      path = File.join(output_dir, standard.local_url_name + '.xml')
      File.open(path, 'w') { |f| f.puts standard.to_composition }
      system "tidy -xml -indent -quiet -utf8 -o #{path}"
    end
  end
end
