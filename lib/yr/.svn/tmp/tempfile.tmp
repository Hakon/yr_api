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
      @xml = open(url).read
      @details = []
      parser = XML::Parser.string(@xml).parse
      parser.find('//product/time').each do |node|
        time_range = Time.xmlschema(node[:from])..Time.xmlschema(node[:to])
        if t = @details.select{|t| t.time_range == time_range}.first
          time = t
        else
          time = Detail.new
          time.time_range = time_range
          @details << time
        end
        
        unless @altitude
          if loc = node.find_first('//location')
            @altitude = loc[:altitude]
          end
        end
        if wd = node.find_first('//windDirection')
          time.wind ||= Wind.new
          time.wind.direction = wd[:def].to_f
        end
        if ws = node.find_first('//windSpeed')
          time.wind ||= Wind.new
          time.wind.speed_name = ws[:name]
          time.wind.speed_mps = ws[:mps].to_f
        end
        if temp = node.find_first('//temperature')
          time.temperature = temp[:value].to_f
        end
        
        if sym = node.find_first('//symbol')
          s = Symbol.new(sym[:number], sym[:id])
          time.symbol = s
        end
      end
    end
    
    def url
      "http://api.yr.no/weatherapi/locationforecast/1.4/?lat=#{@latitude};lon=#{@longitude}"
    end
    
  end
end