def xml_language_type
  xml = Gui_Builder_Profile::LanguageType.where(:value => 'XML').first
  unless xml
    ChangeTracker.start
    xml = Gui_Builder_Profile::LanguageType.create(:value => 'XML')
    ChangeTracker.commit
  end
  xml
end
