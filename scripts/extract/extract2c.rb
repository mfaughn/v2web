require 'net/http'
require 'open-uri'
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

require 'simple_xlsx_reader'
require 'rainbow'
SimpleXlsxReader.configuration.auto_slurp = true
require 'write_xlsx'
require 'csv'
require 'open3'
require_relative 'extractor_helpers'
require 'active_support/inflector'
require 'json'

class Hash
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



#  FIXME  this probably needs to be fixed up in order to use it again.  It was left in a half-worked on state while working on the comparison b/w THO and v2




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
    
    def check_uri(val, table, history = [])
      return if val.nil?
      begin
        r = Net::HTTP.get_response(URI.parse(val))
      rescue Exception => e
        history.each { |h| puts h }
        puts Rainbow(e.message).orange + ' ' + table
        return
      end
      return if r.code == '200'
      if r.code =~ /30(1|2)/
        history << Rainbow(val).yellow + ' -> ' + Rainbow(r['location']).green 
        check_uri(r['location'], table, history)
      else
        puts Rainbow(val).red + " #{r.code}"
      end
    end
    
    def tho_v2
      tables = {}
      dir = File.expand_path('~/projects/utg_work/tho5.0.3')
      jsons = Dir["#{dir}/**/*.json"]
      vs_files = jsons.select { |f| f =~ /ValueSet/ }
      cs_files = jsons.select { |f| f =~ /CodeSystem/ }
      v2_tables_file       = cs_files.find { |f| f =~ /CodeSystem-v2-tables/ }
      concept_domains_file = cs_files.find { |f| f =~ /CodeSystem-conceptdomains/ }
      
      v2_tables_cs       = JSON.parse(File.read(v2_tables_file))['concept']
      concept_domains_cs = JSON.parse(File.read(concept_domains_file))['concept']
            
      # css = {}
      # cs_files.each do |f|
      #   hash = JSON.parse(File.read(f))
      #   css[hash['id']] = hash
      # end
      #
      # vss = {}
      # vs_files.each do |f|
      #   hash = JSON.parse(File.read(f))
      #   vss[hash['id']] = hash
      # end
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
      
    end
    
    def extract_sets(doc, html)
      # if DocXtractor._2c_sets
      #   puts Rainbow("Sets already done.").green
      #   return DocXtractor._2c_sets
      # end
      @html = File.open(html) { |f| Nokogiri::XML(f) }
      doc.remove_namespaces!
      # @vs = nil
      # @metadata = false
      # @values = false
      @sets = {}
      do2c
      DocXtractor._2c_sets(@sets)
      @sets
    end
    
    def extract2c(doc, html)
      
      
      # tho_v2; return
      
      
      # @@_2c_sets = nil # uncomment to reset extracted sets
      sets = extract_sets(doc, html)
      pp sets[sets.keys.first]#; return
      keys1 = []
      keys2 = {}
      sets.each do |namenum, data|
        num, name = namenum.split(/\s+-+\s+/)
        unless num =~ /\d+/ && name
          puts Rainbow(namenum).yellow
        end
        name.gsub!(/\n/, ' ')
        name.gsub!(/\s+/, ' ')
        # puts "#{name} :: #{num}"
        data.keys.each { |k| keys1 << k unless k == :concepts }
      end
      keys1.uniq!
      # puts keys1
      keys1.each do |k|
        keys2[k] ||= []
      end
      
      # sets.each do |k1, v|
      
      sets.values.each do |xxx|
        # pp xxx;return
        keys1.each do |k1|
          v = xxx[k1]
          if v.is_a?(Hash)
            v.keys.each { |k2| keys2[k1] << k2 unless keys2[k1].include?(k2) }
          else
          end
          # puts Rainbow(kx).green
          # pp v
        end
        # puts '***********************'
        # return
        # if v.is_a?(Hash)
        #   v.each do |k2, v2|
        #     if v2.is_a?(Hash)
        #       keys2[k1][k2] ||= {}
        #       v2.each do |k3, v3|
        #         if v3.is_a?(Hash)
        #           keys2[k1][k2][k3] ||= {}
        #           v3.each do |k4, v4|
        #             keys2[k1][k2][k3][k4] ||= []
        #             keys2[k1][k2][k3][k4] << v4.class unless keys2[k1][k2][k3][k4].include?(v4.class)
        #           end
        #         else
        #           keys2[k1][k2][k3] ||= []
        #           keys2[k1][k2][k3] << v3.class unless keys2[k1][k2][k3].include?(v3.class)
        #         end
        #       end
        #     else
        #       keys2[k1][k2] ||= []
        #       keys2[k1][k2] << v2.class unless keys2[k1][k2].include?(v2.class)
        #       # puts "K2 What? #{k2} => #{v2.class}"
        #     end
        #   end
        # else
        #   puts "K1 What? #{k1} => #{v.class}"
        # end
      end
      columns = []
      keys2.each do |k,vals|
        vals.each do |v|
          columns << "Ch2c #{k.to_s.titleize} - #{v.to_s.titleize}"
        end
      end
      # puts columns
      columns.unshift('Ch2c Table')
      rows = []
      sets.each do |namenum, data|
        entry = []
        num, name = namenum.split(/\s+-+\s+/)
        unless num =~ /\d+/ && name
          puts Rainbow(namenum).yellow
        end
        name.gsub!(/\n/, ' ')
        name.gsub!(/\s+/, ' ')
        entry << "#{num} -- #{name}"
        keys2.each do |k,vals|
          vals.each do |v|
            entry << data.dig(k,v)
          end
        end
        rows << entry
        # puts entry.inspect
      end
      write_csv_v2_only(columns, rows)
    end
    
    def write_csv_v2_only(headers, rows)
      filename = "ch2c_all_#{Time.now.strftime('%Y%m%d_%H%M')}"
      csv_file_all = File.expand_path(File.join(__dir__, "../../vocab/#{filename}.csv"))
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
                # puts Rainbow("#{current_table} Concept Domain Has Symbolic Name with Spaces").yellow if val.strip =~ /\s/
                # puts Rainbow("#{current_table} Concept Domain Has Symbolic Name with invalid characters").yellow if val.strip =~ /[^ A-Za-z0-9_]/
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
            unless entries.find { |k,v| k =~ /URL/ }
              puts current_table.to_s + Rainbow(" No URL").red
            end
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
                # puts Rainbow("#{current_table} CSII Has Symbolic Name with Spaces").cyan if val.strip =~ /\s/
                # puts Rainbow("#{current_table} CSII Has Symbolic Name with invalid characters").cyan if val.strip =~ /[^ A-Za-z0-9_]/
                info[:symbolic_name] = val
              when "Description"
                info[:description] = val
              when "Full Name"
                info[:full_name] = val
              when "UTG URL"
                puts Rainbow("Table #{current_table} UTG URL is #{val}").orange unless val =~ /terminology.hl7.org/
                if val
                  check_uri(val, current_table)
                end
                info[:utg_url] = val
              when "Webpage URL"
                info[:web_url] = val
              when "UTG Name"
                info[:utg_name] = val
              when "Comments"
                info[:comments] = val
              else
                puts Rainbow("Table #{current_table} has Code System Identification Information property #{key} => #{val}").yellow
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
                # puts Rainbow("#{current_table} VSI Has Symbolic Name with Spaces").blue if val.strip =~ /\s/
                # puts Rainbow("#{current_table} VSI Has Symbolic Name with invalid characters").blue if val.strip =~ /[^ A-Za-z0-9_]/
                info[:symbolic_name] = val
              when "Description"
                info[:description] = val
              when "Full Name"
                info[:full_name] = val
              when "UTG URL"
                info[:utg_url] = val
                if val
                  check_uri(val, current_table)
                end
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
                # puts "#{current_table} Table Metadata Has Symbolic Name with Spaces" if val.strip =~ /\s/
                # puts Rainbow("#{current_table} Table Metadata Has Symbolic Name with invalid characters").orange if val.strip =~ /[^ A-Za-z0-9_]/
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
                # puts Rainbow("#{current_table} Table Metadata Has Full Name #{val}").red
                info[:full_name] = val
              when "UTG URL"
                puts Rainbow("#{current_table} has UTG URL in Table Metadata").magenta
                if val
                  check_uri(val, current_table)
                end
                info[:utg_url] = val
              when "Code System OID"
                puts Rainbow("#{current_table} has Code System OID in Table Metadata").magenta
                info[:cs_oid] = val
              else
                puts Rainbow("#{current_table} Table Metadata property #{key} => #{val}").yellow
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
              if current_table_type.nil?
                puts Rainbow('current_table_type in nil').yellow
                next
              end
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

    # def _extract_value_sets(node)
    #   case node.name
    #   when 'body', 'document'
    #     node.children.each { |c| _extract_value_sets(c) }
    #   when 'tbl'
    #     extract_vs_table(node)
    #   when 'bookmarkStart', 'bookmarkEnd', 'sectPr'
    #     # ignore
    #   when 'p'
    #     last_node_was_list = false
    #     # puts Rainbow(node.path).green
    #     styles = node.xpath('.//pPr/pStyle')
    #     puts Rainbow('Multiple Styles!').red if styles.count > 1
    #     if styles.first
    #       val_attr = styles.first.attributes.find { |a| a.first == 'val' }
    #       style = val_attr.last.value
    #       if style =~ /Heading/
    #         if style[-1].to_i == 4
    #           create_value_set(node)
    #         else
    #           raise
    #         end
    #       else
    #         case style
    #         when 'TOC1', 'TOC2', 'TOC3', 'TOC4', 'TOC5', 'TableofFigures'
    #         when 'NormalIndented'
    #           #FIXME
    #         when 'HL7TableCaption'
    #           @values = true
    #           ChangeTracker.start
    #           @vs.defined_by = 'hl7'
    #           ChangeTracker.commit
    #         when 'UserTableCaption'
    #           @values = true
    #           ChangeTracker.start
    #           @vs.defined_by = 'user'
    #           ChangeTracker.commit
    #         when 'TableMetaCaption'
    #           @metadata = true
    #         when 'Note'
    #           add_vs_content(node, :note)
    #         when 'Example'
    #           add_vs_content(node, :example)
    #         else
    #           puts 'Unknown style for paragraph: ' + Rainbow(style).red
    #         end
    #       end
    #     else
    #       text = extract_text(node).strip
    #       if text =~ /These values are suggestions only; they are not required for use in HL7 messages/
    #         ChangeTracker.start
    #         @vs.values_are_suggestions = true
    #         ChangeTracker.commit
    #       else
    #         add_vs_content(node)
    #         # puts Rainbow(node.to_s).orange unless text.empty?
    #         # puts Rainbow(text).orange unless text.empty?
    #       end
    #     end
    #   else
    #     puts Rainbow(node.name).orange
    #     puts node.to_xml[0..1000]
    #   end
    # end

  end
end
