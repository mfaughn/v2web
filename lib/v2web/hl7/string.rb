class String
  def hl7
    self.gsub('–', '&ndash;')
        .gsub('©', '&copy;')
        .gsub('®', '&reg;')
        .gsub('“', '&ldquo;')
        .gsub('”', '&rdquo;')
        .gsub('’', '&rsquo;')
        .gsub(" ", '&nbsp;')
  end
end
