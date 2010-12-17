module Yr
  class Location
    attr_reader :altitude, :details, :doc
    def initialize(lat, lng)
      @latitude     = lat
      @longitude    = lng
    end
    
    def current_weather
      return details_hash[Time.now.change(:min => 0, :sec => 0, :usec => 0)]
    end
    
    def details_hash
      @details ||= parse_time_slots(doc)
    end
    
    def details
      details_hash.values
    end
    
    def doc
      @doc ||= Raw::Locationforecast.parse(:lat => @latitude, :lon => @longitude)
    end
    
    protected
    
    def parse_time_slots(document)
      time_hash = {}
      time_slots = @doc.search('product time')
      time_slots.each do |node|
        hour = Time.at(Time.xmlschema(node[:from]) - Time.zone_offset("CET"))
        detail = time_hash[hour] ||= Detail.new
        detail.time_range = hour..hour #This should really be fixed. keeping it for backwards compatability
        
        unless @altitude
          loc = node.at("location")
          @altitude = loc[:altitude] if(loc)
        end
        
        if(wd = node.at("windDirection"))
          detail.wind ||= Wind.new
          detail.wind.direction = wd[:def].to_f
        end
        
        if ws = node.at('windSpeed')
         detail.wind ||= Wind.new
         detail.wind.speed_name = ws[:name]
         detail.wind.speed_mps = ws[:mps].to_f
        end
        
        if temp = node.at('temperature')
         detail.temperature = temp[:value].to_f
        end

        if sym = node.at('symbol')
         s = Symbol.new(sym[:number], sym[:id])
         detail.symbol = s
        end
      end
      time_hash
    end
    
  end
end