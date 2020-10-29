module Bartelby
  MAIN_FILE_STORE = File.expand_path('~/projects/v2web/fhir_store') unless defined?(MAIN_FILE_STORE)
  PERSISTANCE_FILE_EXT = '.xml' unless defined?(PERSISTANCE_FILE_EXT)
  module_function

  def cache(object = nil)
    @cache ||= {}
    if object
      @cache[object.class][object.identifier] = object
    else
      @cache
    end
  end
  def clear_cache
    @cache.each { |klass, collection| collection = {} }
  end
  def [](type)
    @cache[type]
  end
  def get(type, identifier)
    @cache.dig(type, identifier)
  end
  def all(type = nil, &block)
    objs = type ? @cache[type].values : @cache.values.map { |x| x.values }.flatten
    objs.each { |obj| block.call(obj) } if block
    objs
  end
  def identifiers(type)
    @cache[type].keys
  end
  
  # These methods should probably be located somewhere else and invoked in a different way but we are going to put them here for now, just to get rolling.
  # TODO
  # * implement reordering
  def set_properties(klass, properties)
    # puts Rainbow("Creating methods for #{klass}").green
    
    klass.class_eval do
      def initialize
        # puts Rainbow("Initialize #{self}").green
        self.class.properties.each_value do |info|
          # puts "#{info[:getter]} -- #{info[:type].inspect}"
          if info[:type] == :one_to_many || info[:type] == :many_to_many
            # puts "Setting #{self.class} #{info[:getter]} = []"
            instance_variable_set("@#{info[:getter]}", [])
          end
        end
      end
      
      def self.properties
        @properties ||= {}
      end
    end
    
    properties.each_value do |info|
      if info[:enumeration]
        set_enumeration(klass, info)
        next
      end
      
      if info[:primitive]
        define_attribute_array(klass, info)
        next
      end
      
      case info[:type]
      when :attribute
        # FIXME handle primitive with multiplicity > 1
        define_attribute(klass, info)
      when :one_to_one
        define_one_to_one_association(klass, info)
      when :many_to_one
        define_many_to_one_association(klass, info)
      when :one_to_many
        define_one_to_many_association(klass,info)
        define_count(klass,info)
      when :many_to_many
        define_many_to_many_association(klass,info)
        define_count(klass,info)
      when :complex_attribute
        define_complex_attribute(klass, info)
      else
        puts Rainbow("#{klass}.#{info[:getter]}").red
        pp info
        puts
      end
    end
    # @properties.each { |prop, info| attr_accessor prop }
  end
  
  def define_count(klass,info)
    klass.class_eval do
      define_method(info[:getter].to_s + '_count') do |val|
        instance_variable_get("@#{info[:getter]}").count
      end
    end
  end
  
  # This is really for primitive attributes (where primitive means a Ruby built-in type instead of a domain type)
  def define_attribute(klass, info)
    # puts "set attribute #{info[:getter]}"
    klass.properties[info[:getter]] = info.dup
    klass.class_eval do
      attr_accessor info[:getter]
    end
  end
  
  def define_attribute_array(klass, info)
    klass.properties[info[:getter]] = info.dup # FIXME this needs to be massaged to be correct
    define_array_getter(klass, info[:getter].to_s)

    klass.class_eval do

      define_method(info[:getter].to_s + '=') do |val|
        raise "#{self.class}.#{info[:getter]}= must receive an array!" unless val.is_a?(Array)
        instance_variable_set("@#{info[:getter]}", val)
      end

      define_method('add_unique_' + info[:getter].to_s) do |val|
        array_var = instance_variable_get("@#{info[:getter]}")
        if array_var.include?(val)
          puts "Ignoring attempt to add #{val} to #{self}.#{info[:getter]} because it is already in there."
        else
          send('add_' + info[:opp_getter].to_s, val)
        end
      end
      
      if info[:enumeration] # the values in an attribute typed as an enumeration should be unique
        alias_method ('add_' + info[:getter].to_s).to_sym, ('add_unique_' + info[:getter].to_s).to_sym
      else
        # NOTE this does not prevent duplication.  Duplication is totally fine here.
        define_method('add_' + info[:getter].to_s) do |val|
          instance_variable_get("@#{info[:getter]}") << val
        end
      end
      
      define_method('remove_' + info[:getter].to_s) do |val|
        instance_variable_get("@#{info[:getter]}").delete(val)
      end
      
    end
  end
  
  # Assuming enumeration values are always Strings (or at least not domain objects)
  def set_enumeration(klass, info)
    if info[:type].to_s =~ /to_one/
      define_attribute(klass, info)
    elsif info[:type].to_s =~ /to_many/
      define_attribute_array(klass, info)
    else
      pp info
      raise "Can't process the enumeration attribute!"
    end
  end
  
  def define_complex_attribute(klass, info)
    define_attribute(klass, info)
    # TODO should we do other stuff here?
  end
  
  def define_array_getter(klass, getter)
    klass.class_eval do
      define_method(getter) do
        ret = instance_variable_get("@#{getter}")
        unless ret
          instance_variable_set("@#{getter}", [])
          ret = instance_variable_get("@#{getter}")
        end
        ret
      end
    end
  end
    
  def define_one_to_one_association(klass, info)
    # puts Rainbow("set one_to_one_association #{klass}.#{info[:getter]}").yellow
    # puts Rainbow(info[:class]).cyan
    # getter = info[:getter].to_s
    klass.properties[info[:getter]] = info.dup
    klass.class_eval do
      attr_reader info[:getter]
      define_method(info[:getter].to_s + '=') do |val|
        instance_variable_set("@#{info[:getter]}", val)
        opp_setter = "_#{info[:opp_getter]}=".to_sym 
        val.send(opp_setter, self) if val.respond_to?(opp_setter) # reciprocal setter
      end
      define_method('_' + info[:getter].to_s + '=') do |val|
        instance_variable_set("@#{info[:getter]}", val)
      end
      
      define_method('_remove_' + info[:getter].to_s) do |val|
        instance_variable_set("@#{info[:getter]}", nil)
      end
    end
  end
  
  def define_one_to_many_association(klass, info)
    # puts Rainbow("set one_to_many_association #{klass}.#{info[:getter]}").yellow
    # puts Rainbow(info[:class]).cyan
    klass.properties[info[:getter]] = info.dup
    define_array_getter(klass, info[:getter].to_s)
    klass.class_eval do
      define_method(info[:getter].to_s + '=') do |vals|
        vals = [] if vals.nil?
        raise "#{self.class}.#{info[:getter]}= must receive an array!" unless vals.is_a?(Array)
        instance_variable_set("@#{info[:getter]}", vals)
        opp_setter = "_#{info[:opp_getter]}=".to_sym 
        vals.each { |val| val.send(opp_setter, self) if val.respond_to?(opp_setter) } # reciprocal setter
      end

      # I don't think anything should ever call this...maybe make it go away? FIXME
      define_method('_' + info[:getter].to_s + '=') do |vals|
        raise "#{self.class}._#{info[:getter]}= must receive an array!" unless vals.is_a?(Array)
        instance_variable_set("@#{info[:getter]}", vals)
      end
            
      define_method('add_unique_' + info[:getter].to_s) do |val|
        if instance_variable_get("@#{info[:getter]}").include?(val)
          puts "Ignoring attempt to add #{val} to #{self}.#{info[:getter]} because it is already in there.  Also not performing #{val.class}.#{info[:opp_getter]} reciprocal association."
        else
          send('add_' + info[:getter].to_s, val)
        end
      end
      
      # NOTE this does not prevent duplication.  Duplication is totally fine here.
      define_method('add_' + info[:getter].to_s) do |val|
        instance_variable_get("@#{info[:getter]}") << val
        opp_setter = "_#{info[:opp_getter]}=".to_sym
        val.send(opp_setter, self) if val.respond_to?(opp_setter) # reciprocal setter
      end
      define_method('_add_' + info[:getter].to_s) do |val|
        instance_variable_get("@#{info[:getter]}") << val
      end
      
      define_method('remove_' + info[:getter].to_s) do |val|
        instance_variable_get("@#{info[:getter]}").delete(val)
        opp_remove = "_remove_#{info[:opp_getter]}".to_sym
        val.send(opp_remove, self)
      end
      
      define_method('_remove_' + info[:getter].to_s) do |val|
        instance_variable_get("@#{info[:getter]}").delete(val)
      end
      
    end
  end

  def define_many_to_one_association(klass, info)
    # puts Rainbow("set many_to_one_association #{klass}.#{info[:getter]}").yellow
    # puts Rainbow(info[:class]).cyan
    klass.properties[info[:getter]] = info.dup
    klass.class_eval do
      attr_reader info[:getter]
      define_method(info[:getter].to_s + '=') do |val|
        instance_variable_set("@#{info[:getter]}", val)
        opp_adder = "_add_#{info[:opp_getter]}".to_sym
        val.send(opp_adder, self)  if val.respond_to?(opp_adder) # reciprocal adder
      end
      define_method('_' + info[:getter].to_s + '=') do |val|
        instance_variable_set("@#{info[:getter]}", val)
      end
      
      define_method('_remove_' + info[:getter].to_s) do |val|
        instance_variable_set("@#{info[:getter]}", nil)
      end
    end
  end

  def define_many_to_many_association(klass, info)
    # puts Rainbow("set many_to_many_association #{klass}.#{info[:getter]}").yellow
    # puts Rainbow(info[:class]).cyan
    klass.properties[info[:getter]] = info.dup
    define_array_getter(klass, info[:getter].to_s)
    klass.class_eval do
      define_method(info[:getter].to_s + '=') do |vals|
        vals = [] if vals.nil?
        instance_variable_set("@#{info[:getter]}", vals)
        opp_adder = "_add_#{info[:opp_getter]}".to_sym
        vals.each { |val| val.send(opp_adder, self)  if val.respond_to?(opp_adder) } # reciprocal adder
      end
      define_method('_' + info[:getter].to_s + '=') do |vals|
        instance_variable_set("@#{info[:getter]}", vals)
      end
    end
    
    define_method('add_unique_' + info[:getter].to_s) do |val|
      if instance_variable_get("@#{info[:getter]}").include?(val)
        puts "Ignoring attempt to add #{val} to #{self}.#{info[:getter]} because it is already in there.  Also not performing #{val.class}.#{info[:opp_getter]} reciprocal association."
      else
        send('add_' + info[:getter].to_s, val)
      end
    end
    
    # NOTE this does not prevent duplication.  Duplication is totally fine here.
    define_method('add_' + info[:getter].to_s) do |val|
      instance_variable_get("@#{info[:getter]}") << val
      opp_adder = "_add_#{info[:opp_getter]}".to_sym
      val.send(opp_adder, self)  if val.respond_to?(opp_adder) # reciprocal adder
    end
    
    define_method('_add_' + info[:getter].to_s) do |val|
      instance_variable_get("@#{info[:getter]}") << val
    end
    
    define_method('remove_' + info[:getter].to_s) do |val|
      instance_variable_get("@#{info[:getter]}").delete(val)
      opp_remove = "_remove_#{info[:opp_getter]}".to_sym
      val.send(opp_remove, self)
    end
    
    define_method('_remove_' + info[:getter].to_s) do |val|
      instance_variable_get("@#{info[:getter]}").delete(val)
    end
    
  end
  
  
  
end
