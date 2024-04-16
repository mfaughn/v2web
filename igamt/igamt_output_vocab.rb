require 'json'
require 'rainbow'

def tho3_1_dir
  _tho_dir('3_1_0')
end

def tho1_dir
  _tho_dir('1_1_0')
end

def _tho_dir(version)
  File.expand_path('/Users/mrf/projects/utg_work/tho_' + version)
end

# For comparing IGAMT to 2.9
def parse_v2_tables_cs(file)
  vocab = []
  source = File.expand_path(file)
  tables = JSON.parse(File.read(source))['concept']
  tables.each do |t|
    props = t['property']
    oid_prop  = props.find { |prop| prop['code'] == 'v2-cs-oid' }
    type_prop = props.find { |prop| prop['code'] == 'v2-table-type' }
    oid  = oid_prop['valueString'] if oid_prop
    type = type_prop['valueCode']
    vocab << {
      # 'table'             => t['code'],
      'bindingIdentifier' => 'HL7' + t['code'],
      'name'              => t['display'],
      'codeSystemOid'     => oid,
      'hl7TableType'      => type
    }
  end
  vocab  
end

def v2_tables_cs(file)
  vocab = {}
  source = File.expand_path(file)
  tables = JSON.parse(File.read(source))['concept']
  tables.each do |t|
    props = t['property']
    oid_prop  = props.find { |prop| prop['code'] == 'v2-cs-oid' }
    type_prop = props.find { |prop| prop['code'] == 'v2-table-type' }
    oid  = oid_prop['valueString'] if oid_prop
    type = type_prop['valueCode']
    vocab[t['code']] = {
      'codeSystemOid'     => oid,
      'hl7TableType'      => type
    }
  end
  vocab
end

def v29vocab_from_utg(dir = nil)
  dir ||= tho1_dir
  vocab       = parse_v2_tables_cs(dir + '/CodeSystem-v2-tables.json')
  seen_tables = []
  no_concepts = []

  source_dir = file || tho1_dir
  tho_jsons = Dir["#{source_dir}/**/*.json"]

  tho_jsons.sort.each do |tho_json|
    fn = File.basename(tho_json)
    unless (fn =~ /v2/) && (fn =~ /^(CodeSystem|ValueSet)/)
      # puts Rainbow(fn).yellow
      next
    end
    next if fn =~ /CodeSystem-v2-tables/
    tho = JSON.parse(File.read(tho_json))
    id  = tho['id']
    oid = tho['identifier']&.find { |e| e['system'] == 'urn:ietf:rfc:3986' }
    if oid
      oid = oid['value'].sub(/urn:oid:/, '')
    else
      puts Rainbow("No OID for #{fn}").red
    end
    table_num = fn.slice(/(?<=v2-).+(?=\.json)/)
    if table_num =~ /notAllCodes/
      puts Rainbow(table_num).red
      table_num = table_num.slice(/\d+/)
    end
    seen_tables << table_num
    binding_id = 'HL7' + table_num
    
    vocab_entry = vocab.find { |e| e['bindingIdentifier'] == binding_id }
    unless vocab_entry
      puts Rainbow("No entry in V2 tables for #{table_num}!").red
      vocab_entry = {}
    end      
    # puts fn
    # puts Rainbow(id.inspect).green
    if fn =~ /^ValueSet/
      if seen_tables.include?(table_num)
        if no_concepts.include?(table_num)
          puts Rainbow("ValueSet #{hl7table}").green
          pp tho; puts '----------------------------------'
        else
          next
        end
      else
        puts Rainbow("Have not seen #{table_num}").red
      end
      pp tho;raise "Whoaaaa!"
      
      concepts = tho['concept'] || [] # some have no concepts
      unless concepts.any?
        puts Rainbow("No Concepts for #{fn}").yellow
        no_concepts << hl7table
      end
      children = concepts.map do |c|
        {
          'value'         => c['code'],
          'name'          => c['display'],
          'codeUsage'     => nil,
          'codeSystem'    => binding_id,
          'codeSystemOid' => oid
        }  
      end
        vocab << {
        '_id'               => binding_id + 'V2-9',
        'bindingIdentifier' => binding_id,
        'hl7TableType'      => nil,
        'codeSystem'        => binding_id,
        'children'          => concepts,
        'name'              => tho['name'],
        'version'           => '2.9',
        '_class'            => 'gov.nist.hit.hl7.data.domain.ValueSet',
        'utgSource'         => 'THO v1.0.0/' + fn,
        'description'       => tho['description']
      }
    end
    if fn =~ /^CodeSystem/
      concepts = tho['concept'] || [] # some have no concepts
      unless concepts.any?
        puts Rainbow("No Concepts for #{fn}").yellow
      end
      children = concepts.map do |c|
        {
          'value'         => c['code'],
          'name'          => c['display'],
          'codeUsage'     => 'FIXME - NOT PART OF UTG',
          'codeSystem'    => binding_id,
          'codeSystemOid' => vocab_entry['codeSystemOid']
        }
      end
      addition = {
        '_id'               => binding_id + 'V2-9',
        # 'bindingIdentifier' => binding_id,
        'codeSystem'        => binding_id,
        'children'          => children.any? ? children : nil,
        'name'              => tho['name'],
        'version'           => '2.9',
        '_class'            => 'gov.nist.hit.hl7.data.domain.ValueSet',
        'utgSource'         => 'THO v1.0.0/' + fn,
        'description'       => tho['description']
      }
      vocab_entry.merge!(addition)
    end
  end

  vocab_output_file = File.expand_path('~/projects/v2web/igamt/output/valueSet_v2_9.json')
  File.write(vocab_output_file, JSON.pretty_generate(vocab))
  vocab
