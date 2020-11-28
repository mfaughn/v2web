require 'xmlsimple'
require 'ostruct'
require 'indentation'
require 'htmlentities'
Dir["#{File.join(__dir__, 'model_extensions')}/**/*.rb"].each { |file| load file }

module HL7
  classes = [
    AbstractSegment,
    AcknowledgmentChoreography,
    Component,
    DataElement,
    DataType,
    Event,
    ExampleSegment,
    Field,
    MessageStructure,
    Message,
    SegmentChoice,
    SegmentDefinition,
    SegmentSequence,
    Segment,
    ValueSet
  ]
  classes.each do |c|
    c.include(const_get(c.name.split('::').last + 'Methods'))
  end
end

module FHIR
  classes = [
    Composition,
    Section,
    Basic
  ]
  classes.each do |c|
    c.include(const_get(c.name.split('::').last + 'Methods'))
  end
end
