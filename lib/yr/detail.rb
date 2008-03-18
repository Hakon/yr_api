module Yr
  class Detail
    attr_accessor :symbol, :precipitation, :wind, :temperature, :from, :to
    def time_range
      from..to
    end
    
    def time_range=(a_range)
      self.from   = a_range.begin
      self.to     = a_range.end
    end
    
    def to_s
      "Temperature #{temperature}"
    end
    
  end
end