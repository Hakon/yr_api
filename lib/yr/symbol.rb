module Yr
  class Symbol
    attr_accessor :number, :name
    def initialize(number,name)
      self.number = number
      self.name = name
    end
    
    def icon
      "http://api.yr.no/weatherapi/weathericon/1.0/?symbol=#{number};content_type=image/png"
    end
  end
end