require 'active_support'
module V2Plus
  # V2_FHIR_TYPE_NAMES = %w(DataType DataElement SegmentDefinition MessageStructure Message Event AcknowledgmentChoreography ValueSet) unless defined?(V2_FHIR_TYPE_NAMES)
  # V2_SUPPORTING_TYPE_NAMES = %W(Field Component Segment SegmentSequence SegmentChoice ExampleSegment AbstractSegment) unless defined?(V2_SUPPORTING_TYPE_NAMES)
  #
  # NATIVE_FHIR_TYPE_NAMES = %w(Composition Basic) unless defined?(NATIVE_FHIR_TYPE_NAMES)
  # NATIVE_SUPPORTING_TYPE_NAMES = %w(Section) unless defined?(NATIVE_SUPPORTING_TYPE_NAMES)
  
  FHIR_TYPE_NAMES = {
    HL7  => %w(DataType DataElement SegmentDefinition MessageStructure Message Event AcknowledgmentChoreography ValueSet),
    FHIR => %w(Composition Basic)
  } unless defined?(FHIR_TYPE_NAMES)
  
  SUPPORTING_TYPE_NAMES = {
    HL7  => %w(Field Component Segment SegmentSequence SegmentChoice ExampleSegment AbstractSegment),
    FHIR => %w(Resource Section Narrative)
  } unless defined?(SUPPORTING_TYPE_NAMES)
  
  V2PLUS_TYPES     = [] unless defined?(V2PLUS_TYPES)
  SUPPORTING_TYPES = [] unless defined?(SUPPORTING_TYPES)

  def self.setup_klass(klass_name, namespace)
    # puts "#{namespace} #{klass_name}"
    # return V2Plus.const_get(klass_name) if V2Plus.const_defined?(klass_name) # FIXME remove after development?? or do we want to be able to redefine classes after initial setup?
    sequel = namespace.const_get(klass_name.split('::').last)
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
    klass.include(const_get(klass_name + 'Methods')) if Object.const_defined?(klass_name + 'Methods')
    klass.class_eval do
      @sequel = namespace.const_get(klass_name.split('::').last)
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
  
  def self.merge_type_collections(collections)
    merged = {}
    collections.each do |col|
      col.each do |namespace, klasses|
        merged[namespace] ||= []
        merged[namespace] = merged[namespace] + klasses
      end
    end
    merged
  end
      
  ordered_type_names = {}
  unordered_collections = merge_type_collections([FHIR_TYPE_NAMES, SUPPORTING_TYPE_NAMES])
  unordered_collections.each do |namespace, unordered|
    ordered_type_names[namespace] = []
    while unordered.any?
      leftovers = []
      unordered.each do |klass_name|
        sequel = namespace.const_get(klass_name.split('::').last)
        sequel_superclass = sequel.superclass
        if sequel_superclass == Sequel::Model
          ordered_type_names[namespace] << klass_name
        else
          superclass_name = sequel_superclass.name.split('::').last
          if ordered_type_names[namespace].include?(superclass_name)
            ordered_type_names[namespace] << klass_name
          else
            leftovers << klass_name
          end
        end
      end
      unordered = leftovers.dup
    end
  end
  ordered_type_names.each do |namespace, klass_names|
    klass_names.each do |klass_name|
      klass = setup_klass(klass_name, namespace)
      if FHIR_TYPE_NAMES[namespace].include?(klass_name)
        V2PLUS_TYPES << klass unless V2PLUS_TYPES.include?(klass)
        klass.include(Scrivener)
        klass.class_eval do
          def self.save_sequel
            FileUtils.rm_rf(Dir.glob("#{persistance_dir}/*")) if File.exist?(persistance_dir)
            sequel.all.each { |obj| obj.persist(persistance_dir) }
          end
  
          def to_persistance_file_format
            to_resource
          end
        end
      end
      if SUPPORTING_TYPE_NAMES[namespace].include?(klass_name)
        SUPPORTING_TYPES << klass unless SUPPORTING_TYPES.include?(klass)
      end
    end
  end

  
end
