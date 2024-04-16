require 'json'
module V2Pub
  module_function

  def toc
    entries = []
    counter = 0
    domains.each do |domain|
      counter += 1
      entries << domain.to_toc(counter)
    end
    # toc_map.each do |lun|
    #   counter += 1
    #   domain = domains.find { |dom| dom.title == lun }
    #   if domain.nil?
    #     puts "Can't find '#{lun}' amongst the following:"
    #     domains.map(&:title).sort.each { |x| puts x }
    #   end
    #   entries << domain.to_toc(counter)
    # end
    manual_entries = [
      ['XML Encoding', '/xml-encoding-rules.html'],
      ['Hybrid Lower Layer Protocol', '/lower-layer-protocol.html#Heading3'],
      ['Minimal Lower Layer Protocol', '/lower-layer-protocol.html#Heading45'],
      ['HL7 Over HTTP Specification', '/hl7-over-http.html']
    ]
    manual_entries.each do |title, url|
      counter += 1
      entries << V2Pub.render_with_locals(:domain, :toc_entry, {:title => "#{counter} #{title}", :url => url, :sections => ''})
    end
    
    locals = {
      :entries => entries
    }
    content = render_with_locals(:v2plus, :toc, locals)
    save_web_file('toc.html', content)
  end

  def vocab_toc
    locals = {
      :rows => vocab_rows.join("\n")
    }
    content = render_with_locals(:vocab, :toc, locals)
    save_web_file('vocab.html', content)
  end
  
  def vocab_rows
    HL7::Vocab::CodeSystem.all.sort_by { |cs| cs.table_id }.map do |cs|
      cd = cs.concept_domain
      locals = {
        :table_number        => cs.padded_id,
        :description         => cs.description,
        :table_type          => cs.table_type_display,
        :table_usage         => cs.vocab_type,
        :vocab_url           => "vocab/#{cs.url_name}.html",
        :concept_domain_name => cd ? cd.name : nil,
        :code_system_name    => cs.code_system_is_example? ? nil : cs.name
      }
      if cd.nil? && locals[:table_number] == '0011'
        pp cs;puts; pp cs.concept_domain
        raise "WHAT"
      end
      render_with_locals(:vocab, :toc_row, locals)
    end
  end
  
  def dt_toc
    locals = {
      :rows => dt_list
    }
    content = render_with_locals(:datatype, :toc, locals)
    save_web_file('data-types.html', content)
  end

  def dt_list
    HL7::V2::DataType.all.sort_by { |dt| dt.code }.map { |dt| render_with_locals(:datatype, :toc_entry, {:dt => dt}) }
  end
  
  def seg_toc
    locals = {
      :rows => seg_list
    }
    content = render_with_locals(:segment_definition, :toc, locals)
    save_web_file('segment-definitions.html', content)
  end
  
  def seg_list
    HL7::V2::SegmentDefinition.all.sort_by { |seg| seg.code }.map { |seg| render_with_locals(:segment_definition, :toc_entry, {:seg => seg}) }
  end
  
  def msg_struct_toc
    locals = {
      :rows => ms_list
    }
    content = render_with_locals(:message_structure, :toc, locals)
    save_web_file('message-structures.html', content)
  end
  
  def ms_list
    HL7::V2::MessageStructure.all.sort_by { |ms| ms.code }.map { |ms| render_with_locals(:message_structure, :toc_entry, {:ms => ms}) }
  end
  
  def domains_toc
    locals = {
      :rows => domains_list
    }
    content = render_with_locals(:domain, :domains, locals)
    save_web_file('domains.html', content)
  end
  
  def domains_list
    domains = V2Web::Domain.all
    ordered_domains = []
    domain_names.each { |ttl, entry| ordered_domains << [domains.find { |dom| dom.title == ttl }.local_url_name, entry] }
    ordered_domains.map { |url, entry| render_with_locals(:domain, :domains_entry, {:url => url, :entry => entry}) }
  end
  
  def map_v2
    entries = []
    alt_entries = []
    chapter_map.each do |ch_num, data|
      stack   = []
      url     = data[:url]
      id_base = url.split('/').last.sub('.html', '')
      path = File.expand_path(File.join(__dir__, "../test_data/section_indices/chapter#{ch_num}.json"))
      json = JSON.parse(File.read(path))
      index = json#.invert
      raise unless #json.keys.count == index.keys.count
      index.each do |number, title|
        depth     = number.split('.').count
        id_number = number.split('.')[1..-1].join('-')
        padded_number = ('    ' * (depth - 1)) + number
        mapped_url = nil
        ttl        = title.dup
        if id_number.to_s.strip.empty?
          mapped_url = url
          map_entry = MapEntry.new(ttl, mapped_url)
        elsif number == '1.1' && title =~ /contents/i
          ttl << '  (REMOVED)'
          map_entry = MapEntry.new("#{padded_number}  #{ttl}", mapped_url)
        else
          mapped_url = "#{url}##{id_base}-#{id_number}"
          map_entry = MapEntry.new("#{padded_number}  #{ttl}", mapped_url)
        end
        # puts "#{depth} -- #{number} #{title} --> #{padded_number}  #{ttl}"
        if stack.size == 0
          stack << map_entry
        elsif stack.size < depth
          if (stack.size + 1) != depth
            pp index
            puts Rainbow(stack.last.title).green
            puts Rainbow(map_entry.title).yellow
            raise
          end
          stack.last.add(map_entry)
          stack << map_entry
        elsif stack.size == depth
          stack.pop
          stack.last.add(map_entry)
          stack << map_entry          
        else # stack.size > depth
          (stack.size - depth + 1).times { stack.pop }
          stack.last.add(map_entry)
          stack << map_entry          
        end
      end
      ch_map = stack.first.render
      content = render_with_locals(:v2plus, :single_chapter_map, {:entries => ch_map})
      save_web_file("v2-v2plus-map-#{ch_num}.html", content)
      alt_entries << {:title => stack.first.title, :url => "/v2-v2plus-map-#{ch_num}.html"}
      entries << ch_map
      # render_with_locals(:v2plus, :map_entry, {:title => "#{padded_number}  #{ttl}", :url => mapped_url})
    end
    content = render_with_locals(:v2plus, :all_chapters_map, {:entries => entries})
    save_web_file('v2-v2plus-map.html', content)
    content = render_with_locals(:v2plus, :alt_chapters_map, {:entries => alt_entries})
    save_web_file('v2-v2plus-chapters.html', content)
  end
  
  def domain_names
    domain_names = {
    'Patient Administration'  => 'ADT - Admission, Discharge, Transfer',
    'Financial Management'  => 'Financial Management',
    'Order Entry: General, Laboratory, Dietary, Supply, Blood Transfusion'  => 'Order Entry: General, Laboratory, Dietary, Supply,',
    'Order Entry: Pharmacy/Treatment, Vaccination' => 'Order Entry: Pharmacy/Treatment, Vaccination',
    'Query'  => 'Query',
    'Observation Reporting'  => 'Observation Reporting',
    'Master Files'  => 'Master Files',
    'Medical Records/Information Management (Document Management)'  => 'Medical Records/Information Management (Document',
    'Scheduling'  => 'Scheduling',
    'Patient Referral'  => 'Patient Referral',
    'Patient Care'  => 'Patient Care',
    'Clinical Laboratory Automation'  => 'Clinical Laboratory Automation',
    'Application Management'  => 'Application Management',
    'Personnel Management'  => 'Personnel Management',
    'Claims and Reimbursement'  => 'Claims and Reimbursement',
    'Materials Management'  => 'Materials Management'
    }
  end
  
  def chapter_map
    {
      '1'  => {
                :title => 'Introduction', 
                :url   => 'domain/Introduction.html'
              },
      '2'  => {
                :title => 'Control',
                :url   => 'domain/Control.html'
              },
      '2A' => {
                :title => 'Data Types',
                :url   => 'domain/Data-Type.html'
              },
      '3'  => {
                :title => 'Patient Administration',
                :url   => 'domain/Patient-Administration.html'
              },
      '4'  => {
                :title => 'Order Entry: General, Laboratory, Dietary, Supply, Blood Transfusion',
                :url   => 'domain/Order-Entry-General-Laboratory-Dietary-Supply-Blood-Transfusion.html'
              },
      '4A' => {
                :title => 'Order Entry: Pharmacy/Treatment, Vaccination',
                :url   => 'domain/Order-Entry-Pharmacy-Treatment-Vaccination.html'
              },
      '5'  => {
                :title => 'Query',
                :url   => 'domain/Query.html'
              },
      '6'  => {
                :title => 'Financial Management',
                :url   => 'domain/Financial-Management.html'
              },
      '7' => {
                :title => 'Observation Reporting',
                :url   => 'domain/Observation-Reporting.html'
              },
      '8'  => {
                :title => 'Master Files',
                :url   => 'domain/Master-Files.html'
              },
      '9'  => {
                :title => 'Medical Records/Information Management (Document Management)',
                :url   => 'domain/Medical-Records-Information-Management-Document-Management.html'
              },
      '10' => {
                :title => 'Scheduling',
                :url   => 'domain/Scheduling.html'
              },
      '11' => {
                :title => 'Patient Referral',
                :url   => 'domain/Patient-Referral.html'
              },
      '12' => {
                :title => 'Patient Care',
                :url   => 'domain/Patient-Care.html'
              },
      '13' => {
                :title => 'Clinical Laboratory Automation',
                :url   => 'domain/Clinical-Laboratory-Automation.html'
              },
      '14' => {
                :title => 'Application Management',
                :url   => 'domain/Application-Management.html'
              },
      '15' => {
                :title => 'Personnel Management',
                :url   => 'domain/Personnel-Management.html'
              },
      '16' => {
                :title => 'Claims and Reimbursement',
                :url   => 'domain/Claims-and-Reimbursement.html'
              },
      '17' => {
                :title => 'Materials Management',
                :url   => 'domain/Materials-Management.html'
              }
    }
  end
  
  # def toc_map
  #   [
  #     'Introduction',
  #     'Control',
  #     'Data Type',
  #     'Patient Administration',
  #     'Order Entry General Laboratory Dietary Supply Blood Transfusion',
  #     'Order Entry Pharmacy Treatment Vaccination',
  #     'Query',
  #     'Financial Management',
  #     'Observation Reporting',
  #     'Master Files',
  #     'Medical Records Information Management Document Management',
  #     'Scheduling',
  #     'Patient Referral',
  #     'Patient Care',
  #     'Clinical Laboratory Automation',
  #     'Application Management',
  #     'Personnel Management',
  #     'Claims and Reimbursement',
  #     'Materials Management'
  #   ]
  # end
end