end

def v2_vs_from_utg(source_dir = tho3_1_dir)
  vocab       = v2_tables_cs(source_dir + '/CodeSystem-v2-tables.json')
  seen_tables = []
  no_concepts = []

  tho_jsons  = Dir["#{source_dir}/**/*.json"]

  tho_jsons.sort.each do |tho_json|
    fn = File.basename(tho_json)
    next unless (fn =~ /v2/) && (fn =~ /^ValueSet/)
    tho = JSON.parse(File.read(tho_json))
    id  = tho['id']
    table_num = fn.slice(/(?<=v2-).+(?=\.json)/)
    if table_num =~ /notAllCodes/
      # puts Rainbow(table_num).red
      table_num = table_num.slice(/\d+/)
    end
    seen_tables << table_num
    binding_id = 'HL7' + table_num  
    # vocab_entry = vocab.find { |e| e['bindingIdentifier'] == binding_id }
   
    
    includes = tho.dig('compose', 'include')
    if includes.size > 1
      puts Rainbow("Table #{table_num} has multiple includes.").orange
    end
    
    # TODO use concepts from VS if they are there.  Otherwise get from CS.  If external CS, we're going to have to deal with that.... (or if filter...or both)
    includes.each do |incl|
      # sanity_check_include(code_systems, table_num, incl)
      vs      = incl['valueSet']
      sys     = incl['system']
      ver     = incl['version'] || 'NULL'
      concept = incl['concept']
      if sys =~ /^http:\/\/terminology.hl7.org\/CodeSystem/
        if sys =~ /\/v(2|3)-/
          cs  = get_cs_by_url(sys)
        else
        end
        csv = cs['version']
        unless csv == ver
          if csv && ver && (ver != 'NULL')
            puts Rainbow("Table #{table_num} VS specifies inclusion of version #{ver} of #{sys}.  THO 3.1.0 version of this CS is #{csv}").yellow
          elsif csv
            puts Rainbow("Table #{table_num} VS specifies inclusion of version #{ver} of #{sys}.  THO 3.1.0 version of this CS is #{csv}").orange
            # pp incl
          elsif ver
            puts Rainbow("Table #{table_num} VS specifies inclusion of version #{ver} of #{sys}.  THO 3.1.0 version of this CS is #{csv}").cyan
            pp incl
          end
        end
      else
      end
        
    end
    next
    
    concepts = tho['concept'] || [] # some have no concepts
    unless concepts.any?
      puts Rainbow("No Concepts for #{fn}").yellow
      no_concepts << table_num
    end
    children = concepts.map do |c|
      {
        'value'         => c['code'],
        'name'          => c['display'],
        'codeUsage'     => nil,
        'codeSystem'    => binding_id,
        'codeSystemOid' => oid
      }  
    end
      vocab << {
      '_id'               => binding_id + 'V2-9',
      'bindingIdentifier' => binding_id,
      'hl7TableType'      => nil,
      'codeSystem'        => binding_id,
      'children'          => concepts,
      'name'              => tho['name'],
      'version'           => '2.9',
      '_class'            => 'gov.nist.hit.hl7.data.domain.ValueSet',
      'utgSource'         => 'THO v1.0.0/' + fn,
      'description'       => tho['description']
    }
  end

  vocab_output_file = File.expand_path('~/projects/v2web/vocab/valueSets_tho_3_1.json')
  File.write(vocab_output_file, JSON.pretty_generate(vocab))
  vocab
