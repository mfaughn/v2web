require 'csv'
require 'nokogiri'
def inventory(tables)
  inventory = {}
  tables.each do |table|
    number  = table.at_css('code').attr('value')
    table.css('property').each do |prop|
      code = prop.at_css('code').attr('value')
      next unless code == 'v2-table-type'
      type = prop_type[code]
      val  = prop.at_css(type).attr('value')
      inventory[val] ||= {:"code system is in UTG" => [], :"NO code system is in UTG" => []}
      if table_file_numbers.include?(number)
        inventory[val][:"code system is in UTG"] << number
      else
        inventory[val][:"NO code system is in UTG"] << number
      end
      # case val
      # when 'HL7'
      # when 'User'
      # when "no longer used"
      # when "HL7-EXT"
      # when "Externally defined"
      # when "Imported"
      # end
    end
  end
  inventory.each do |k,v|
    total = v.values.reduce(0) { |total, x| total += x.size }
        puts 'Table Type: "' + Rainbow(k.to_s).green + '" has a total of ' + total.to_s + ' tables.'
    v.each do |k1,v1|
      if k1.to_s =~ /NO/
        puts Rainbow("  #{k1} - #{v1.size}").magenta + ' tables'
      else
        puts Rainbow("  #{k1} - #{v1.size}").cyan + ' tables'
      end
      # puts v.sort
    end
  end
end

list_file = File.expand_path('~/projects/utg/input/sourceOfTruth/v2/v2-tables.xml')

folder      = File.expand_path('~/projects/utg/input/sourceOfTruth/v2/codeSystems')
table_files = Dir[folder + '/*']
table_file_numbers = table_files.map { |tf| tf.slice(/(?<=cs-v2-)\d+/) }

fhir = File.open(list_file) { |f| Nokogiri::XML(f) }.at_css('CodeSystem')
utg_version = fhir.at_css('version').attr('value')
properties = fhir.children.select { |c| c.name == 'property' }
tables     = fhir.css('concept')
puts tables.size
prop_display = {}
prop_type    = {}
table_types = {}
properties.each do |prop|
  type = prop.at_css('type')&.attr('value').to_s
  code = prop.at_css('code')&.attr('value').to_s
  desc = prop.at_css('description')&.attr('value').to_s
  prop_display[code] = desc
  prop_type[code] = 'value' + type.capitalize
  # puts "#{type}: #{code} => '#{desc}'"
end

def main(tables)
  tables.each do |table|
    next
    debug = false
    number  = table.at_css('code').attr('value')
    display = table.at_css('display').attr('value')
    defn = table.at_css('definition').attr('value')
    output = [Rainbow("#{number} - #{display}: ").green, Rainbow(defn).yellow]
    attrs = {}
    table.css('property').each do |prop|
      code = prop.at_css('code').attr('value')
      code = 'v2-cs-uri' if code == 'v2cs-uri'
      type = prop_type[code]
      val  = prop.at_css(type).attr('value')
      output << "  #{prop_display[code]}: #{val}"
      table_types[val] ||= 0 if code == 'v2-table-type'
      table_types[val] += 1 if code == 'v2-table-type'
      # table_types << val 
      attrs[code] = val
    end
  # next
    cd = nil
    cdcode = attrs['vocab-domain']
    if cdcode
      cd = Vocab::ConceptDomain.where(code:cdcode).first
      unless cd
        ChangeTracker.start
        cd = Vocab::ConceptDomain.new(code:cdcode)
        ChangeTracker.commit
      end
    else
      puts Rainbow("#{number} - #{display}").red + ' has no concept domain'
      # puts table;puts
    end
    output <<'------------------------------------'
    cs = Vocab::CodeSystem.where(table_id:number.to_i).first
    unless cs
      puts Rainbow("Creating #{number} - #{display}").yellow
      ChangeTracker.start
      cs = Vocab::CodeSystem.new(table_id:number.to_i)
      cs.name = display
      cs.description = defn
      cs.save
      ChangeTracker.commit
    end
    next if cs.utg_version == '3.2.0'
    ChangeTracker.start
    if cs.name && cs.name != display
      puts Rainbow("#{cs.table_id} already had name: '#{cs.name}' instead of '#{display}'")
    end
    cs.name        = display
    cs.description = defn
    cs.utg_version = utg_version
    attrs.each do |a, val|
      case a
      when 'v2-table-oid'
        # string: v2-table-oid => 'V2 Table OID'
        cs.table_oid = val
      when 'v2-cs-oid'
        # string: v2-cs-oid => 'V2 Code System OID'
        cs.cs_oid = val
      when 'v2-cs-uri'
        # string: v2-cs-uri => 'V2 Code System URI'
        cs.cs_uri = val
      when 'v2-vs-oid'
        # string: v2-vs-oid => 'V2 Value Set OID'
        cs.vs_oid = val
      when 'v2-vs-uri'
        # string: v2-vs-uri => 'V2 Value Set URI'
        cs.vs_uri = val
      when 'v2-table-type'
        # code: v2-table-type => 'V2 Table Type'
        tt = HL7::V2::TableType.where(value:val).first
        if tt
          cs.table_type = tt
        else
          cs.table_type = val
        end
      when 'v2-cs-version'
        # integer: v2-cs-version => 'V2 Code System Version'
        cs.cs_version = val
      when 'steward'
        wg = HL7::WorkGroup.where(name:val).first
        unless wg
          wg = HL7::WorkGroup.new(name:val)
        end
        cs.add_owner(wg)
        # code: steward => 'Steward WorkGroup'
      when 'v2-where-used'
        # string: v2-where-used => 'Field Where Used'
        cs.where_used_legacy = val
      when 'v2-binding'
        # string: v2-binding => 'V2 Binding Code'
        bc = HL7::V2::BindingType.where(Sequel.ilike(:value, "% (#{val})")).first
        unless bc
          raise "No binding type for code #{val} in: \n#{HL7::V2::BindingType.map {|bt| bt.value}.join(' | ')}"
        end
        cs.binding_type = bc
      when 'v2-version-tbl-introduced'
        # string: v2-version-tbl-introduced => 'version-tbl-introduced'
        cs.version_table_introduced = val
      when 'v2-version-csvs-introduced'
        # string: v2-version-csvs-introduced => 'version-csvs-introduced'
        cs.version_csvs_introduced = val
      when 'v2-cld'
        # string: v2-cld => 'V2 VS CLD Type'
        cld = HL7::V2::CLD_Type.where(Sequel.ilike(:value, "% (#{val})")).first
        unless cld
          raise "No CLD type for code #{val} in: \n#{HL7::V2::CLD_Type.map {|ct| ct.value}.join(' | ')}"
        end
        cs.cld_type = cld
      when 'vocab-domain'
        cs.concept_domain = cd
        # Already handled
        # string: vocab-domain => 'Concept Domain'
      when 'v2-codes-table-comment'
        # string: v2-codes-table-comment => 'V2 Codes Table Comment.'
        cs.codes_table_comment = val
      else
        raise "Was not expecting property '#{a}' with value '#{val}'"
      end
    end
    cs.save
    ChangeTracker.commit
    # puts output.join("\n")
  
  end
