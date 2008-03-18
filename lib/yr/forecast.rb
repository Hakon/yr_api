module Yr
  class Forecast
    attr_accessor :from, :to, :title, :body, :place
    def time_range
      from..to
    end

    def to_s
      result = ["Værvarsel for #{place}"]
      result << "Tidsrom: #{time_range}"
      result << title
      result << body
      result.join("\n")
    end
  end
end