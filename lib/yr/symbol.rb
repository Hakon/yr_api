module Yr
  class Symbol
    attr_accessor :number, :name
    def initialize(number,name)
      self.number = number
      self.name = name
    end
    
    def icon
      Yr::Raw::Weathericon.build(:symbol => number, :content_type => "image_png").to_s
    end
  end
end