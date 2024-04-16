require 'nokogiri'
folder = File.expand_path('~/projects/utg/input/sourceOfTruth/v2/codeSystems')
files  = Dir[folder + '/*']
types = []
all_codes = []
puts 'Number of files:' + files.size.to_s
files.each do |file|
  next
  fhir = File.open(file) { |f| Nokogiri::XML(f) }.at_css('CodeSystem')
  # utg_version = fhir.at_css('version').attr('value')
  concepts = fhir.children.select { |c| c.name == 'concept' }
  number = fhir.at_css('id').attr('value').gsub(/v2-0*/, '').to_i
  cs = Vocab::CodeSystem.where(table_id:number).first
  # puts "Did not find existing entry for #{number}" unless cs
  next
  # properties = fhir.children.select { |c| c.name == 'property' }
  # prop_display = {}
  # prop_type    = {}
  # properties.each do |prop|
  #   type = prop.at_css('type')&.attr('value').to_s
  #   code = prop.at_css('code')&.attr('value').to_s
  #   desc = prop.at_css('description')&.attr('value').to_s
  #   prop_display[code] = desc
  #   prop_type[code] = 'value' + type.capitalize
  #   # puts "#{type}: #{code} => '#{desc}'"
  # end
  concepts.each do |conc|
    code = conc.at_css('code').attr('value')
    all_codes << code
    disp = conc.at_css('display').attr('value')
    defn = conc.at_css('definition').attr('value')
    # concept = HL7::Vocab::Concept.new(code:code, )
  end
end

has_spaces = all_codes.select { |x| x.strip =~ /\s/ }
puts has_spaces.size

# tables.each do |table|
#   debug = false
#   number  = table.at_css('code').attr('value')
#   display = table.at_css('display').attr('value')
#   defn = table.at_css('definition').attr('value')
#   output = [Rainbow("#{number} - #{display}: ").green, Rainbow(defn).yellow]
#   attrs = {}
#   table.css('property').each do |prop|
#     code = prop.at_css('code').attr('value')
#     code = 'v2-cs-uri' if code == 'v2cs-uri'
#     type = prop_type[code]
#     val  = prop.at_css(type).attr('value')
#     output << "  #{prop_display[code]}: #{val}"
#     table_types << val if code == 'v2-table-type'
#     attrs[code] = val
#   end
#   cd = nil
#   cdcode = attrs['vocab-domain']
#   if cdcode
#     cd = Vocab::ConceptDomain.where(code:cdcode).first
#     unless cd
#       ChangeTracker.start
#       cd = Vocab::ConceptDomain.new(code:cdcode)
#       ChangeTracker.commit
#     end
#   else
#     puts Rainbow("#{number} - #{display}").red + ' has no concept domain'
#     # puts table;puts
#   end
#   output <<'------------------------------------'
#   cs = Vocab::CodeSystem.where(table_id:number.to_i).first
#   unless cs
#     puts Rainbow("Creating #{number} - #{display}").yellow
#     ChangeTracker.start
#     cs = Vocab::CodeSystem.new(table_id:number.to_i)
#     cs.name = display
#     cs.description = defn
#     cs.save
#     ChangeTracker.commit
#   end
#   next if cs.utg_version == '3.2.0'
#   ChangeTracker.start
#   if cs.name && cs.name != display
#     puts Rainbow("#{cs.table_id} already had name: '#{cs.name}' instead of '#{display}'")
#   end
#   cs.name        = display
#   cs.description = defn
#   cs.utg_version = utg_version
#   attrs.each do |a, val|
#     case a
#     when 'v2-table-oid'
#       # string: v2-table-oid => 'V2 Table OID'
#       cs.table_oid = val
#     when 'v2-cs-oid'
#       # string: v2-cs-oid => 'V2 Code System OID'
#       cs.cs_oid = val
#     when 'v2-cs-uri'
#       # string: v2-cs-uri => 'V2 Code System URI'
#       cs.cs_uri = val
#     when 'v2-vs-oid'
#       # string: v2-vs-oid => 'V2 Value Set OID'
#       cs.vs_oid = val
#     when 'v2-vs-uri'
#       # string: v2-vs-uri => 'V2 Value Set URI'
#       cs.vs_uri = val
#     when 'v2-table-type'
#       # code: v2-table-type => 'V2 Table Type'
#       tt = HL7::V2::TableType.where(value:val).first
#       if tt
#         cs.table_type = tt
#       else
#         cs.table_type = val
#       end
#     when 'v2-cs-version'
#       # integer: v2-cs-version => 'V2 Code System Version'
#       cs.cs_version = val
#     when 'steward'
#       wg = HL7::WorkGroup.where(name:val).first
#       unless wg
#         wg = HL7::WorkGroup.new(name:val)
#       end
#       cs.add_owner(wg)
#       # code: steward => 'Steward WorkGroup'
#     when 'v2-where-used'
#       # string: v2-where-used => 'Field Where Used'
#       cs.where_used_legacy = val
#     when 'v2-binding'
#       # string: v2-binding => 'V2 Binding Code'
#       bc = HL7::V2::BindingType.where(Sequel.ilike(:value, "% (#{val})")).first
#       unless bc
#         raise "No binding type for code #{val} in: \n#{HL7::V2::BindingType.map {|bt| bt.value}.join(' | ')}"
#       end
#       cs.binding_type = bc
#     when 'v2-version-tbl-introduced'
#       # string: v2-version-tbl-introduced => 'version-tbl-introduced'
#       cs.version_table_introduced = val
#     when 'v2-version-csvs-introduced'
#       # string: v2-version-csvs-introduced => 'version-csvs-introduced'
#       cs.version_csvs_introduced = val
#     when 'v2-cld'
#       # string: v2-cld => 'V2 VS CLD Type'
#       cld = HL7::V2::CLD_Type.where(Sequel.ilike(:value, "% (#{val})")).first
#       unless cld
#         raise "No CLD type for code #{val} in: \n#{HL7::V2::CLD_Type.map {|ct| ct.value}.join(' | ')}"
#       end
#       cs.cld_type = cld
#     when 'vocab-domain'
#       cs.concept_domain = cd
#       # Already handled
#       # string: vocab-domain => 'Concept Domain'
#     when 'v2-codes-table-comment'
#       # string: v2-codes-table-comment => 'V2 Codes Table Comment.'
#       cs.codes_table_comment = val
#     else
#       raise "Was not expecting property '#{a}' with value '#{val}'"
#     end
#   end
#   cs.save
#   ChangeTracker.commit
#   # puts output.join("\n")
#
# end

  
  
  