end

def sanity_check_include(cs, table_num, incl)
  # Issues
  # look at vs0125 references cs0440
  # 0929-0932 reference http://unitsofmeasure.org and perhaps should reference https://ucum.org/ucum.html.  Also, version values are not correct for 0929 and 0930.  "2..0" was never a version of UCUM.
  # 0961 The CS that is indirectly referenced should not be titled FHIR Device Kind
  # 0399 ?
  vs      = incl['valueSet']
  sys     = incl['system']
  ver     = incl['version']
  concept = incl['concept']
  
  cs_ver = cs.dig(table_num, 'version')
  if %(0078 125 0136 0719 0725 0952 0959 0961).include?(table_num)
    # do nothing, we've already figured these out
  elsif sys == 'http://terminology.hl7.org/CodeSystem/v2-' + table_num
    if cs_ver == ver
    else
      puts Rainbow(table_num).red + "  #{ver.to_s.inspect} != #{cs_ver.to_s.inspect}"
      pp incl
    end
  elsif sys =~ /terminology.hl7.org\/CodeSystem\/v(3|2)-/
    if cs_ver == ver
      puts Rainbow(binding_id).green + "  #{ver}"
    else
      puts Rainbow(table_num).magenta + "  #{ver.to_s.inspect} != #{cs_ver.to_s.inspect}"
      pp incl
    end
    pp concept if concept
  else
    puts Rainbow(table_num).orange + "  #{ver}"
    puts "System:    #{sys}; ValueSet:  #{vs}; Concepts?: #{!!concept}"
    pp concept if concept
  end
end

def v2_cs_from_utg(source_dir = tho3_1_dir)
  vocab     = v2_tables_cs(source_dir + '/CodeSystem-v2-tables.json')
  tho_jsons = Dir["#{source_dir}/**/*.json"]

  tho_jsons.sort.each do |tho_json|
    fn = File.basename(tho_json)
    next unless (fn =~ /v2/) && (fn =~ /^CodeSystem/)
    next if fn =~ /CodeSystem-v2-tables/
    tho = JSON.parse(File.read(tho_json))
    id  = tho['id']
    table_num = fn.slice(/(?<=v2-).+(?=\.json)/)
    # Check id matches table_num
    unless id == 'v2-' + table_num
      puts Rainbow("#{id} != #{table_num}").red
    end    
    vocab_entry = vocab[table_num]
    unless vocab_entry
      puts Rainbow("No entry in V2 tables for #{table_num}!").red
      vocab[table_num] = {}
    end      
    vocab[table_num].merge!(tho)
  end

  vocab_output_file = File.expand_path('~/projects/v2web/vocab/codeSystems_tho_3_1.json')
  File.write(vocab_output_file, JSON.pretty_generate(vocab))
  vocab
