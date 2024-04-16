%w(open-uri docx simple_xlsx_reader csv open3 active_support/inflector json rainbow write_xlsx).each { |x| require x }
# require 'open-uri'
def good_url(uri_str, limit = 10)
  url = URI.parse(uri_str)
  rep = Net::HTTP.get_response(url)
  url = rep['location']
  return 'BAD' if limit < 0
  case rep
  when Net::HTTPSuccess
    return 'OK'
  when Net::HTTPRedirection
    good_url(url, limit - 1)
  else
    return 'BAD'
  end
end
# require 'docx'
load File.join(__dir__, '../parse/nokogiri_extensions.rb')
load File.expand_path(File.join(__dir__, 'extractor.rb'))
# require 'simple_xlsx_reader'
# require 'rainbow'
SimpleXlsxReader.configuration.auto_slurp = true
# require 'write_xlsx'
# require 'csv'
# require 'open3'
require_relative 'extractor_helpers'
# require 'active_support/inflector'
# require 'json'

module V2Web
  class DocXtractor
    
    def self._2c_sets(sets = nil)
      if sets
        @@_2c_sets = sets
      end
      @@_2c_sets ||= nil
    end
    
    def self._tho_v2(data = nil)
      if data
        @@_tho_v2 = data
      end
      @@_tho_v2 ||= nil
    end
    
    def self._combine_data(data = nil)
      if data
        @@_combine_data = data
      end
      @@_combine_data ||= nil
    end
    
    def all_tho_v3_status
      tables = {}
      dir = File.expand_path('~/projects/utg_work/tho5.0.3')
      jsons = Dir["#{dir}/**/*.json"]
      concepts = []
      jsons.each do |j|
        jname = File.basename(j)
        next if jname =~ /NamingSystem|ValueSet|List/
        next unless jname =~ /v3-/
        puts jname
        concepts << JSON.parse(File.read(j))['concept']
      end
      statuses = concepts.flatten.compact.map { |c| c['property'] }.compact.flatten.uniq.select { |prop| prop['code'] == 'status' }.map { |h| h['valueCode'] }
      pp statuses      
    end
    
    def all_tho_v2_status
      if DocXtractor._tho_v2
        puts Rainbow("THO already done.").green
        tables = DocXtractor._tho_v2
      else
        tables = tho_v2
      end

      css = []
      v2tables, othertables = tables.partition { |num,data| data.dig(:tho,'cs').to_s =~ /v2-\d\d\d\d/ }
      v2tables.each { |num, data| css << data.dig(:tho, 'cs') }
      css.compact!
      # pp css.first
      v2statuses = css.map { |cs| cs['concept'] }.flatten.compact.map { |c| c['property'] }.compact.flatten.uniq.select { |prop| prop['code'] == 'status' }.map { |h| h['valueCode'] }
      pp v2statuses
      
      css = []
      urls = []
      othertables.each do |num, data|
        cs = data.dig(:tho, 'cs')
        css  << cs
        if cs.is_a?(String)
          # puts Rainbow(num).red
          # pp cs
          next
        end
        url = data.dig :tho, 'cs', 'url'
        if url
          puts Rainbow(num).green
          puts url
          urls << url
        end
      end
      css.compact!
      # pp css.first
      other_statuses = css.map { |cs| cs['concept'] }.flatten.compact.map { |c| c['property'] }.compact.flatten.uniq.select { |prop| prop['code'] == 'status' }.map { |h| h['valueCode'] }
      # pp urls.compact
      pp other_statuses
    end

    # def compare_tho_v2(doc, html)
    def compare_tho_v2(html)
      if DocXtractor._combine_data
        tables = DocXtractor._combine_data
      else
        # @@@@_tho_v2 = nil # uncomment to reset tho extraction
        tables = tho_v2

        # pp tables['0001'].deep_values_transform
        # puts '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'
        # @@_2c_sets = nil # uncomment to reset extracted sets
        # sets = extract_sets(doc, html)
        sets = extract_sets(html)
        # key0001 = sets.keys.find { |k| k =~ /^0001/ }
        # pp sets[key0001].deep_values_transform; return
      
        sets.each do |name, data|
          key = name.slice(/^\s*\d\d\d\d/).strip
          raise name unless key
          tables[key] ||= {}
          data['old_key'] = name
          tables[key][:v2] = data
        end
        DocXtractor._combine_data(tables)
      end
      missing = {v2:[], tho:[]}
      # checkv2ugly(tables)
      tables.each do |table_number, data|
        tho = data[:tho]
        v2  = data[:v2]
        missing[:v2]  << table_number unless v2
        missing[:tho] << table_number unless tho
        compare_attributes(data) if v2 && tho
        # checkv2(v2,tho)
      end

      report = {}
      tables.each do |id, data|
        # next
        if diff = data[:diff]
          # puts Rainbow(id).green
          # pp diff
        end
        data[:warnings]&.uniq!
        if warnings = data[:warnings]
          # puts Rainbow(id).orange
          # pp warnings
        end
        data[:errors]&.uniq!
        if errors = data[:errors]
          # puts Rainbow(id).red
          # pp errors
        end
        if diff || warnings || errors
          report[id] = data.select { |k,_| [:diff, :warnings, :errors].include?(k) }
        end
      end
      # pp report
      output_file = File.expand_path('../../vocab/v291_tho_analysis.json', __dir__)
      File.open(output_file, 'wb+') {|f| f.write(JSON.pretty_generate(report))}
      
      
      # Compare CS version introduced info b/w THO and Ch2c.  Also compare Ch2c table introduced vs CS introduced
      v2_version_csvs_introduced = []
      tables.each do |k,d|
        next
        cd = d.dig(:v2, :concept_domain_info, :cd_only) || d.dig(:v2, :concept_domain_info).nil?
        # next if cd =~ /true/i
        a = d.dig(:v2, :cs_version_info, :version_introduced)
        b = d.dig(:v2, :metadata, :version_introduced)
        if a || b
          if a == b
            # puts k.to_s + Rainbow(" #{a} - #{b}").green
          elsif cd
            # puts k.to_s + Rainbow(" #{a} - #{b}").cyan + "   #{cd.inspect}"
          else
            puts k.to_s + Rainbow(" #{a} - #{b}").orange + "   #{cd.inspect}" if a.nil?
          end
        end
      end
      # puts v2_version_csvs_introduced.compact.uniq.sort
      
      # look for tables that have CS and/or VS in THO but no info about those in Ch2c
      tables.each do |k,d|
        next
        cd = d.dig(:v2, :concept_domain_info, :cd_only) || d.dig(:v2, :concept_domain_info).nil?
        next unless cd
        csii = d.dig(:v2, :cs_info)
        csvi = d.dig(:v2, :cs_version_info)
        vsvi = d.dig(:v2, :vs_version_info)
        thocs = d.dig(:tho, 'cs')
        thocs = (thocs.is_a?(String) ? thocs : thocs['url']) if thocs
        thovs = d.dig(:tho, 'vs', 'url')
        unless csii && csvi && vsvi
          puts Rainbow(k).orange
          puts "No CSII - #{thocs}" unless csii
          puts "No CSVI" unless csvi
          puts "No VSI -  #{thovs}" unless vsvi
        end
      end

      # look for tables that exist exclusively in either THO or Ch2c.  Also looking for Ch2c tables with no Concept Domain Info
      ch2cx = []; thox = []; no_cd = []
      tables.each do |k,d|
        next
        a = d[:v2]
        b = d[:tho]
        next if a && b
        if b
          thox  << k
          next
        end
        if a
          cdi = a[:concept_domain_info]
          if cdi.nil?
            no_cd << k
            next
          end
          cd = cdi[:cd_only]
          next if cd
          ch2cx << k
          pp d; puts '*' *33
        end
      end
      # puts Rainbow(no_cd.inspect).green
      # puts Rainbow(ch2cx.inspect).cyan
      # puts Rainbow(thox).orange
      
      # write_csv_v2_only(columns, rows)
    end
    
    def tho_v2
      if DocXtractor._tho_v2
        puts Rainbow("THO already done.").green
        return DocXtractor._tho_v2
      end
      tables = {}
      dir = File.expand_path('~/projects/utg_work/tho5.0.3')
      jsons = Dir["#{dir}/**/*.json"]
      vs_files = jsons.select { |f| f =~ /ValueSet/ }
      cs_files = jsons.select { |f| f =~ /CodeSystem/ }
      v2_tables_file       = cs_files.find { |f| f =~ /CodeSystem-v2-tables/ }
      concept_domains_file = cs_files.find { |f| f =~ /CodeSystem-conceptdomains/ }
      
      v2_tables_cs       = JSON.parse(File.read(v2_tables_file))['concept']
      concept_domains_cs = JSON.parse(File.read(concept_domains_file))['concept']

      css_used = []
      vss_used = []
      
      v2_tables_cs.each do |t0|        
        t = t0.dup
        code = t['code']
        # puts code
        props = t.delete('property')
        props.each do |prop|
          key = prop.delete('code')
          key = 'v2-cs-uri' if key == 'v2cs-uri'
          t[key] = prop.values.last
        end
        csuri = t['v2-cs-uri']
        if csuri
          # if csuri =~ /http/
          #   res = good_url(csuri)
          #   puts "#{code} cs-uri #{csuri} " + Rainbow(res).orange unless res == 'OK'
          # end
          lookup_key = File.basename(csuri)
          cs_file = cs_files.find { |f| File.basename(f) =~ /#{lookup_key}/ }
          if cs_file
            css_used << cs_file
            cs = JSON.parse(File.read(cs_file)).reject { |k,_| ['text'].include?(k)}
            t['cs'] = cs
            # pp cs
          else
            if csuri =~ /^(urn:)/ || csuri =~ /unitsofmeasure.org/
              t['cs'] = csuri
              # puts Rainbow("Can't find cs #{csuri} for ").magenta + code
            else
              puts Rainbow("Can't find cs #{csuri} for ").red + code
            end
          end
        else
          t['cs'] = nil
        end
        # puts '_________________'
        vsuri = t['v2-vs-uri']
        if vsuri
          # if vsuri =~ /http/
          #   res = good_url(vsuri)
          #   puts "#{code} vs-uri #{vsuri} " +  Rainbow(res).orange unless res == 'OK'
          # end
          lookup_key = File.basename(vsuri)
          vs_file = vs_files.find { |f| File.basename(f) =~ /#{lookup_key}/ }
          if vs_file
            vss_used << vs_file
            vs = JSON.parse(File.read(vs_file)).reject { |k,_| ['text'].include?(k)}
            t['vs'] = vs
            cld = vs['compose']
            if cld.size == 1
              inc = cld['include']
              if inc&.size == 1
                sys = inc.first['system']
                unless sys == csuri
                  puts code + ' ' + Rainbow(sys.inspect).cyan + ' != ' + csuri.inspect
                  pp t
                end
              else
                puts code + ' ' +  Rainbow(cld.pretty_inspect).yellow
              end
            else
              puts code + ' ' +  Rainbow(cld.pretty_inspect).orange
            end
            # pp vs
          else
            puts Rainbow("Can't find vs file #{vsuri} in THO for ").red + code
          end
        else
          t['vs'] = nil
        end
        # puts '_________________'
        tables[code] = {tho:t}
        # pp t
        # return
      end
      
      concept_domains_cs.each do |cd|
        next unless cd['display'] =~ /\((\d\d\d\d)\)/
        entry = tables[$1]&.[](:tho)
        entry['cd'] = cd
      end
      DocXtractor._tho_v2(tables)
      tables
    end
    
    def normalize_string(str)
      str&.gsub("\n", ' ')&.gsub(/\s+/, ' ')
    end
    
    def compare_attributes(data)
      diff = {}
      tho = data[:tho]
      v2  = data[:v2]
      code = tho['code'] ||  v2.dig(:metadata, :table)

      # if v2 says table is concept domain only then there should not be a CS or VS in THO
      cdonly = v2.dig(:concept_domain_info, :cd_only)

      if cdonly # Everything is "clean".  This results in no output.  Happy times.
        csinfo = v2[:cs_info]
        puts Rainbow("#{code} CD only has CS").orange if csinfo
        vsinfo = v2[:vs_version_info]
        puts Rainbow("#{code} CD only has VS info").orange if vsinfo
      end

      unless v2.dig(:concept_domain_info)
        # puts Rainbow("No CD only statement for #{code}").red
        error_data(data, 'Ch2c does not include Concept Domain Information table.  Therefore, it does not indicate whether it is concept domain only or not.')
      end

      # Starting with what is in THO and looking for what is in common with V2....
      # display
      mappings = [
        ['display',       [:metadata, :symbolic_name]],
        ['v2-table-oid',  [:metadata, :table_oid]],
        ['v2-cs-oid',     [:cs_info, :oid]],
        ['v2-cs-uri',     [:cs_info, :utg_url]],
        ['v2-vs-oid',     [:vs_version_info, :oid]],
        ['v2-vs-uri',     [:vs_version_info, :utg_url]],
        ['v2-cld',        [:vs_version_info, :cld]], # THO codes must be translated
        ['v2-table-type', [:metadata, :type]],
        # ['v2-cs-version', []], # no corresponding data in v2.9.1
        ['steward',       [:metadata, :steward]], # must update THO value
        ['v2-where-used', [:metadata, :where_used]], # this may need to be tweaked
        ['v2-binding',    [:binding_info, :realm]],
        ['v2-version-tbl-introduced',  [:metadata, :version_introduced]],
        # ['v2-version-csvs-introduced', [:cs_version_info, :version_introduced]], # this is technically not the same thing...
        ['vocab-domain',  [:concept_domain_info, :symbolic_name]]
      ]
      mappings.each do |tho_key, v2_key|
        v2val  = normalize_string(v2.dig(v2_key.first, v2_key.last))
        thoval = normalize_string(tho[tho_key])
        next if thoval == v2val
        next if tho_key == 'steward' && thoval.upcase == v2val.upcase
        if tho_key == 'v2-binding'
          thoval = case thoval
                   when '0';
                     next if ['n/a', 'unspecified'].include?(v2val&.downcase)
                     'N/A'
                   when '1'; 'Example'
                   when '2'; 'Representative'
                   when '3'; 'Universal'
                   when '4'; 'Us Realm'
                   when nil; 'THO has no binding!'
                   else; thoval
                   end
          next if thoval&.downcase == v2val&.downcase
          next if thoval&.downcase == 'n/a' && v2val.nil?
          # puts code + ' ' + Rainbow("tho[#{tho_key}] = #{thoval&.downcase.inspect} NOT EQUAL v2[#{v2_key.map(&:to_s).join('-')}] = #{v2val&.downcase.inspect}").cyan
          # pp v2
        end
        if tho_key == 'v2-cld'
          thoval = case thoval&.strip
                   when '0'; 'no expansion'
                   when '1'; 'all codes'
                   when '2'; 'enumerated per table content'
                   when '3'; 'V3 value set definition'
                   when '4'; 'unique intensional definition'
                   when '5'; 'non-HL7 value set definition'
                   when '6'; 'FHIR value set definition'
                   when nil; 'THO has no CLD!'
                   else; pp tho; thoval
                   end
          next if thoval == v2val
          # puts code + ' ' + Rainbow("tho[#{tho_key}] = #{thoval&.downcase} NOT EQUAL v2[#{v2_key.map(&:to_s).join('-')}] = #{v2val&.downcase}").magenta
        end
        tho_str = thoval || tho[tho_key]
        # NOTE that v2val may be either nil or empty string here...
        diff["#{tho_key}::#{v2_key.first}-#{v2_key.last}"] = "#{tho_str} != #{v2val}"
      end
      
      thocs = tho['cs'] || {}
      v2csi = v2[:cs_info]
      if cdonly && v2csi
        puts Rainbow("#{code} ").orange + "has CS Identification Information but is CD Only"
        error_data(data, "Ch2c has CS Identification Information but table Concept Domain Only")
      elsif v2csi
        v2sn = v2csi[:symbolic_name]
        unless thocs['title'] == v2sn
          diff["cs.title::cs_id_info-symbolic_name"] = "#{thocs['title']} != #{v2sn}"
        end
        thodesc = normalize_string(thocs['description'])
        v2desc  = normalize_string(v2.dig(:cs_info, :description))
        unless thodesc == v2desc
          diff["cs.description::cs_id_info-description"] = "#{thodesc} != #{v2desc}"
        end
        v2cs_version = '2.' + v2.dig(:cs_version_info, :version).to_s + '.0'
        unless thocs['version'] == v2cs_version
          diff["cs.version::cs_id_info-version"] = "#{thocs['version']} != #{v2cs_version}"
        end
      elsif !cdonly
        # puts Rainbow("#{code} ").cyan + "has no CS Identification Information but is not CD Only"
      end
            
      thovs = tho['vs'] || {}
      unless thovs['title'] == v2.dig(:vs_version_info, :symbolic_name)
        diff["vs.title::vs_info-symbolic_name"] = "#{thovs['title']} != #{v2.dig(:vs_version_info, :symbolic_name)}"
      end
      thovsdesc = normalize_string(thovs['description'])
      v2vsdesc  = normalize_string(v2.dig(:vs_version_info, :description))
      unless thovsdesc == v2vsdesc
        diff["vs.description::vs_info-description"] = "#{thovsdesc} != #{v2vsdesc}"
      end
      
      # go ahead and get these if they exist
      v2_concepts = v2[:concepts]
      
      if cdonly
        error_data(data, "Ch2c table is 'concept domain only' but THO includes CodeSystem resource") if tho['cs']
        error_data(data, "Ch2c table is 'concept domain only' but THO includes ValueSet resource") if tho['vs']
        error_data(data, "Ch2c table is 'concept domain only' but v2.9.1 includes codes anyway") if v2_concepts&.any?
      end
      
      thocd = tho['cd']
      if thocd
        thocddesc = normalize_string(thocd['definition'])
        v2cddesc  = normalize_string(v2.dig(:concept_domain_info, :description))
        unless thocddesc == v2cddesc
          diff["concept_domain.definition::concept_domain_info-description"] = "#{thocddesc} != #{v2cddesc}"
        end
        unless thocd['code'] == v2.dig(:concept_domain_info, :symbolic_name)
          diff["concept_domain.code::concept_domain_info-symbolic_name"] = "#{thocd['code']} != #{v2.dig(:concept_domain_info, :symbolic_name)}"
        end
      else
        error_data(data, "There is no concept domain entry in THO for #{code}")
      end

      v2_concepts = v2[:concepts]
      
      thovs  = tho['vs']
      thocld = thovs&.[]('compose')
      thoincludes = thocld&.[]('include')
      inc1 = thoincludes&.first
      
      v2csurl = v2.dig(:cs_info, :utg_url)
      if v2csurl && v2csurl =~ /hl7.org\/fhir/
        warning_data(data, "CodeSystem URL is a FHIR url: #{v2csurl}.  This may be invalid and/or result in 404 error.")
      end
      v2csurl_is_tho = v2csurl && v2csurl =~ /terminology.hl7.org/
      if v2csurl && !v2csurl_is_tho
        # puts Rainbow("#{code}").red + Rainbow(" is not from THO ").cyan + v2.dig(:cs_info, :utg_url).to_s
        if inc1
          warning_data(data, "ValueSet.compose can't be programmatically checked for #{v2csurl}")
        end
      end
       
      if v2_concepts&.any?
        v2cld = v2.dig(:vs_version_info, :cld)
        if v2cld == 'all codes'
          # First check if the THO vs matches up.
          if thoincludes&.any?
            if thoincludes.size == 1
              if inc1.keys == ['system'] || inc1.keys == ['system', 'version']
                check_vs_versioning(v2,inc1,thocld,code)
                check_tho_version_alignment(tho['cs'], inc1, code, data)
                concept_diff = compare_all_codes(v2_concepts, tho['cs'], code)
                if concept_diff
                  diff["concepts"] = concept_diff
                end
              elsif inc1.keys == ['system', 'concept'] || inc1.keys == ['system', 'version', 'concept']
                error_data(data, 'V2.9.1 indicates INCORRECTLY that value set CLD is "all codes"')
                check_vs_versioning(v2,inc1,thocld,code)
                check_tho_version_alignment(tho['cs'], inc1, code, data) # this might be silly because there may be no CS in THO
                concept_diff = compare_vs_codes(v2_concepts, inc1, thocs, code)
                if concept_diff
                  diff["concepts"] = concept_diff
                end
                # TODO See if error propogates to THO VS CLD
              else
                puts Rainbow("#{code} has a unusual THO include").red
                pp thoincludes
              end
            else
              # multiple includes...or none
              raise "THO has either zero or multiple includes for #{code}"
            end
          end
        elsif v2cld == 'enumerated per table content'
          # puts code + ' ' + Rainbow("enumerated per table content").yellow
          check_vs_versioning(v2,inc1,thocld,code)
          check_tho_version_alignment(tho['cs'], inc1, code, data)
          concept_diff = compare_vs_codes(v2_concepts, inc1, thocs, code)
          if concept_diff
            diff["concepts"] = concept_diff
          end
          
          # TODO go ahead and compare v2_concepts to included concepts in the THO VS
          
          
        else
          if cdonly
            error_data(data, 'V2.9.1 indicates concept domain only but includes codes')
            # FIXME now check the THO VS as if this weren't a concept domain only table.  Might need to refactor to stay DRY
          else
            puts code + ' ' + Rainbow("v2[:vs_version_info][:cld] = #{v2.dig(:vs_version_info, :cld).inspect}").yellow
          end
        end
      else # v2 Ch2c has no concepts
        if thoincludes&.any?
          if cdonly
            # Nevermind, we already looked for this earlier...
            # error_data(data, "v2 table is 'Concept Domain Only' but THO includes a VS for this table.")
            # puts Rainbow("#{code} - v2 table is 'Concept Domain Only' but THO ValueSet CLD exists").orange
            # pp thocld
          else
            cstype = thocs['content']
            if cstype == 'fragment' || cstype == 'not-present'
              if cstype == 'fragment'
                warning_data(data, "v2 table has no concepts but THO includes a VS with CLD that references a CodeSystem fragment (content = fragment)")
              else
                warning_data(data, "v2 table has no concepts but THO includes a VS with CLD that references a CodeSystem metadata record (content = not-present)")
              end
            else
              if thocs.to_s =~ /^urn/
                warning_data(data, "v2 table has no concepts but THO includes a VS with CLD that references #{thocs}. This is probably fine??")
              elsif inc1['system'] =~ /CodeSystem\/v3-/
                warning_data(data, "v2 table has no concepts but THO includes a VS with CLD that references #{inc1['system']}, which has concepts that could be included in Ch2c.")
              elsif inc1['system'] =~ /hl7.org\/fhir\//
                warning_data(data, "v2 table has no concepts but THO includes a VS with CLD that references #{inc1['system']}, which has concepts that could be included in Ch2c...if they are actually the concepts that v2 wants.")
              elsif inc1['valueSet']
                warning_data(data, "v2 table has no concepts but THO includes a VS with CLD that references another ValueSet: #{inc1['valueSet']} that has values that may be available for inclusion in Ch2c.")
              elsif code == '0963'
                error_data(data, "This a mess all around, both in THO and Ch2c.  It should probably just be a concept domain anyway?")
              else
                error_data(data, "v2 table has no concepts but THO includes a VS with CLD includes.")
                puts Rainbow("#{code} - v2 table has no concepts but THO ValueSet CLD exists").red                
                pp inc1
                pp thocs
              end
            end
          end
          # FIXME go further and get the codes from the CS that the THO VS CLD references
        else
          # tho doesn't have any concepts either.  This is happy so do nothing.
        end
      end
      
      data[:diff] = diff unless diff.empty?
    end
    
    def compare_vs_codes(v2_concepts, includ, tho_cs, tablenum)
      # puts Rainbow(tablenum).magenta
      tho_vs_concepts = includ['concept']
      sys = includ['system']
      tho_cs_concepts = tho_cs['concept'] if sys =~ /hl7.org/
      # make sure system aligns w/ CS
      if tho_cs_concepts && (sys != tho_cs['url'])
        puts Rainbow("#{tablenum} - VS system != CS url :: #{sys} != #{tho_cs['url']}").orange
      end
      
      common_but_different = {}
      common  = []
      v2only  = []
      thoonly = []
      
      tho_vs_concepts.each do |thovsc|
        tho_vs_code = thovsc['code']
        
        tho_csc = get_concept_from_cs(tho_cs_concepts, tho_vs_code) if tho_cs_concepts
        
        if tho_cs_concepts && !tho_csc
          pp includ
          puts '________'
          pp tho_cs_concepts
          raise "#{tablenum} doesn't have #{tho_vs_code} in the CS"
        end
        v2c = v2_concepts.find { |entry| entry[:value] == tho_vs_code }
        
        if v2c
          common << tho_vs_code
          diff = {}
          tho_display = normalize_string(thovsc['display'] || tho_csc&.[]('display'))
          v2_display  = normalize_string(v2c[:display_name])
          unless tho_display == v2c[:display_name]
            diff['display'] = "THO: #{tho_display}; v2: #{v2_display}"
          end
          if tho_csc
            thodesc = normalize_string(tho_csc['description'])
            v2desc  = normalize_string(v2c[:definition])
            unless thodesc == v2desc
              diff['definition'] = "THO(from CS): #{thodesc}; v2: #{v2desc}"
            end
            thostatus = tho_csc['property']&.find { |prop| prop['code'] == 'status' }&.[]('valueCode')
            unless (thostatus == 'A' && v2c[:status].to_s.strip.empty?) || (thostatus == v2c[:status] )
              diff['status'] = "THO: #{thostatus}; v2: #{v2c[:status]}"
            end
            v2comment  = v2c[:comment].to_s.strip
            thocomment = tho_csc['property']&.find { |prop| prop['code'] == 'v2-concComment' }&.[]('valueString').to_s.strip
            if v2comment[0] || thocomment[0]
              unless v2comment == thocomment
                diff['comment'] = "THO: #{thocomment}; v2: #{v2comment}"
              end
            end
          else
            if v2c[:definition]
              diff['definition'] = "v2 has definition for concept from non-HL7 CS: #{v2c[:definition]}"
            end
            if v2c[:status]
              diff['status'] = "v2 has status for concept from non-HL7 CS: #{v2c[:status]}"
            end
          end
          unless diff.empty?
            common_but_different[tho_vs_code] = diff
          end
        else
          stat = tho_csc['property']&.find { |prop| prop['code'] == 'status' }&.[]('valueCode') if tho_csc
          thoonly << tho_csc.select { |k,_| k == 'code' || k == 'display' }.merge({'status' => stat })
        end
        # puts "THO: #{thocode}; v2: #{v2c&.[](:value)}"
      end
      
      v2_concepts.each do |c|
        next if c.values.compact.empty?
        next if common.include?(c[:value])
        v2only << c
      end
      
      ret = {}
      ret['v2_only']  = v2only  if v2only.any?
      ret['tho_vs_only'] = thoonly if thoonly.any?
      ret['diff']    = common_but_different if common_but_different.any?
      return ret if ret.any?
      nil
    end
    
    def get_concept_from_cs(concepts, concept_code)
      concepts.each do |concept|
        return concept if concept['code'] == concept_code
        sub_concepts = concept['concept']
        if sub_concepts&.any?
          found_concept = get_concept_from_cs(sub_concepts, concept_code)
          return found_concept if found_concept
        end
      end
      nil
    end
    
    def compare_all_codes(v2_concepts, cs, tablenum)
      # puts Rainbow(tablenum).magenta
      tho_concepts = cs['concept']
      
      common_but_different = {}
      common  = []
      v2only  = []
      thoonly = []
      
      tho_concepts.each do |thoc|
        thocode = thoc['code']
        v2c = v2_concepts.find { |entry| entry[:value] == thocode }
        if v2c
          common << thocode
          diff = {}
          thodisplay = normalize_string(thoc['display'])
          v2display  = normalize_string(v2c[:display_name])
          unless thodisplay == v2display
            diff['display'] = "THO: #{thodisplay}; v2: #{v2display}"
          end
          
          thodesc = normalize_string(thoc['definition'])
          v2desc  = normalize_string(v2c[:definition])
          unless thodesc == v2desc
            diff['definition'] = "THO: #{thodesc}; v2: #{v2desc}"
          end
          thostatus = thoc['property'].find { |prop| prop['code'] == 'status' }&.[]('valueCode')
          unless (thostatus == 'A' && v2c[:status].to_s.strip.empty?) || (thostatus == v2c[:status] )
            diff['status'] = "THO: #{thostatus}; v2: #{v2c[:status]}"
          end
          v2comment  = normalize_string(v2c[:comment].to_s.strip)
          thocomment = normalize_string(thoc['property']&.find { |prop| prop['code'] == 'v2-concComment' }&.[]('valueString').to_s.strip)
          if v2comment[0] || thocomment[0]
            unless v2comment == thocomment
              diff['comment'] = "THO: #{thocomment}; v2: #{v2comment}"
            end
          end
          unless diff.empty?
            common_but_different[thocode] = diff
          end
        else
          stat = thoc['property']&.find { |prop| prop['code'] == 'status' }&.[]('valueCode')
          thoonly << thoc.select { |k,_| k == 'code' || k == 'display' }.merge({'status' => stat })
        end
        # puts "THO: #{thocode}; v2: #{v2c&.[](:value)}"
      end
      
      v2_concepts.each do |c|
        next if c.values.compact.empty?
        next if common.include?(c[:value])
        v2only << c
      end
      
      ret = {}
      ret['v2_only']  = v2only  if v2only.any?
      ret['tho_cs_only'] = thoonly if thoonly.any?
      ret['diff']    = common_but_different if common_but_different.any?
      return ret if ret.any?
      nil
    end

    # check to see if THO cs version matches THO vs version
    def check_tho_version_alignment(cs, inc, code, data)
      unless cs
        # puts Rainbow(code).yellow + " no CS for #{inc['system']}"
        return
      end
      csurl = cs['url']
      csver = cs['version']
      vsurl = inc['system']
      vsver = inc['version']
      unless csurl == vsurl
        # puts Rainbow("THO #{code}").red + " vs cld system is #{vsurl} BUT cs url is #{csurl}"
        error_data(data, "THO ValueSet system is #{vsurl}; THO CodeSystem url is #{csurl}")
      end
      if vsver && vsver != csver
       # puts Rainbow("THO #{code}").red + " vs cld version is #{vsver} BUT cs version is #{csver}"
       error_data(data, "THO ValueSet version is #{vsver}; THO CodeSystem version is #{csver}")
      end
    end

    # check now that the referenced CS and version are correct w/ respect to what is in THO and what is listed in v2.9.1 as v2[:cs_info][:utg_url] and v2[:cs_version_info][:version].  The version value from v2 will need to be prepended with '2.'
    def check_vs_versioning(v2,inc1,thocld,code)
      v2wantsurl = v2.dig(:cs_info, :utg_url)
      v2wantsversion = "2.#{v2.dig(:cs_version_info, :version)}.0" if v2.dig(:cs_version_info, :version)
      unless inc1['system'] == v2wantsurl
        # puts Rainbow("Table #{code}").red + " -- V2 wants url #{v2wantsurl} and THO has #{inc1['system']}"
      end
      if v2wantsversion
        unless inc1['version'] == v2wantsversion
          # puts Rainbow("Table #{code}").red + " -- V2 wants version #{v2wantsversion} and THO has #{inc1['version']}"
          # pp thocld unless inc1['version']
        end
      end
    end

    def error_data(data, message)
      data[:errors] ||= []
      data[:errors] << message
    end
    
    def warning_data(data, message)
      data[:warnings] ||= []
      data[:warnings] << message
    end

    def checkv2(v2, tho)
      return unless v2
      checkv2cs(v2, tho)
      checkv2vs(v2, tho)
    end
    
    def checkv2vs(v2,tho)
      x  = v2.dig(:metadata, :symbolic_name)
      x2 = v2.dig(:metadata, :full_name)
      y  = v2.dig(:vs_version_info, :full_name)
      if x && y
        code = tho&.[]('code') || v2.dig(:metadata, :table)
        # if x2 # only table 0227 has this
        #   puts "#{code}  #{x} -- #{x2}"
        # end
        # return
        if (x.strip + ' Value Set') == y.strip
          # puts Rainbow(code).green + " #{x.inspect} != #{y.inspect}"
        else
          # return if %(0910 0961 0820 0821 0825 0232).include?(code)
          # return if (x.strip + ' Code System').downcase == y.strip.downcase
          # return if (x.strip + ' Code System').downcase.gsub(/\s/, '') == y.strip.downcase.gsub(/\s/, '')
          # return if (x.strip.sub(/Table$/, '') + ' Code System').downcase.gsub(/\s/, '') == y.strip.downcase.gsub(/\s/, '')
          # return if y == 'Donation Duration Units Code System'
          # return if x.empty?
          puts Rainbow(code).orange + " #{x.inspect} != #{y.inspect}"
          # pp tho
          # gets
          # z = y.slice(/.+(?= Code System)/)
          # # puts tho.to_s.include?(x)
          # # puts z
          # pp tho if tho.to_s.include?(z)
          # continue = gets
        end
      end
    end
    
    def checkv2cs(v2,tho)
      return unless v2
      x = v2.dig(:metadata, :symbolic_name)
      x2 = v2.dig(:metadata, :full_name)
      y = v2.dig(:cs_info, :full_name)
      if x && y
        code = tho&.[]('code') || v2.dig(:metadata, :table)
        # if x2 # only table 0227 has this
        #   puts "#{code}  #{x} -- #{x2}"
        # end
        # return
        unless (x.strip + ' Code System') == y.strip
          return if %(0910 0961 0820 0821 0825 0232).include?(code)
          return if (x.strip + ' Code System').downcase == y.strip.downcase
          return if (x.strip + ' Code System').downcase.gsub(/\s/, '') == y.strip.downcase.gsub(/\s/, '')
          return if (x.strip.sub(/Table$/, '') + ' Code System').downcase.gsub(/\s/, '') == y.strip.downcase.gsub(/\s/, '')
          return if y == 'Donation Duration Units Code System'
          return if x.empty?
          puts Rainbow(code).orange + " #{x.inspect} != #{y.inspect}"
          # pp tho
          # gets
          # z = y.slice(/.+(?= Code System)/)
          # # puts tho.to_s.include?(x)
          # # puts z
          # pp tho if tho.to_s.include?(z)
          # continue = gets
        end
      end
    end
    
    def checkv2ugly(tables)
      uglies = []
      tables.each do |table_number, data|
        v2 = data[:v2]
        next unless v2
        code = v2.dig(:metadata, :table)
        v2.each do |k,v|
          next unless v.is_a?(Hash)
          v.each do |kk,vv|        
            if vv =~ /^\s*(tbd|-|noObject)\s*$/i
              uglies << code + ' ' + Rainbow("#{k}.#{kk}").cyan + ' ' + vv.inspect
            end
          end
        end
      end
      md, leftover = uglies.partition { |u| u =~ /metadata.description/ }
      # md =  md.map { |m| m.slice(/^\d\d\d\d/) }.sort
      # puts md
      # puts md.size
      # puts leftover.sort
      vs_d, leftover = leftover.partition { |u| u =~ /vs_version_info.description/ }
      cs_d, leftover = leftover.partition { |u| u =~ /cs_info.description/ }
      puts vs_d.sort
      puts 
      puts cs_d.sort
      puts 
      puts leftover.sort
    end

    # def extract_sets(doc, html)
    def extract_sets(html)
      if DocXtractor._2c_sets
        puts Rainbow("Sets already done.").green
        return DocXtractor._2c_sets
      end
      @html = File.open(html) { |f| Nokogiri::XML(f) }
      # doc.remove_namespaces!
      # @vs = nil
      # @metadata = false
      # @values = false
      @sets = {}
      do2c
      DocXtractor._2c_sets(@sets)
      @sets
    end

    def read_rob_sheet
      xlsx = File.expand_path(File.join(__dir__, '../../vocab/v2+TableClassification.xlsx'))
      doc = SimpleXlsxReader.open(xlsx)
      s = doc.sheets.first
      tables = []
      s.rows[1..-1].each do |row|
        tables << row.first
      end
      tables
    end
        
    def write_csv_v2_only(headers, rows)
      csv_file_all = File.expand_path(File.join(__dir__, '../../vocab/ch2c_all.csv'))
      csv_all = CSV.open(csv_file_all, "wb")
      csv_all << headers
      counter = 0
      rows.each do |r|
        csv_all << r
      end
      csv_all.close
    end
       
    def write_csv(headers, rows)
      # rob_tables = read_rob_sheet
      tho = tho_v2
      csv_file_all = File.expand_path(File.join(__dir__, '../../vocab/ch2c_all.csv'))
      csv_file_in  = File.expand_path(File.join(__dir__, '../../vocab/ch2c_in_utg.csv'))
      csv_file_out = File.expand_path(File.join(__dir__, '../../vocab/ch2c_not_in_utg.csv'))
      # puts Rainbow("Writing CSV to: #{csv_file_all}").orange
      csv_all = CSV.open(csv_file_all, "wb")
      csv_in  = CSV.open(csv_file_in, "wb")
      csv_out = CSV.open(csv_file_out, "wb")
      csv_all << headers
      csv_in  << headers
      csv_out << headers
      counter = 0
      rows.each do |r|
        csv_all << r
        rob_current = rob_tables[counter].to_i
        docx_current = r.first.split(/\s/).first.to_i
        if rob_current == docx_current
          csv_in << r
          puts Rainbow("#{r.first} is in UTG list (#{rob_current})").green
          counter += 1
        elsif docx_current > rob_current
          while docx_current > rob_current
            puts Rainbow("#{r.first} is not #{rob_current}").yellow
            csv_in << []
            counter += 1
            rob_current = rob_tables[counter].to_i
          end
          csv_in << r
          puts Rainbow("#{r.first} is in UTG list (#{rob_current})").green
          counter += 1
          # find the index of the 
          # counter = rob_tables.index
        else
          csv_out << r
          puts Rainbow("#{r.first} is not #{rob_current}").orange
        end
      end
      csv_all.close
      csv_in.close
      csv_out.close
    end
        
    def write_xlsx(headers, rows)
      # Create a new Excel workbook
      wb = WriteXLSX.new('ch2c.xlsx')

      # Add a worksheet
      ws = workbook.add_worksheet

      wb.close
    end
    
    def do2c
      current_table = nil
      current_table_type = nil
      set = nil
      @html.at('body').children.each do |node|
        case node.name
        when 'h3'
          @sets[current_table] = set.dup if set
          set = {}
          current_table = node.text.gsub(/\n/, ' ')
          # puts Rainbow("#{current_table}").orange
        when 'text'
          puts "Text: #{node.text}" if node.text.strip[0];next
          tx = extract_text(node)
          puts Rainbow(tx).red if tx[0]
        when 'table'
          headers = node.css('tr').map { |r| r.css('th').map { |th| th.text } }.compact
          entries = node.css('tr').map { |r| r.css('td').map { |td| td.text } }.compact
          case current_table_type
          when 'Concept Domain Information'
            cd = {}
            entries.each do |key, val|
              case key
              when "Concept Domain Name"
                cd[:name] = val
              when "SymbolicName"
                cd[:symbolic_name] = val
              when "Description"
                cd[:description] = val
              when "Concept Domain Only"
                if val == 'no'
                  cd[:cd_only] = false
                elsif val == 'yes'
                  cd[:cd_only] = true
                else
                  raise "Concept Domain Only is #{val.inspect}"
                end
              else
                puts Rainbow("Concept Domain property #{key} => #{val}").yellow
              end
            end
            set[:concept_domain_info] = cd
          when 'Code System Identification Information'
            info = {}
            entries.each do |key, val|
              case key
              when "Code System OID"
                info[:oid] = val
              when "Table OID"
                puts Rainbow("#{current_table} has Table OID in Code System Identification Information").magenta
                info[:table_oid] = val
              when "Version Info"
                info[:version_info] = val
              when "SymbolicName"
                info[:symbolic_name] = val
              when "Description"
                info[:description] = val
              when "Full Name"
                info[:full_name] = val
              when "UTG URL"
                info[:utg_url] = val
              when "Webpage URL"
                info[:web_url] = val
              when "UTG Name"
                info[:utg_name] = val
              when "Comments"
                info[:comments] = val
              else
                puts Rainbow("#{current_table} has Code System Identification Information property #{key} => #{val}").yellow
              end
            end
            set[:cs_info] = info
          when 'Code System Version Information'
            info = {}
            entries.each do |key, val|
              case key
              when "Effective Date"
                info[:effective_date] = val
              when "Version"
                info[:version] = val
              when "HL7 Version Introduced"
                info[:version_introduced] = val
              else
                puts Rainbow("#{current_table} has Code System Version Information property #{key} => #{val}").yellow
              end
            end
            set[:cs_version_info] = info
          when 'Value Set Information'
            info = {}
            entries.each do |key, val|
              case key
              when "Value Set OID"
                info[:oid] = val
              when "SymbolicName"
                info[:symbolic_name] = val
              when "Description"
                info[:description] = val
              when "Full Name"
                info[:full_name] = val
              when "UTG URL"
                info[:utg_url] = val
              when "Content Logical Definition"
                info[:cld] = val
              when "Webpage URL"
                info[:web_url] = val
              when "UTG Name"
                info[:utg_name] = val
              when "UTG Title"
                info[:utg_title] = val
              when "Comments"
                info[:comments] = val
              else
                puts Rainbow("Value Set Information property #{key} => #{val}").yellow
              end
            end
            set[:vs_version_info] = info
          when 'Binding Information'
            info = {}
            entries.each do |key, val|
              case key
              when "Realm"
                info[:realm] = val
              else
                puts Rainbow("Binding Information property #{key} => #{val}").yellow
              end
            end
            set[:binding_info] = info
          when 'Table Metadata'
            info = {}
            entries.each do |key, val|
              case key
              when "Table"
                info[:table] = val
              when "Table OID"
                info[:table_oid] = val
              when "SymbolicName"
                info[:symbolic_name] = val
              when "Description"
                info[:description] = val
              when "Type"
                info[:type] = val
              when "Steward"
                info[:steward] = val
              when "where used"
                info[:where_used] = val
              when "HL7 Version Introduced"
                info[:version_introduced] = val
              when "Full Name"
                info[:full_name] = val
              when "UTG URL"
                puts Rainbow("#{current_table} has UTG URL in Table Metadata").magenta
                info[:utg_url] = val
              when "Code System OID"
                puts Rainbow("#{current_table} has Code System OID in Table Metadata").magenta
                info[:cs_oid] = val
              else
                puts Rainbow("Table Metadata property #{key} => #{val}").yellow
              end
            end
            set[:metadata] = info
          else
            if current_table_type =~ /Table \d+ Coded Content/
              # puts headers.inspect
              concepts = []
              entries.each do |e|
                ["Value", "Display Name", "Definition", "Comment/ Usage Note", "Status"]
                # puts e.inspect
                concept = { value:e[0], display_name:e[1] }
                concept[:definition] = e[2].to_s.strip.empty? ? e[1] : e[2]
                concept[:comment] = e[3] if e[3]
                concept[:status] = e[4] if e[4]
                concepts << concept
              end
              set[:concepts] = concepts
            else
              puts Rainbow('192 ' + current_table_type).red
            end
          end
        when 'p'
          label = node.text.strip
          # puts Rainbow(label).green
          case label
          when 'Concept Domain Information'
          #   puts label
          when 'Code System Identification Information'
          #   puts label
          when 'Code System Version Information'
          when 'Value Set Information'
          when 'Binding Information'
          when 'Table Metadata'
          # when 'Value Set Information'
          # when 'Value Set Information'
          else
            if label =~ /Table \d+ Coded Content/
            else
              puts Rainbow('212 ' + label).red
            end
          end
          current_table_type = label
          next
      
          puts "Para: #{node.text}";next
        else
          puts node.name
          puts node
        end
      end
    end

    def set_vs_type(node)
      t = node.text
      ChangeTracker.start
      case
      when t =~ /User-defined/
        @vs.type = 'user-defined'
      when t =~ /External(ly-defined)?/
        @vs.type = 'externally-defined'
      when t =~ /HL7 Table/
        @vs.type = 'hl7-defined'
      when t =~ /Imported/
        @vs.type = 'imported'
      end
      @vs.save
      ChangeTracker.commit
    end

    def vs_p(node)
      text = node.to_s
      if text =~ /Table Metadata/
        @metadata = true
      elsif text =~ /(User-defined|External(ly-defined)?|HL7|Imported) Table/
        @values = true
        set_vs_type(node)
      elsif text =~ /These values are suggestions only; they are not required for use in HL7 messages/
        ChangeTracker.start
        @vs.values_are_suggestions = true
        ChangeTracker.commit
      else
        ChangeTracker.start
        if @vs.text
          @vs.text_content = @vs.text_content + "\n" + text
        else
          html = Gui_Builder_Profile::RichText.create(:content => text)
          html.markup_language = 'HTML'
          html.save
          @vs.text = html
        end
        @vs.save
        ChangeTracker.commit
      end
    end
    
    def create_value_set(node)
      t = node.text
      # HACK to deal with non-standard entries
      if t =~ /ISO-3166-1/
        id = 399
        name = 'Country Code (ISO-3166-1)'
      # elsif t =~ /Repeat Pattern/
      #   puts Rainbow(t).orange
      #   name = 'Repeat Pattern'
      #   id = 335
      else
        id, name = t.split(/\s+[–|-]\s+/)
      end
      return unless name
      # puts Rainbow("#{id} - #{name}").green
      ChangeTracker.start
      @vs = HL7::ValueSet.create(:name => name.strip, :table_id => id.to_i)
      ChangeTracker.commit
    end

    def add_vs_content(node, type = nil)
      t = extract_text(node).strip
      return if t.empty?
      case type
      when :example
        puts Rainbow(t).cyan
      when :note
        puts Rainbow(t).yellow
      else
        puts "Unknown type: " + Rainbow(t).orange
      end
    end

    def extract_vs_table(node)
      extract_vs_metadata(node) if @metadata
      extract_values(node) if @values
      @values   = false
      @metadata = false
    end

    def get_table_array(node)
      # if @vs.table_id == 56
      #   puts node;puts
      # end
      rows = node.at('tbody').children.reject { |n| n.name == 'text' }
      rows.map do |row|
        cells = row.children.reject { |n| n.name == 'text' }
        cells.map do |c|
          t = c.inner_html
          t.empty? ? nil : t
        end
      end
    end

    def get_table_headers(node)
      row = node.at('thead')&.children&.reject { |n| n.name == 'text' }&.first
      if row
        row.children.reject { |n| n.name == 'text' }.map do |c|
          t = c.inner_html
          t.empty? ? nil : t
        end
      else
        nil
      end
    end

    def extract_vs_metadata(node)
      rows = get_table_array(node)
      puts "#{vs.table_id} has weird metadata" unless rows.first.size == 6
      rows.each do |r|
        ChangeTracker.start
        @vs.steward = r[1]
        @vs.v3_harmonization = r[2]
        @vs.v3_equivalent = r[3]
        @vs.where_used = r[4]
        @vs.status = r[5].downcase if r[5]
        puts Rainbow("#{@vs.table_id} - #{@vs.name} has no status").red unless r[5]
        @vs.save
        ChangeTracker.commit
      end
    end

    def extract_values(node)
      rows = get_table_array(node)
      headers = get_table_headers(node)
      headers ||= rows.shift
      unless headers[0] =~ /Value/ && headers[1] =~ /Description/ && headers[2] =~ /Comment/ && headers.count == 3
        puts Rainbow(@vs.table_id.to_s + ' - ' + headers.inspect).green
      end
      ChangeTracker.start
      @vs.field_names = headers.join(' | ')
      @vs.save
      ChangeTracker.commit
      comment_header = headers.index { |f| f =~ /Comment/i }
      rows.each_with_index do |r, i|
        ChangeTracker.start
        v = HL7::Value.create
        if comment_header
          comment = r.delete_at(comment_header)
          html = Gui_Builder_Profile::RichText.create(:content => comment)
          html.markup_language = 'HTML'
          html.save
          v.comment = html
          v.save
        end
        v.field1 = r[0] if r[0]
        v.field2 = r[1] if r[1]
        v.field3 = r[2] if r[2]
        v.field4 = r[3] if r[3]      
        @vs.add_value(v)
        ChangeTracker.commit
        # p v;puts
      end
    end

  end
end

class Hash
  def deep_values_transform
    hash = self.dup
    hash.transform_values do |value|
      if value.is_a?(Hash)
        value.deep_values_transform
      else
        value.class
      end
    end
    hash
  end
  
  def key_tree
    tree = keys.map { |k| [k] }
    tree.each do |c|
      v = self[c.last]
      c.append(v.key_tree) if v.is_a?(Hash)
    end
    tree
  end
  def deep_traverse(&block)
    stack = self.map{ |k,v| [ [k], v ] }
    while not stack.empty?
      key, value = stack.pop
      yield(key, value)
      if value.is_a? Hash
        value.each{ |k,v| stack.push [ key.dup << k, v ] }
      end
    end
  end
end

def go
  input = File.expand_path('../../vocab/Tables_291', __dir__)
  extractor = V2Web::DocXtractor.new
  docx_path = input + '.docx'
  html_path = input + '.html'

  # Uncomment 2 lines below if you need to re-convert docx tables to html
  # stdout, stderr, status = Open3.capture3("pandoc -s #{docx_path} -o #{html_path}")
  # puts stderr if stderr && !stderr =~ /WARNING/i

  # doc = Docx::Document.open(docx_path)
  # extractor.compare_tho_v2(doc.doc, html_path)
  extractor.compare_tho_v2(html_path)
end

def check
  V2Web::DocXtractor.new.all_tho_v2_status
  V2Web::DocXtractor.new.all_tho_v3_status
end
go
# check