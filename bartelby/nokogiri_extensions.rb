module GetVal
  def get_val(selector)
    # at_xpath(xpath)&.[]('value')
    css(selector).attribute('value')&.value
  end
end
class Nokogiri::XML::NodeSet
  include GetVal
  # def get_val(str)
  #   # puts "NodeSet"
  #   # at_xpath(xpath)&.[]('value')
  #   css(str).attribute('value')&.value
  # end
end
class Nokogiri::XML::Element
  include GetVal
  # def get_val(str)
  #   puts "Element #{name}: #{str}"
  #   v = at_xpath(str)&.[]('value')
  #   if v
  #     puts "    #{v.inspect}"
  #     puts
  #     puts self
  #     raise
  #   end
  #   v
  #   # css(selector).attribute('value')&.value
  # end
end
