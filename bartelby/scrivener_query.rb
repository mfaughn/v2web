module Scrivener
  class Query
    attr_accessor :type, :operations
    def initialize(type)
      @type = type
      @obj_operations = []
      @file_operations = []
    end
    
    def where(opts = {})
      opts.each do |getter, value|
        obj_operations << [:select, getter, value]
      end
      self
    end
    
    def exclude(opts = {})
      opts.each do |getter, value|
        obj_operations << [:reject, getter, value]
      end
      self
    end
    
    def all
      objs = type.all
      obj_operations.each do |operation, getter, value|
        objs = objs.send(operation) { |obj| obj.getter == value }
      end
      objs
    end
    
    def first
      # FIXME
    end
  end
end # Scrivener
