require 'json'

def keyify(vocab)
  output = {}
  vocab.each do |v|
    key = v['bindingIdentifier']
    unless key
      puts Rainbow('NO bindingIdentifier').red
      pp v;puts '************'
      raise
    end
    output[key] = v
  end
  output
end

# This is almost certainly specific to a particular point in time and v2.4.6 of V2WebGenerated 
def igamt_field_table(field)
  de = field.data_element
  v  = de.vocab
  if v
    cs = v.code_systems.first
    table_id = cs.table_id
    raise unless table_id
    if table_id
      table = 'HL7' + table_id.to_s.rjust(4, '0')
      # puts Rainbow(field.code).orange + ' has direct code system ' + table
      return table
    else
      puts Rainbow(field.code).orange + ' has direct code system with no table_id'
      pp cs
      raise
    end
  end
  v = de.concept_domain
  if v
    puts Rainbow(field.code).magenta + ' has concept domain'
    cs = v.code_systems.first
    pp cs;puts
    raise
    return
  end
  # puts Rainbow(field.code).green + ' is not associated with vocab'
  nil
end
  
def get_key_structure(registry, hash)
  hash.each do |k, v|
    # puts Rainbow(k).green + ' ' + v.class.name
    if v.is_a?(String) || v.is_a?(Integer) || v.is_a?(Array)
      registry[k] = v.class.to_s
    # elsif
    #   registry[k] ||= []
    #   registry[k] << get_key_structure({}, v)
    else # Hash
      # puts k.inspect
      # puts v.inspect
      # puts registry.inspect
      # puts '----------'
      registry[k] ||= {}
      registry[k].merge!(v)
    end
  end
  registry.each { |k,v| registry[k] = v.first if v.is_a?(Array) }
  registry
end

def show_example(example_file)
  puts Rainbow(example_file).green    
  ex = JSON.parse(File.read(example_file))
  ex_registry = {}
  ex.each do |entry|
    get_key_structure(ex_registry, entry)
  end
  # ex_registry.each_value { |v| v.uniq! if v.is_a?(Array) }
  pp ex_registry

  # Array types
  ex_registry.each do |k,v|
    next unless v == 'Array'
    puts Rainbow(k).green    
    substructure = ex.map { |e| e[k] }.compact
    substructure_registry = {}
    substructure.each do |ss|
      ss.each do |entry|
        begin
          get_key_structure(substructure_registry, entry)
        rescue
          pp entry
          raise
        end
      end
    end
    # substructure_registry.each_value { |v| v.uniq! }
    pp substructure_registry
  end
end

def keyify_diff_normal(diff_hash, type, key, val1, val2, a, b)
  diff_hash[key] ||= { a => nil, b => nil }
  case type
  when '~'
    diff_hash[key][a] = val1
    diff_hash[key][b] = val2
  when '-'
    diff_hash[key][a] = val1
  when '+'
    diff_hash[key][b] = val1
  else
    raise 'Unknown diff type: ' + type
  end
end

def keyify_diff_for_concepts(diff_hash, type, key, val1, val2, a, b)
  # puts '___________' + key + '___________'
  if key =~ /extension\[/
    val1 = [val1]
    val2 = [val2] if val2
  end
  exts = val1.map { |e| e['url'] }
  exts = val_keys + val2.map { |e| e['url'] } if val2
  exts.uniq!
  exts.each do |ext|
    ext_key = ext.sub(/.*structuredefinition-/, '')
    @extra_keys << ext_key
    diff_hash[ext_key] ||= { a => nil, b => nil }
    ext_val1 = nil
    ext_val2 = nil
    ext_1 = val1.find { |entry| entry['url'] = ext }
    if ext_1
      val_keys = ext_1.keys.reject { |k| k == 'url' }
      if val_keys.size != 1
        pp val1
        raise
      end
      ext_val1 = ext_1[val_keys.first]
    end
    if val2
      ext_2 = val2.find { |entry| entry['url'] = ext }
      if ext_2
        val_keys = ext_2.keys.reject { |k| k == 'url' }
        if val_keys.size != 1
          pp val2
          raise
        end
        ext_val2 = ext_2[val_keys.first]
      end
    end
    case type
    when '~'
      diff_hash[ext_key][a] = ext_val1
      diff_hash[ext_key][b] = ext_val2
    when '-'
      diff_hash[ext_key][a] = ext_val1
    when '+'
      diff_hash[ext_key][b] = ext_val1
    else
      raise 'Unknown diff type: ' + type
    end
  end
end

def skipped_keys
  /children\[\d+\]\.codeUsage|_id|_class|version|codeSystem/
end

def keyify_diff(diff, a, b)
  diff_hash = {}
  diff.each do |d|
    type, key, val1, val2 = d
    next if key =~ skipped_keys
    if key =~ /extension/
      keyify_diff_for_extension(diff_hash, type, key, val1, val2, a, b)
    elsif key =~ /identifier/
      keyify_diff_for_identifier(diff_hash, type, key, val1, val2, a, b)
    else
      keyify_diff_normal(diff_hash, type, key, val1, val2, a, b)
    end
  end
  #   puts '============================'
  # pp diff_hash
  diff_hash
end

def get_concept_hash(concepts, ignored_properties = [])
  output = {}
  return output unless concepts
  concepts.each do |c| 
    prop = c['value']
    output[prop] = c.reject { |k, _| ignored_properties.include?(k) }
  end
  output
end
  
