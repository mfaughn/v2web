require 'docx'

paths = ['nokogiri_extensions.rb', 'headers_footers.rb', 'clear_tables.rb', 'compact_content.rb', 'headers_hack.rb', 'empty_sections_hack.rb']
paths.each do |path|
  load path
  # require_relative path
end

extractors = ['extractor.rb', 'extractor_helpers.rb', 'extract_msgs.rb', 'extract_acs.rb', 'extract_datatypes.rb', 'extract_chapters.rb']
extractors.each do |name|
  path = File.expand_path(File.join(__dir__, '../extract', file))
  load path
  # require path
end

module HL7Parse
  def test_data_dir
    File.expand_path(File.join(__dir__, '../../test_data/v2.9_Dec16'))
  end
  
  def source_dir
    File.join(test_data_dir, 'v2.9_Dec16')
  end

  def get_source(name, dir = source_dir)
    File.join(dir, name)
  end

  def docx_path(path, dir = source_dir)
    get_source(path, dir) + '.docx'
  end

  def html_path(path, dir = source_dir)
    get_source(path, dir) + '.html'
  end
  
  def zip_path(path, dir = source_dir)
    get_source(path, dir) + '.zip'
  end
  
  def unzip_path(path, dir = source_dir)
    get_source(path, dir)
  end
    
  def self.data_sources
    [
      'V29_CH03_PatientAdmin',
      'v29_CH04_Orders',
      'V29_CH04A_Orders',
      'V29_CH05_Queries',
      'V29_CH06_FinancialMngmt',
      'V29_CH07_Observations',
      'V29_CH08_MasterFiles',
      'V29_CH09_MedRecords',
      'V29_CH10_Scheduling',
      'V29_CH11_PatientReferral',
      'V29_CH12_PatientCare',
      'V29_CH13_ClinicalLabAuto',
      'V29_CH14_AppMngmt',
      'V29_CH15_PersMngmt',
      'V29_CH16_eClaims',
      'V29_CH17_MaterialsMngmt',
      nil
    ]
  end
end
