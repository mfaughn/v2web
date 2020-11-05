# first serialize all V2Plus FHIR types to files
load File.join(__dir__, 'sequel_model.rb')
load File.join(__dir__, 'bartelby.rb')
load File.join(__dir__, 'scrivener.rb')
load File.join(__dir__, 'scrivener_query.rb')
load File.join(__dir__, 'v2plus.rb')
load File.join(__dir__, 'v2plus_setup.rb')
Dir[File.join(__dir__, 'model_extensions', '*.rb')].each { |file| load file }

module BartelbyTest
  def self.clear
    @all_dt = nil
    @test_datatype = nil
    # puts "all_data_types is #{@all_dt ? @all_dt.count : 'nil'}"
    # puts "test_datatype is #{@test_datatype ? @test_datatype : 'nil'}"
  end
  
  def self.all_data_types
    @all_dt ||= V2Plus::DataType.all
  end
  def self.test_datatype
    @test_datatype ||= all_data_types.find { |dt| dt.code == 'CF' }
  end
end

# Bartelby.clear_cache
V2Plus::FHIR_TYPES.each do |klass|
  klass.initialize_bartelby
  # klass.save_sequel
end
# #
# BartelbyTest.clear
tdt = BartelbyTest.test_datatype
# puts tdt.inspect
# tdt.components.each {|comp| puts comp.inspect }
tdt.to_web_pub
V2Plus::DataType.all
V2Plus::SegmentDefinition.all

# V2Plus::DataType.all { |e| e.to_web_pub }
# V2Plus::SegmentDefinition.all { |e| e.to_web_pub }
# V2Plus::MessageStructure.all { |e| e.to_web_pub }




# puts Rainbow('CachedA').red
# V2Plus::DataType.cached { |obj| puts obj.identifier }
# V2Plus::DataType.get('channel-definition')
# puts Rainbow('CachedB').red
# # puts Rainbow('URIEL').red
# # pp Bartelby[V2Plus::DataType]
# # puts Rainbow('B').red
# V2Plus::DataType.cached { |obj| puts obj.identifier }
# puts Rainbow('All').red
# V2Plus::DataType.all { |obj| puts obj.identifier }
