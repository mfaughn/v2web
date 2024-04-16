module V291
  module_function
  
  def substitute_references(content)
    output = []
    content.each do |item|
      if item.class.name =~ /HL7::V2/
        raise "Shite" if ChangeTracker.started?
        ChangeTracker.start
        ref = V2Web::Reference.new
        ref.ref = item
        ref.save
        ChangeTracker.commit
        output << ref
      else
        output << item
      end
    end
    output
  end

end
