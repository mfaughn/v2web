project "Test", :version => "1", :original_filename => "test.mdj", :generated_by => "Star UML plugin: ruby-dsl-generator.js v0.0.0", :generated_at => "Fri Aug 11 2023 08:07:55 GMT-0600 (Mountain Daylight Time)", :additional_info => { :selected_model => { :name => "Application", :id => "AAAAAAFF+qBWK6M3Z8Y=", :pluralize_role_names => true, :snakecase_role_names => true }}, :id => "AAAAAAFF+h6SjaM2Hec=" do
  model "Application", :imports => ["Package1"], :id => "AAAAAAFF+qBWK6M3Z8Y="
  package "Package1", :id => "AAAAAAGJ5OflvPgdA0g=" do
     # Association # Package1::B::a1 <-> Package1::A::b2
    association :properties => ["Package1::A::a1", "Package1::B::b2"], :id => "AAAAAAGJ5Oh1dvh1kJE="
    klass "A", :id => "AAAAAAGJ5Ogzc/gh2QU=" do
      property "a1", :type => "Package1::B", :id => "AAAAAAGJ5Oh1dvh2jPg="
    end
    klass "B", :id => "AAAAAAGJ5Og9KvhKM5s=" do
      property "b2", :type => "Package1::A", :id => "AAAAAAGJ5Oh1dvh3lfM="
    end
  end # package Package1
end # project Test
