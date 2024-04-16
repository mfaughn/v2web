def findcs(val)
  cs = Vocab::CodeSystem.where(table_id:val.to_i).first
  if cs
    puts "#{cs.table_id} - #{cs.name}"
  else
    puts 'NOPE: ' + val.to_i.to_s
  end
end
require 'nokogiri'
folder = File.expand_path('~/projects/utg/input/sourceOfTruth/unified/codesystems')
list_file = folder + '/conceptdomains.xml'
fhir = File.open(list_file) { |f| Nokogiri::XML(f) }.at_css('CodeSystem')
properties     = fhir.children.select { |c| c.name == 'property' }
conceptdomains = fhir.children.select { |c| c.name == 'concept' }
prop_display = {}
prop_type    = {}
table_types = []
used_props = []
coding_systems = {}
properties.each do |prop|
  type = prop.at_css('type')&.attr('value').to_s
  code = prop.at_css('code')&.attr('value').to_s
  desc = prop.at_css('description')&.attr('value').to_s
  prop_display[code] = desc
  prop_type[code] = 'value' + type.to_camelcase
  # puts "#{type}: #{code} => '#{desc}'"
end

conceptdomains.each do |cd|
  # next
  debug = false
  
  props = cd.children.select { |n| n.name == 'property' }
  source_prop = props.find { |prop| prop.at_css('code').attr('value') == 'source' }
  source = source_prop.at_css('valueCode').attr('value')
  next if source == 'v3'
  
  code    = cd.at_css('code').attr('value')
  display = cd.at_css('display').attr('value')
  defn = cd.at_css('definition').attr('value')
  cd_obj = HL7::Vocab::ConceptDomain.where(code:code).first
  if cd_obj
    # output = [Rainbow("#{code} - #{display}: ").green, Rainbow(defn).yellow]
  else
    tablenum = display.slice(/(?<=\()\d+(?=\))/)
    puts "Looking for #{tablenum.inspect} from '#{display}'"
    cs = Vocab::CodeSystem.where(table_id:tablenum.to_i).first
    if cs
      cscd = cs.concept_domain
      if cscd
        output = [Rainbow("#{code} - #{display}: ").cyan, cscd.code]#, Rainbow(defn).yellow]
        cd_obj = cscd
      else
        output = [Rainbow("#{code} - #{display}: ").magenta]
      end
      
    else
      output = [Rainbow("#{code} - #{display}: ").orange]#, Rainbow(defn).yellow]
    end
    puts output.join(' | ')
  end
  ChangeTracker.start
  cd_obj.identifier = display.gsub(/\(\d+\)/, '').strip
  cd_obj.description = defn
  cd_obj.save
  ChangeTracker.commit
  next
  attrs = {}

  unless source == 'v2'
    puts cd
    raise
  end
  props.each do |prop|
    code = prop.at_css('code').attr('value')
    used_props << code
    code = 'v2-cs-uri' if code == 'v2cs-uri'
    type = prop_type[code]
    val = case type
          when 'valueCoding'
            coding = prop.at_css(type).at_css('code').attr('value')
            sys    =  prop.at_css(type).at_css('system').attr('value')
            coding_systems[sys] ||= []
            coding_systems[sys] << coding unless coding_systems[sys].include?(coding)
            "#{sys.split('/').last}: #{coding}"
          else
            prop.at_css(type)&.attr('value')
          end
    unless val
      puts output unless cd_obj
      puts "No value for type: " + Rainbow("#{code}").orange
      prop_display.keys.sort.each { |k| puts Rainbow(k.to_s).cyan + ' ' +  prop_type[k] }
      puts cd
      raise
    end
    output << "  #{prop_display[code]}: #{val}" unless code == 'source'
    table_types << val if code == 'v2-table-type'
    attrs[code] = val
  end
  # output << '------------------------------------'
  # puts output.join("\n") unless cd_obj
  
end

# puts used_props.uniq.sort
# puts '------------------------------------'
# pp coding_systems
  
  
  