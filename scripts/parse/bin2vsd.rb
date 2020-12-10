require 'zip'
require 'fileutils'
load File.expand_path(File.join(__dir__, 'parse_common.rb'))


module V2Web  
  class DocXtractor
    def copy_embeddings(source)
      puts Rainbow("#### Copy Embeddings #{source} ###").orange
      doc = setup(source)
      bins = @processor_opts[:embeds].values.select { |v| v =~ /bin$/ }
      bins.each do |bin|
        vsd = bin[0..-4] + 'vsd'
        folder = vsd.split('/')[0..4].join('/')
        embed_folder = File.join(folder, 'embeds', 'chapter' + @chapter)
        FileUtils.mkdir_p(embed_folder)
        location = File.join(embed_folder, vsd.split('/').last)
        puts location
        # FileUtils.cp(bin,vsd)
        # FileUtils.cp(bin,location)
      end
      docs = @processor_opts[:embeds].values.select { |v| v =~ /doc$/ }
      docs.each do |doc|
        folder = doc.split('/')[0..5].join('/')
        embed_folder = File.join(folder, 'embeds', 'chapter' + @chapter)
        FileUtils.mkdir_p(embed_folder)
        location = File.join(embed_folder, doc.split('/').last)
        puts location
        # FileUtils.cp(doc, location)
      end
    end
  end
end

sources = HL7Parse.data_sources(['1','2','2a'])
# sources = ['V29_CH02_Control']
# sources = ['V29_CH01_Intro']
# sources = ['V29_CH17_MaterialsMngmt']

sources.compact.each { |source| V2Web::DocXtractor.new.copy_embeddings(source) }