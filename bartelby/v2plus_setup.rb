require 'active_support'
module V2Plus
  FHIR_TYPE_NAMES = %w(DataType DataElement SegmentDefinition MessageStructure Message Event AcknowledgmentChoreography ValueSet) unless defined?(FHIR_TYPE_NAMES)
  
  SUPPORTING_TYPE_NAMES = %W(Field Component Segment SegmentSequence SegmentChoice ExampleSegment AbstractSegment)
  
  FHIR_TYPES = [] unless defined?(FHIR_TYPES)
  SUPPORTING_TYPES = [] unless defined?(SUPPORTING_TYPES)

  def self.setup_klass(klass_name)
    # return V2Plus.const_get(klass_name) if V2Plus.const_defined?(klass_name) # FIXME remove after development?? or do we want to be able to redefine classes after initial setup?
    sequel = HL7.const_get(klass_name.split('::').last)
    # puts sequel.inspect
    if V2Plus.const_defined?(klass_name)
      klass = V2Plus.const_get(klass_name)
    else
      sequel_superclass = sequel.superclass
      if sequel_superclass == Sequel::Model
        klass = V2Plus.const_set(klass_name, Class.new)
      else
        superclass_name = sequel_superclass.name.split('::').last
        klass = V2Plus.const_set(klass_name, Class.new(const_get(superclass_name)))
      end
    end
    klass.include(const_get(klass_name + 'Methods'))
    klass.class_eval do
      @sequel = HL7.const_get(klass_name.split('::').last)
      def self.sequel
        @sequel
      end
      
      Bartelby.set_properties(klass, sequel.properties)
      
      # This is brittle.  Also has to be overridden for MessageDefinition since that model doesn't have @name
      def sequel
        self.class.sequel.where(:name => name).first
      end
      
    end
    klass
  end
  
  ordered_type_names = []
  unordered = FHIR_TYPE_NAMES + SUPPORTING_TYPE_NAMES
  while unordered.any?
    leftovers = []
    unordered.each do |name|
      sequel = HL7.const_get(name.split('::').last)
      sequel_superclass = sequel.superclass
      if sequel_superclass == Sequel::Model
        ordered_type_names << name
      else
        superclass_name = sequel_superclass.name.split('::').last
        if ordered_type_names.include?(superclass_name)
          ordered_type_names << name
        else
          leftovers << name
        end
      end
    end
    unordered = leftovers.dup
  end
      
  ordered_type_names.each do |klass_name|
    klass = setup_klass(klass_name)
    if FHIR_TYPE_NAMES.include?(klass_name)
      FHIR_TYPES << klass unless FHIR_TYPES.include?(klass)
      klass.include(Scrivener)
      klass.class_eval do
        def self.save_sequel
          sequel.all.each { |obj| obj.persist(persistance_dir) }
        end
  
        def to_persistance_file_format
          to_resource
        end
      end
    end
    if SUPPORTING_TYPE_NAMES.include?(klass_name)
      SUPPORTING_TYPES << klass unless SUPPORTING_TYPES.include?(klass)
    end
  end

  
end
