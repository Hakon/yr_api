module Yr
  class Location
    attr_reader :altitude, :details
    def initialize(lat, lng)
      @latitude     = lat
      @longitude    = lng
    end
    
    def current_weather
      return details.sort{|a, b| a.from <=> b.from}.first
    end
    
    def load_xml_doc
      @doc = Raw::Locationforecast.parse(:lat => @latitude, :lon => @longitude)
      @details = []
      @doc.search('product time').each do |node|
        time_range = Time.xmlschema(node[:from])..Time.xmlschema(node[:to])
        if t = @details.select{|t| t.time_range == time_range}.first
          time = t
        else
          time = Detail.new
          time.time_range = time_range
          @details << time
        end
        
        unless @altitude
          if loc = node.at('location')
            @altitude = loc[:altitude]
          end
        end
        if wd = node.at('windDirection')
          time.wind ||= Wind.new
          time.wind.direction = wd[:def].to_f
        end
        if ws = node.at('windSpeed')
          time.wind ||= Wind.new
          time.wind.speed_name = ws[:name]
          time.wind.speed_mps = ws[:mps].to_f
        end
        if temp = node.at('temperature')
          time.temperature = temp[:value].to_f
        end
        
        if sym = node.at('symbol')
          s = Symbol.new(sym[:number], sym[:id])
          time.symbol = s
        end
      end
    end
  end
end