require 'htmlentities'
module V2Web
  @htmlentities = HTMLEntities.new
  def self.htmlize(string)
    @htmlentities.encode(string).hl7
  end
end

HTMLEntities.new
class String
  def hl7
    self.gsub('–', '&ndash;')
        .gsub('–', '&ndash;')
        .gsub('—', '&ndash;')
        .gsub('©', '&copy;')
        .gsub('®', '&reg;')
        .gsub('“', '&ldquo;')
        .gsub('”', '&rdquo;')
        .gsub('’', '&rsquo;')
        .gsub(" ", '&nbsp;')
        .gsub("√", '&check;')
  end
end
