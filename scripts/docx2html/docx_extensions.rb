module Docx
  class Document
    attr_reader :footnotes, :images, :objects
    def setup(unzipped_path, chapter)
      @unzipped_path = unzipped_path
      @images  = {}
      @objects = {}
      register_rels
      register_images(chapter)
      register_footnotes(chapter)
    end
    
    def embed_folder(chapter)
      File.expand_path('~/projects/v2web/test_data/embeds/chapter' + chapter)
    end
    
    def links
      @link_rels
    end
    
    def register_images(chapter)
      media_files = @zip.glob('word/media/*').map(&:name)
      @image_rels.each do |id, data|
        target = File.join('word', data[:target])
        # puts target.inspect
        file = media_files.find { |mf| mf == target }
        if file =~ /(png|jpe?g|gif)$/i
          images[id] = File.expand_path(File.join(@unzipped_path, file))
        elsif file =~ /(emf|wmf)$/i
          renamed    = file.split('/').last.gsub(/(emf|wmf)$/, 'png')
          images[id] = File.expand_path(File.join(embed_folder(chapter), renamed))
        else
          raise "No support for file type: #{file}"
        end
      end
      
      embed_files = @zip.glob('word/embeddings/*').map(&:name)
      @obj_rels.each do |id, data|
        file    = embed_files.find { |ef| ef == File.join('word', data[:target]) }
        folder  = embed_folder(chapter)
        if file =~ /(bin|vsd)$/
          renamed = file.split('/').last.gsub(/(bin|vsd)$/, 'png')
          path    = File.expand_path(File.join(folder, renamed))
          objects[id] = path
        elsif file =~ /doc$/
          renamed = file.split('/').last.gsub(/doc$/, 'png')
          path    = File.expand_path(File.join(folder, renamed))
          objects[id] = path
        else
          raise
        end
        # objects[id] = File.expand_path(File.join(@unzipped_path, file))
      end
    rescue Errno::ENOENT => e
      warn e.message
      nil
    end
    
    def bin2vsd      
      embed_files = @zip.glob('word/embeddings/*').map(&:name)
      embed_files.each do |file|
        path = File.expand_path(File.join(@unzipped_path, 'word', file))
        puts path
      end
    rescue Errno::ENOENT => e
      warn e.message
      nil
    end
    
    # def link_rels
    #   @link_rels
    # end
    
    def register_rels
      modes = []
      types = []
      ids   = []
      @rels_by_type = {}
      by_id   = {}
      by_type = {}
      @rels.xpath("//xmlns:Relationship").each do |n|
        type = n['Type'].split('/').last
        types << type
        id   = n['Id']
        mode   = n['TargetMode']
        modes << mode
        target = n['Target']
        data = {:target => target, :id => id, :type => type}
        data[:external] = true if mode == 'External'
        by_type[type.to_sym] ||= {}
        by_type[type.to_sym][id] = data
        by_id[id] = data
      end
      # puts types.uniq.sort
      @obj_rels   = by_type[:oleObject] || {}
      @link_rels  = by_type[:hyperlink] || {}
      @image_rels = by_type[:image] || {}
    end
    
    def register_footnotes(chapter)
      xml = @zip.read('word/footnotes.xml')
      fns = Nokogiri::XML(xml)
      fns.remove_namespaces!
      fn_links = {}

      begin
        rels_xml = @zip.read('word/_rels/footnotes.xml.rels')
      rescue
        rels_xml = nil
      end
      if rels_xml
        fns_rels = Nokogiri::XML(rels_xml)
        fns_rels.xpath("//xmlns:Relationship").each do |n|
          fn_links[n['Id']] = {:target => n['Target']}
        end
      end
      
      @footnotes = {}
      fns.css('footnote').each do |n|
        id = n['id']
        next if id.to_i < 1
        content = Docx2HTML::Processor.new(n.children.to_a, :is_footnote => id, :links => fn_links, :raw => true, :chapter => chapter).process
        @footnotes[id] = content
      end
    rescue Errno::ENOENT => e
      warn e.message
      nil
    end
    
  end
end