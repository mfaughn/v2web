require 'net/http'
require 'uri'

module HL7::Vocab
  class CodeSystem
    def stat
      puts Rainbow(" #{padded_id} - #{name}").cyan
      puts "TableType: #{(table_type&.value || 'NONE')}; BindingType: #{binding_type&.value.inspect}"
      puts description
      puts "has #{concepts_count} concepts"
    end
    
    def local_url_name
      table_id.to_s.rjust(4, '0')
    end
    
    def to_web_pub
      locals = {
        :metadata_table => metadata_table_html,
        :concepts_table => concepts_table_html
      }
      page = V2Pub.render_with_locals(:code_system, :page, locals)
      V2Pub.save_web_file("vocab/#{url_name}.html", page)
    end
    
    def padded_id
      table_id.to_s.rjust(4, '0')
    end
    
    def page_title
      "#{name} (#{padded_id})"
    end
    
    # FIXME entries are missing.  e.g., 0794
    def url_name
      "#{padded_id}-#{name ? name.gsub(/\s/, '-') : 'ERROR! Bad Data! FIXME'}"
    end
        
    def metadata_table_html
      csie = code_system_is_example?
      locals = {
        :caption      => name,
        :vocab_type   => vocab_type(csie),
        :cd_name      => concept_domain&.name || 'Missing Concept Domain!',
        :name         => csie ? name : '',
        :cs_id        => csie ? "HL7#{padded_id}_v2+#{V2_VERSION}" : '',
        :cs_oid       => csie ? cs_oid : '',
        :table_id     => "HL7#{padded_id}",
        :version      => csie ? cs_version : '',
        :status       => status&.value || 'Active', # FIXME make sure that nil actually means "Active"
        :where_used   => where_used_legacy, # FIXME calculate where used instead of depending on legacy
        :purpose_and_use => description
      }
      V2Pub.render_with_locals(:code_system, :metadata_table, locals)
    end
    
    def table_type_display
      ttv = table_type&.value
      case ttv
      when 'HL7'#, 'hl7-defined'
        ttv + '-defined'
      when 'HL7-EXT'
        ttv
      when 'Imported'#,'imported'
        ttv
      when 'User'#,'user-defined'
        ttv + '-defined'
      when 'Externally defined'#,'externally-defined'
        ttv
      when 'no longer used'
        ttv
      when nil
        'UNDEFINED'
      else
        raise "Unknown table type '#{ttv}'!"
      end
    end
    
    def code_system_is_example?
      binding_type&.value.to_s.slice(/\(\d\)/).to_i > 2
    end
    
    def vocab_type(example = nil)
      example ||= code_system_is_example?
      ttv = table_type&.value
      if concepts_count < 1 
        return 'Concept Domain'
      end
      
      vt = case ttv
           when 'hl7-defined', 'HL7'
             'Code System - Universal'
           when 'user-defined', 'User'
             if example
               'Concept Domain - With Example Codes'
             else
               'Code System - Representative'
             end
           when 'externally-defined', 'Externally defined'
             if example
               'Concept Domain - With Example Codes' + " (Externally Defined)"
             else
               'Code System - Representative' + " (Externally Defined)"
             end
           when 'imported', 'Imported'
             if example
               'Concept Domain - With Example Codes' + " (Imported)"
             else
               'Code System - Representative' + " (Imported)"
             end
           when 'no longer used'
             if example
               'Concept Domain - With Example Codes' + " (No Longer Used)"
             else
               'Code System - Representative' + " (No Longer Used)"
             end
           when 'HL7-EXT'
             if example
               'Concept Domain - With Example Codes' + " (#{ttv})"
             else
               'Code System - Representative' + " (#{ttv})"
             end
           else
             raise "What is a table of type #{ttv}??"
           end
      vt
    end
    
    def concepts_table_html
      return '' if concepts_count < 1
      locals = {
        # :code_systems_index => 'code-systems.html',
        :caption      => "#{name} - Code System",
        # :table_id     => table_id,
        :concept_rows => concept_rows
      }
      V2Pub.render_with_locals(:code_system, :concepts_table, locals)
    end
    
    def concept_rows
      rows = []
      concepts.each do |conc|
        rows << conc.to_row
      end
      rows.join("\n")
    end
        
    def row_id
      code.downcase
    end
    
    
    
    
    
    
    
    
    
    
    
    
    def github_sot_raw
      'https://raw.githubusercontent.com/HL7/UTG/master/input/sourceOfTruth/v2/codeSystems/cs-v2-' +
      table_id.to_s.rjust(4,'0') + '.xml'
    end
    
    def parse_github
      f    = Net::HTTP.get(URI.parse(github_sot_raw))
      fhir = File.open(file) { |f| Nokogiri::XML(f) }.at_css('CodeSystem')
      version = fhir.at_css.attr('value')
      description = fhir.at_css('description').attr('value')
      concepts    = extract_concepts(fhir.css('concept'))
      
    end
    
    def extract_concepts(nodes)
      concepts = []
      nodes.each do |node|
        code = node.at_css('code').attr('value')
        defn = node.at_css('definition').attr('value')
        display = node.at_css('display').attr('value')
        # ChangeTracker.start
        concept = HL7::Concept.new(code, display, defn)
        properties = node.css('property')
        # ChangeTracker.commit
        concept
      end
      
    end
  end # CodeSystem
end
