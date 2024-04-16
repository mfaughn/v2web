project "Test", :version => "2", :original_filename => "test.mdj", :generated_by => "Star UML plugin: ruby-dsl-generator.js v0.0.0", :generated_at => "Fri Aug 11 2023 08:34:08 GMT-0600 (Mountain Daylight Time)", :additional_info => { :selected_model => { :name => "Application", :id => "AAAAAAFF+qBWK6M3Z8Y=", :pluralize_role_names => true, :snakecase_role_names => true }}, :id => "AAAAAAFF+h6SjaM2Hec=" do
  model "Application", :imports => ["Package1"], :id => "AAAAAAFF+qBWK6M3Z8Y="
  package "Package1", :id => "AAAAAAGJ5OflvPgdA0g=" do
     # Association # Package1::B::a1 <-> Package1::A::b2
    association :properties => ["Package1::A::a1", "Package1::B::b2"], :id => "AAAAAAGJ5Oh1dvh1kJE="
     # Association # Package1::A::aa1 <-> Package1::B::bb2
    association :properties => ["Package1::B::aa1", "Package1::A::bb2"], :id => "AAAAAAGJ5PPpxQS+pYY="
     # Association # Package1::B::first <-> Package1::A::second
    association :properties => ["Package1::A::first", "Package1::B::second"], :id => "AAAAAAGJ5PpaLsZhh0M="
    klass "A", :id => "AAAAAAGJ5Ogzc/gh2QU=" do
      property "a1", :type => "Package1::B", :id => "AAAAAAGJ5Oh1dvh2jPg="
      property "bb2", :type => "Package1::B", :id => "AAAAAAGJ5PPpxQTA+2A="
      property "first", :type => "Package1::B", :id => "AAAAAAGJ5PpaLsZiAIc="
    end
    klass "B", :id => "AAAAAAGJ5Og9KvhKM5s=" do
      property "b2", :type => "Package1::A", :id => "AAAAAAGJ5Oh1dvh3lfM="
      property "aa1", :type => "Package1::A", :id => "AAAAAAGJ5PPpxQS/fmU="
      property "second", :type => "Package1::A", :id => "AAAAAAGJ5PpaLsZjnXM="
    end
  end # package Package1
end # project Test