end

def connect_wg_cs(tables)
  tables.each do |table|
    number  = table.at_css('code').attr('value')
    cs = Vocab::CodeSystem.where(table_id:number.to_i).first
    table.css('property').each do |prop|
      code = prop.at_css('code').attr('value')
      next unless code == 'steward'
      val = prop.at_css('valueCode').attr('value')
      
      wg = HL7::WorkGroup.where(name:val).first
      unless wg
        ChangeTracker.start
        wg = HL7::WorkGroup.new(name:val)
        ChangeTracker.commit
      end
      unless cs.owners.include?(wg)
        ChangeTracker.start
        cs.add_owner(wg) 
        ChangeTracker.commit
      end
    end

    # puts output.join("\n")
  end
end
# connect_wg_cs(tables)
def check_wg
  HL7::WorkGroup.all.each do |wg|
    puts "#{wg.name} - #{wg.code_systems_count}"
  end
end
# check_wg

def v2tablescsv(tables, prop_type, table_file_numbers)
  puts '--------------CSV-----------------'
  csv_entries = []
  tables.each do |table|
    number = table.at_css('code').attr('value').rjust(4, '0')
    name   = table.at_css('display').attr('value')
    defn   = table.at_css('definition').attr('value')
    # string: v2-table-oid => 'V2 Table OID'
    # string: v2-cs-oid => 'V2 Code System OID'
    # string: v2-cs-uri => 'V2 Code System URI'
    # string: v2-vs-oid => 'V2 Value Set OID'
    # string: v2-vs-uri => 'V2 Value Set URI'
    # code: v2-table-type => 'V2 Table Type'
    # integer: v2-cs-version => 'V2 Code System Version'
    # code: steward => 'Steward WorkGroup'
    # string: v2-where-used => 'Field Where Used'
    # string: v2-binding => 'V2 Binding Code'
    # string: v2-version-tbl-introduced => 'version-tbl-introduced'
    # string: v2-version-csvs-introduced => 'version-csvs-introduced'
    # string: v2-cld => 'V2 VS CLD Type'
    # string: vocab-domain => 'Concept Domain'
    # string: v2-codes-table-comment => 'V2 Codes Table Comment.'
    toid, csoid, csuri, vsoid, vsuri, ttype, csversion, wg, fields, bind, tblintro, csvsintro, cld, cd, comment = nil
    table.css('property').each do |prop|
      code = prop.at_css('code').attr('value')
      type = prop_type[code]
      val  = prop.at_css(type)&.attr('value')
      case code
      when 'v2-table-oid'
        toid = val
      when 'v2-cs-oid'
        csoid = val
      when 'v2-cs-uri'
        csuri = val
      when 'v2-vs-oid'
        vsoid = val
      when 'v2-vs-uri'
        vsuri = val
      when 'v2-table-type'
        ttype = val
      when 'v2-cs-version'
        csversion = val
      when 'steward'
        wg = val
      when 'v2-where-used'
        fields = val
        puts val
      when 'v2-binding'
        bind = case val
               when '0'
                 'N/A (0)'
               when '1'
                 'Example (1)'
               when '2'
                 'Representative (2)'
               when '3'
                 'Universal (3)'
               when '4'
                 'US Realm (4)'
               else
                 nil
               end
      when 'v2-version-tbl-introduced'
        tblintro = val
      when 'v2-version-csvs-introduced'
        csvsintro = val
      when 'v2-cld'
        cld = val
      when 'vocab-domain'
        cd = val
      when 'v2-codes-table-comment'
        comment = val
      end  
        
      # inventory[val] ||= {:"code system is in UTG" => [], :"NO code system is in UTG" => []}
      # if table_file_numbers.include?(number)
      #   inventory[val][:"code system is in UTG"] << number
      # else
      #   inventory[val][:"NO code system is in UTG"] << number
      # end
    end
    tfn = nil
    if csuri.to_s =~ /terminology.hl7.org/
      tfn = csuri.slice(/(?<=v2-)\d+/)
    end
      
    utgcs = !!(tfn && table_file_numbers.include?(tfn))
    table_problem = nil
    if utgcs == false && csuri
      if csuri =~ /terminology.hl7.org/
        table_problem = 'UTG Missing CodeSystem'
      else
        table_problem = csuri
      end
      # puts Rainbow("#{number} -- #{csuri}").red
    end
    csv_entries << [number, ttype, name, defn, cd, wg, bind, fields, comment, table_problem, toid, csoid, csuri, vsoid, vsuri, csversion, tblintro, csvsintro, cld]
  end
  headers = [
    'Table #',
    'V2 Table Type',
    'Name',
    'Description',
    'Concept Domain',
    'Steward WorkGroup',
    'V2 Binding Code',
    'Field Where Used',
    'V2 Codes Table Comment.',
    'Code System Problem?',
    'Table OID',
    'V2 Code System OID',
    'V2 Code System URI',
    'V2 Value Set OID',
    'V2 Value Set URI',
    'V2 Code System Version',
    'version-tbl-introduced',
    'version-csvs-introduced',
    'V2 VS CLD Type'
  ]
  csv_file = File.expand_path(File.join(__dir__, "v2_tables_from_utg.csv"))
  csv = CSV.open(csv_file, "wb")
  csv << headers
  csv_entries.each { |e| csv << e }
  csv.close
