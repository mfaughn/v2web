module Sequel
  class Model
    def persist(path)
      # TODO standardize #local_url_name as a primary key and use better method name
      # all models should have default means of creating a uniq primary key
      # expectation is that individual classes will override this method
      path = File.join(path, local_url_name + '.xml')
      puts Rainbow(inspect).yellow unless local_url_name
      # puts "Persisting #{path}"
      File.open(path, 'w') do |f|
        f.puts to_resource
      end
    end
  end
  
end