end

def get_cs_by_url(url, source_dir = tho3_1_dir)
  @cs_by_url ||= _store_cs_by_url(source_dir)
  @cs_by_url[url]
end

def _store_cs_by_url(source_dir)
  vocab = {}
  tho_jsons = Dir["#{source_dir}/**/*.json"]
  tho_jsons.sort.each do |tho_json|
    fn = File.basename(tho_json)
    next unless (fn =~ /v2|v3/) && (fn =~ /^CodeSystem/)
    next if fn =~ /CodeSystem-v2-tables/
    tho = JSON.parse(File.read(tho_json))
    url = tho['url']
    vocab[url] = tho
  end
  vocab
end
  
def v3_cs_from_utg(source_dir = tho3_1_dir)
  vocab = {}
  tho_jsons = Dir["#{source_dir}/**/*.json"]

  tho_jsons.sort.each do |tho_json|
    fn = File.basename(tho_json)
    next unless (fn =~ /v3/) && (fn =~ /^CodeSystem/)
    tho = JSON.parse(File.read(tho_json))
    url = tho['url']
    id  = tho['id']
    # puts url; next
    vocab[url] = tho
  end
  vocab_output_file = File.expand_path('~/projects/v2web/vocab/v3_codeSystems_tho_3_1.json')
  File.write(vocab_output_file, JSON.pretty_generate(vocab))
  vocab
end


# FIXME not finished!
=begin
def v2_cs_from_utg(source_dir = tho3_1_dir)
  vocab       = parse_v2_tables_cs(source_dir + '/CodeSystem-v2-tables.json')
  seen_tables = []
  tho_jsons  = Dir["#{source_dir}/**/*.json"]

  tho_jsons.sort.each do |tho_json|
    fn = File.basename(tho_json)
    next unless (fn =~ /v2/) && (fn =~ /^CodeSystem/)
    next if fn =~ /CodeSystem-v2-tables/
    tho = JSON.parse(File.read(tho_json))
    id  = tho['id']
    # oid = tho['identifier']&.find { |e| e['system'] == 'urn:ietf:rfc:3986' }
    # if oid
    #   oid = oid['value'].sub(/urn:oid:/, '')
    # else
    #   puts Rainbow("No OID for #{fn}").red
    # end
    table_num = fn.slice(/(?<=v2-).+(?=\.json)/)
    seen_tables << table_num
    binding_id = 'HL7' + table_num
    
    vocab_entry = vocab.find { |e| e['bindingIdentifier'] == binding_id }
    unless vocab_entry
      puts Rainbow("No entry in V2 tables for #{table_num}!").red
      vocab_entry = {}
    end      
    # puts fn
    # puts Rainbow(id.inspect).green
    concepts = tho['concept'] || [] # some have no concepts
    unless concepts.any?
      puts Rainbow("No Concepts for #{fn}").yellow
    end
    children = concepts.map do |c|
      {
        'value'         => c['code'],
        'name'          => c['display']
      }
    end
    addition = {
      # '_id'               => binding_id + 'V2-9',
      # # 'bindingIdentifier' => binding_id,
      'table_number'      => table_number
      'codeSystem'        => binding_id,
      'url'               => tho['url']
      'concepts'          => children.any? ? children : nil,
      'name'              => tho['name'],
      'version'           => tho['version'],
      'utgSource'         => File.join(dir, fn), # FIXME
      'description'       => tho['description']
    }
    vocab_entry.merge!(addition)
  end

  vocab_output_file = File.expand_path('~/projects/v2web/vocab/codeSystems_tho_3_1.json')
  File.write(vocab_output_file, JSON.pretty_generate(vocab))
  vocab
end
=end