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
tables     = fhir.css('concept')
prop_display = {}
prop_type    = {}
table_types = {}
properties = fhir.children.select { |c| c.name == 'property' }
# properties.each do |prop|
#   type = prop.at_css('type')&.attr('value').to_s
#   code = prop.at_css('code')&.attr('value').to_s
#   desc = prop.at_css('description')&.attr('value').to_s
#   prop_display[code] = desc
#   prop_type[code] = 'value' + type.capitalize
#   # puts "#{type}: #{code} => '#{desc}'"
# end
def set_cd_name(cd, name)
  ChangeTracker.start
  cd.name = name; cd.save
  ChangeTracker.commit
end

def domains_without_names
  Vocab::ConceptDomain.all.each do |cd|
    next if cd.name
    name = cd.code.split(/(?<=[a-z])(?=[A-Z])/).join(' ')
    print "#{name} >? "
    answer = gets
    if answer.chomp =~ /N/i
      print "Enter name: "
      entered_name = gets
      print "Name is '#{entered_name}'? "
      confirmation = gets
      if confirmation.chomp =~ /Y/i
        set_cd_name(cd, entered_name)
      end
    elsif answer.chomp =~ /Y/i
      set_cd_name(cd, name)
    end
  end
end
# domains_without_names

def dupe_domains
  codes = {}
  names = {}
  domains = Vocab::ConceptDomain.all
  domains.each do |cd|
    codes[cd.code] ||= []
    codes[cd.code] << cd unless codes[cd.code].include?(cd)
    codes[cd.name] ||= []
    codes[cd.name] << cd unless codes[cd.name].include?(cd)
  end
  dupe_codes = codes.select { |_,v| v.size > 1 }
  dupe_names = names.select { |_,v| v.size > 1 }
  if dupe_codes.any?
    puts Rainbow('Dupe Codes').red
    dupe_codes.each do |k,v|
      v.each do |cd| 
        puts Rainbow("#{cd.name}").orange + " : #{cd.code}"
        cd.code_systems.each do |cs|
          puts "#{cs.status&.value || 'FIXME'} : #{cs.table_type&.value} : #{cs.binding_type&.value} >> #{cs.table_id}(#{cs.name})"
        end
      end
      puts 
    end
  end
  if dupe_names.any?
    puts Rainbow('Dupe Names').red
    dupe_names.each do |k,v|
      puts Rainbow(k).orange
      pp v
    end
  end
end
# dupe_domains

def check_domain(tables)
  tables.each do |table|
    debug = false
    number  = table.at_css('code').attr('value')
    cs = Vocab::CodeSystem.where(table_id:number.to_i).first
    cd = cs.concept_domain
    next if cd&.name
    if cd && cd.name.nil?
      pp cd;puts
      pp cd.code_systems
      puts cd.concepts_count
    else
      next
    end
    
    props = table.css('property')
    cd_prop = props.find do |prop|
      prop.at_css('code').attr('value') == 'vocab-domain'
    end
    if cd_prop.nil?      
      puts Rainbow("#{cs.table_id} -- #{cs.name} has no concept domain property").orange
      puts table
      next
    end
    val = cd_prop.at_css('valueString').attr('value')
    puts Rainbow("#{cs.table_id} -- #{cs.name} has no concept domain property but should have #{val}").cyan
    next
    # display = table.at_css('display').attr('value')
    # defn = table.at_css('definition').attr('value')
    # output = [Rainbow("#{number} - #{display}: ").green, Rainbow(defn).yellow]
    attrs = {}
    table.css('property').each do |prop|
      code = prop.at_css('code').attr('value')
      next unless code == 'vocab-domain'
      # code = 'v2-cs-uri' if code == 'v2cs-uri'
      type = prop_type[code]
      val  = prop.at_css(type).attr('value')
      # output << "  #{prop_display[code]}: #{val}"
      # table_types[val] ||= 0 if code == 'v2-table-type'
      # table_types[val] += 1 if code == 'v2-table-type'
      # # table_types << val
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
    # output <<'------------------------------------'
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
# check_domains(tables)

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

def bind_concept_domain(element, cd)
  ChangeTracker.start
  element.concept_domain = cd
  ChangeTracker.commit
end

def check_vocab_binding(e, id_proc)
  cs = e.vocab&.code_systems&.first
  cd = e.concept_domain  
  return unless cs || cd
  if cs
    bt = cs.binding_type
    if bt
      btnum = bt.value.slice(/(?<=\()\d(?=\))/)
      if btnum =~ /0|1/
        if cd
          puts Rainbow(id_proc.call(e)).yellow
        else
          cscd = cs.concept_domain
          if cscd
            bind_concept_domain(e, cscd)
            puts 'Fixed: ' + Rainbow(id_proc.call(e)).magenta
          else
            puts Rainbow(id_proc.call(e)).orange
          end
        end
      elsif btnum =~ /2|3|4/
        if cd
          # puts Rainbow(id_proc.call(e)).green
        else
          cscd = cs.concept_domain
          if cscd
            bind_concept_domain(e, cscd)
            puts 'Fixed: ' + Rainbow(id_proc.call(e)).magenta
          else
            puts Rainbow(id_proc.call(e)).orange
          end
        end
      else
        raise "What? #{btnum} #{cs.pretty_inspect}"
      end
    else
      puts Rainbow(id_proc.call(e)).red
    end
  else
    puts Rainbow(id_proc.call(e)).cyan
  end
end

def vocab_bindings_check
  # DataElement
  de_proc = Proc.new { |de| de.item_number.to_s.rjust(4, '0') }
  V2::DataElement.all do |de|
    check_vocab_binding(de, de_proc)
  end
  puts '==========================================================='
  c_proc = Proc.new { |c| c.owner.code + '.' + c.sequence_number.to_s }
  V2::Component.all do |c|
    check_vocab_binding(c, c_proc)
  end
end
vocab_bindings_check