end
# v2tablescsv(tables, prop_type, table_file_numbers)

def investigate1(tables, prop_type)
  different = []
  no_cd = []
  tables.each do |table|
    number  = table.at_css('code').attr('value')
    display = table.at_css('display').attr('value')
    # defn = table.at_css('definition').attr('value')
    # output = [Rainbow("#{number} - #{display}: ").green, Rainbow(defn).yellow]
    attrs = {}
    table.css('property').each do |prop|
      code = prop.at_css('code').attr('value')
      code = 'v2-cs-uri' if code == 'v2cs-uri'
      type = prop_type[code]
      val  = prop.at_css(type).attr('value')
      attrs[code] = val
    end
    cd = nil
    cdcode = attrs['vocab-domain']
    if cdcode
      if cdcode.strip != display
        different << "#{number} - '#{display}' VS '#{cdcode}'"
      end
    else
      no_cd << "#{number} - #{display}"
      # puts table;puts
    end
  end
  puts "Name different than Concept Domain:"
  puts different
  puts '_______________________________________________'
  puts 'No Concept Domain:'
  puts no_cd
end
# investigate1(tables, prop_type)

def investigate2
  info = []
  V2::Field.all do |f|
    de = f.data_element
    cs = de.code_system
    next unless cs
    cname = cs.name&.strip
    cname = de.concept_domain&.name.to_s if cname.nil? || cname.empty?
    info << [de.name, cname, f.code, cs.table_id]
  end
  headers = [
    'DataElement (Field) Name',
    'CodeSystem Name',
    'Field',
    'Table #'
  ]
  csv_file = File.expand_path(File.join(__dir__, "v2_field_names_and_vocab_names.csv"))
  csv = CSV.open(csv_file, "wb")
  csv << headers
  info.each { |e| csv << e }
  csv.close
  # info.sort_by { |x| x.first }.each { |x| puts x.join(' | ') }
end
# investigate2

