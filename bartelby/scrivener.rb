require 'active_support'
require 'appellation'
require 'fileutils'
require_relative 'scrivener_query'

module Scrivener
  def self.included(base)
    base.send(:include, InstanceMethods)
    base.extend(ClassMethods)
  end
  
  class FetchError < StandardError; end

  module InstanceMethods
    delegate :persistance_dir, :to => :class
  
    def cache
      Bartelby.cache(self)
    end
  
    def identifier
      return local_url_name if respond_to?(:local_url_name)
      raise "No defined identifer for a #{self.class}?"
    end
    
    # FIXME this method goes to Appellation and covers cases where obj doesn't respond to @name
    # FIXME right now it is being picked up from the <Class>Methods mixins...
    # def local_url_name
    #   name.downcase.gsub(/[^A-Za-z\d]/, '-')
    # end
    
    def persistance_path
      File.join(persistance_dir, local_url_name + Bartelby::PERSISTANCE_FILE_EXT)
    end
    
    # FIXME come up with a default method for this then override in individual classes
    def to_persistance_file_format
      to_resource # FIXME port from HL7
    end
    
    def save
      # TODO standardize #local_url_name as a primary key and use better method name
      # all models should have default means of creating a uniq primary key
      # expectation is that individual classes will override this method
      puts Rainbow(inspect).yellow unless local_url_name
      # puts "Persisting #{path}"
      File.open(persistance_dir, 'w') do |f|
        f.puts to_persistance_file_format
      end
    end
    
  end # module InstanceMethods

  module ClassMethods
    
    def save
      all.each { |obj| obj.save }
    end
    
    def get(identifier)
      obj_id = identifier.split('/').last
      cached_obj = Bartelby.get(self, obj_id)
      # puts "get #{obj_id}: #{cached_obj}"
      return cached_obj if cached_obj
      make_and_cache(obj_id)
    end
  
    def make_and_cache(identifier)
      path = File.join(Bartelby::MAIN_FILE_STORE, file_key, identifier + Bartelby::PERSISTANCE_FILE_EXT)
      unless File.exist?(path)
        raise FetchError, "No object with path #{path}"
        return nil
      end
      f = File.open(path)
      begin
        # hash = XmlSimple.xml_in(f)
        doc = Nokogiri::XML(f, &:noent)
      rescue
        puts "#{path} failed"
        puts f.inspect
        puts f.read
        f.close
        raise
      end
      f.close
      # puts "make #{path}"
      obj = make(doc, identifier)
      obj.cache
      obj
    end

    def cached(&block)
      Bartelby.all(self, &block)
    end

    def persisted_identfiers
      Dir.glob(File.join(persistance_dir, '*' + Bartelby::PERSISTANCE_FILE_EXT)).map { |fn| fn.split('/').last.sub(Bartelby::PERSISTANCE_FILE_EXT, '') }
    end
  
    def where(opts = {})
      # FIXME
      query = Scrivener::Query.new(self)
      query.where(opts)
    end
      
  
    def all(&block)
      # first get the cached objects
      objs = cached
    
      # next create objects from persistance for all objects that weren't cached
      missing_obj_identifiers = persisted_identfiers - Bartelby.identifiers(self)
      # puts missing_obj_identifiers.sort
      missing_obj_identifiers.each { |identifier| objs << make_and_cache(identifier) }
      objs.compact!
      objs.each { |obj| block.call(obj) } if block
      objs
    end
    
    # This does NOT work like any #first method that a SQL ORM would give you.  It will give you the first obj in the cache or, if the cache is empty, the first obj pulled from file.  You are not guaranteed to get the same object every time even if the persisted objects don't change.
    def first(&block)
      # first get the cached objects
      obj = cached.first
      return obj if obj
      make_and_cache(persisted_identfiers.first)
    end
  
    def file_key
      @file_key ||= Appellation.table_name(name)
    end
  
    def persistance_dir
      # FIXME Appellation#role is broken for colons
      @persistance_dir ||= File.join(Bartelby::MAIN_FILE_STORE, file_key)
    end
  
    # def initialize_persistance
    #   # unless @file_persistance_initialized
    #     # puts "Creating #{persistance_dir}" unless File.exist?(persistance_dir)
    #     FileUtils.mkdir_p(persistance_dir)
    #     @persistance_initialized = true
    #   # end
    # end
  
    def initialize_bartelby
      FileUtils.mkdir_p(persistance_dir)
      @persistance_initialized = true
      Bartelby.cache[self] ||= {}
    end

  end # module ClassMethods
end # Scrivener
