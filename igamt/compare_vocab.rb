require 'hashdiff'
load File.expand_path('igamt_output_utils.rb', __dir__)
load File.expand_path('igamt_output_vocab.rb', __dir__)

def go
  # v3_cs_from_utg
  v2_vs_from_utg
  # compare
  # search_for(0003, 'X01')
end

def search_for(num, code)
  x = v29_array
  igamt_id = "HL7#{num.to_s.rjust(4,'0')}V2-9"
  y = x.find { |e| e['_id'] == igamt_id }
  unless y
    puts "#{igamt_id} not found in IGAMT"
    return
  end
  concepts = y['children']
  concept = concepts.find { |c| c['value'] == code }
  if concept
    pp concept
    return
  else
    puts "#{code} not found in IGAMT"
  end
end

def extract29
  x = v29_array
  y = x.select { |h| h['_id'] =~ /V2-9/ }
  file = File.expand_path('~/projects/v2web/igamt/hl7-data/valueSet_v2_9.json')
  File.write(file, JSON.pretty_generate(y))
end

def check_v29
  x = v29_array
  x.each do |e|
    cs = e['codeSystem']
    id = e['bindingIdentifier']
    unless cs == id
      puts '_______'
      pp e
    else
      puts cs
    end
  end
end

def v29_array
  file = File.expand_path('~/projects/v2web/igamt/hl7-data/valueSet.json')
  JSON.parse(File.read(file)).select { |h| h['version'] == '2.9' }
end
def utg_array
  file = File.expand_path('/Users/mrf/projects/utg_work/tho_3_1_0')
  v2vocab_from_utg(file).map do |h|
  h.delete('table')
  h.delete('codeSystemOid')
  h.delete('utgSource')
  h.delete('description')
  h
end
end

def compare
  v29 = keyify(v29_array)
  utg = keyify(utg_array)
  only_file = File.expand_path('~/projects/v2web/igamt/output/missing_vocab_v2_9_to_THO_3_1_0.txt')
  only_v29 = (v29.keys - utg.keys).sort
  only_utg = (utg.keys - v29.keys).sort
  File.open(only_file, 'w+') do |f|
    f.puts 'Only v2.9'
    f.puts '----------------'
    f.puts only_v29
    f.puts
    f.puts
    f.puts 'Only v2.9'
    f.puts '----------------'
    f.puts only_utg
  end
  common       = v29.keys & utg.keys
  output       = {}
  utg_add      = {}
  common.each do |key|
    # next unless key =~ /0003/
    raw_diff = Hashdiff.diff(v29[key], utg[key])
    a = 'v2.9'
    b = 'UTG'
    diff = keyify_diff(raw_diff, a, b)
    n = diff['name']
    if n
      na = n[a].downcase.gsub(/\s/, '').sub(/codes?$/, '').sub(/s$/, '')
      nb = n[b].downcase.gsub(/\s/, '').sub(/codes?$/, '').sub(/s$/, '')
      if na == nb
        diff.delete('name')
        puts Rainbow("#{n[a].inspect} == #{n[b].inspect}").green
        puts diff.keys.reject { |k| k =~ /children/ }.sort.inspect
      else
        # puts Rainbow("#{n[a].inspect} != #{n[b].inspect}").yellow
      end
    end
    next if diff.keys.empty?
    concepts_differ = diff.keys.any? { |k| k =~ /children/ }
    if concepts_differ
      ignored_properties = ['codeUsage']
      v29_concepts = get_concept_hash(v29[key]['children'], ignored_properties)
      utg_concepts = get_concept_hash(utg[key]['children'], ignored_properties)
      diff.reject! { |k, _| k =~ /children/ }
      diff['concepts_count'] =  {a => v29_concepts.size, b => utg_concepts.size } unless v29_concepts.size == utg_concepts.size
      if utg_concepts && v29_concepts
        concepts_diff = {}
        concept_keys = (v29_concepts.keys + utg_concepts.keys).uniq
        concept_keys.each do |ck|
          u = utg_concepts[ck]
          v = v29_concepts[ck]
          if u == v
            next
          elsif u.nil?
            concepts_diff[ck] = {a => 'Present', b => 'NULL'}
          elsif v.nil?
            concepts_diff[ck] = {a => 'NULL', b => 'Present'}
          else
            concepts_diff[ck] = {a => v, b => u}
          end
        end
        diff['concepts'] = concepts_diff if concepts_diff.any?
      end
    end
    output[key] = diff if diff.any?
  end
  names_differ = {}
  output.each { |k,v| names_differ[k] = v.select { |k1, v1| k1 == 'name' } }
  no_names     = output.dup
  no_names.values.each { |h| h.delete('name') }
  no_names.reject! { |k, v| v.empty? }
  output_file = File.expand_path('~/projects/v2web/igamt/output/diff_vocab_v2_9_to_THO_3_1_0.json')
  File.write(output_file, JSON.pretty_generate(no_names))
  output_file = File.expand_path('~/projects/v2web/igamt/output/diff_vocab_v2_9_to_THO_3_1_0_names_differ.json')
  File.write(output_file, JSON.pretty_generate(names_differ))
end
go