module V2Web
  class DocXtractor
    # def extract_footers(path)
    #   here = Dir.pwd
    #   Dir.chdir(path)
    #   @footers = {}
    #   files = Dir.glob("**/*")
    #   files.each do |f|
    #     next unless f =~ /footer\d+.xml$/
    #     extract_footer(f, @footers)
    #   end
    #   Dir.chdir(here)
    #   # pp @footers
    # end
    #
    # def extract_footer(path, footers)
    #   xml = File.open(path) { |f| Nokogiri::XML(f) }
    #   paras = xml.xpath('.//w:p')
    #   content = []
    #   paras.each do |para|
    #     content << extract_text(para)
    #   end
    #   key = path.split('/').last.split('.').first
    #   footers[key] = Gui_Builder_Profile::RichText.create(:content => content.join("\n"))
    # end
    def extract_footers(path)
      @footers = {}
      extract_headers_or_footers(path, @footers, 'footer')
    end

    def extract_headers(path)
      @headers = {}
      extract_headers_or_footers(path, @headers, 'header')
    end
    
    def extract_headers_or_footers(path, var, type)
      here = Dir.pwd
      Dir.chdir(path)
      var = {}
      files = Dir.glob("**/*")
      files.each do |f|
        next unless f =~ /#{type}\d+.xml$/
        extract_header_or_footer(f, var, type)
      end
      Dir.chdir(here)
    end

    def extract_header_or_footer(path, var, type)
      xml = File.open(path) { |f| Nokogiri::XML(f) }
      paras = xml.xpath('.//w:p')
      content = []
      paras.each do |para|
        content << extract_text(para)
      end
      key = path.split('/').last.split('.').first.delete(type)
      var[key] = Gui_Builder_Profile::RichText.create(:content => content.join("\n"))
    end
    
  end
end