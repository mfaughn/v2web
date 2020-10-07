module V2Web
  def self.make_gbp_file(path)
    ChangeTracker.start
    f = Gui_Builder_Profile::File.create(:filename => path.split('/').last, :mime_type => get_mime_type(path))
    bd = Gui_Builder_Profile::BinaryData.create(:data => File.binread(path))
    f.binary_data = bd
    f.save
    ChangeTracker.commit
    f
  end
  
  def self.get_mime_type(path)
    `file --brief --mime-type - < #{Shellwords.shellescape(path)}`.strip
  end
end
