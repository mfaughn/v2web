# load '/Users/mrf/repos/v2-base/V2.9.1/Normative2/2023SEP_for_ballot/adoc/extract.rb' #if  !(defined?(V291)) || reset


puts Rainbow("Importing 291").plum
load File.expand_path('import291.rb', __dir__)
V291.translate if HL7::V2::DataType.count < 1


load '/Users/mrf/repos/hl7-data/sqlite.rb' #if  !(defined?(V291))
puts Rainbow("Importing Frank's data").plum
ImportFrank.import
puts Rainbow("Creating Sequel Models from Frank's data").plum
ImportFrank.create_sequel_models unless defined?(HL7::DataStructureComponent)

puts Rainbow("Beginning Analysis").plum
fdsc = Frank::DataStructureComponent.all;
fdtypes = {}
fdsc.each do |comp|zxcfbvzxdvzxd
  key = comp.data_structure.gsub("'", '').strip
  fdtypes[key] ||= []
  fdtypes[key] << comp
end
Michael = HL7::V2
mfdtypes = {}
mfdt = Michael::DataType.all; 
# puts "And now there are #{dt2.size} data types of type #{dt2.first.class}: #{dt2.map(&:code).sort}"
mfdt.each { |dt| mfdtypes[dt.code] = dt }
mfdtkeys = mfdtypes.keys
fdtkeys = fdtypes.keys
puts "DataTypes unique to Frank:" + (fdtkeys - mfdtkeys).sort.inspect # []
puts "DataTypes unique to Michael:" + (mfdtkeys - fdtkeys).sort.inspect # ["Varies"]

# Next analyze Components of DataTypes

# Segment Definitions

# Message Structures

# Events

# AckChoreography

puts Frank.constants.map(&:to_s).sort



# Classes Created from Frank's database
  # AckChoreography
# Changes
# ChapterHeadings
# ChapterParagraphs
# Chapters
# CodesystemTypes
# Comments
  # Components
  # DataElements
# DataStructureComponents
# DataStructures
# DataTypes
# Documentation
# Documentationcolumns
# EventMessageTypeSegments
# EventMessageTypes
# Events
# Files
# GeneratedDataDifferences
# GeneratedDataIndex
# Governance
# MappingTableDataElements
# MessageTypes
# Modifications
# MsgStructIDSegments
# MsgStructIDs
# Objects
# OpenPoints
# Optionalities
# Options
# Queries
# QueryDisplay
# QueryInput
# QueryInputParameter
# QueryRCP
# Realms
# SegmentDataElements
# SegmentTypes
# Segments
# TableCLDs
# TableTypes
# TableValueCategories
# TableValuePropertyTypes
# TableValues
# TableValuesProperties
# Tables
# V2plus
# V2plus282
# V2plusControl
# Version
# VersionComments
# Versions
# VocabTypes
