module Yr 
  module Raw
    URI = URI.parse("http://api.yr.no/weatherapi/")
    class ServerError<StandardError;end
    class Base
      attr_reader :name, :version
      def initialize(name, version)
        @name = name
        @version = version
      end
    
      def build(query = {})
        URI + "#{name}/#{version}/" + ("?" + query.inject("") do |m,(key, value)|
          "#{key}=#{value};#{m}"
        end).chop
      end
    
      def fetch(query_or_uri = {})
        query_or_uri = build(query_or_uri) if query_or_uri.is_a? Hash
        uri = query_or_uri
        
        res = Net::HTTP.start(uri.host, uri.port) do |http|
          http.get(uri.to_s[16..-1])
        end
        
        return res if res.is_a? Net::HTTPSuccess
        raise ServerError, "Try \"#{uri.to_s}\" in your browser to debug"
      end
      
      def parse(query_or_uri = {})
        res = fetch(query_or_uri)
        if res["content-type"][0..7] == "text/xml"
          Hpricot.XML(res.body)
        else
          res.body
        end
      end
      
      def inspect
        "<##{name}:#{version}>"
      end
    end
    
    Buoy = Base.new(:buoy, 1.0)
    Errornotifications = Base.new(:errornotifications, 1.0)
    ExtremesWWC = Base.new(:extremesWWC, 1.0)
    Forestfireindex = Base.new(:forestfireindex, 1.0)
    Geosatellite = Base.new(:geosatellite, 1.1)
    Icemap = Base.new(:icemap, 1.0)
    Locationforecast = Base.new(:locationforecast, 1.4)
    Mountaineasterobservations = Base.new(:mountaineasterobservations, 1.0)
    Polarsatellite = Base.new(:polarsatellite, 1.0)
    Radar = Base.new(:radar, 1.1)
    Refraction = Base.new(:refraction, 1.0)
    Seaapproachforecast = Base.new(:seaapproachforecast, 1.0)
    Seasonforecast = Base.new(:seasonforecast, 1.0)
    Stavernodden = Base.new(:stavernodden, 1.0)
    Textforecast = Base.new(:textforecast, 1.2)
    Tidalwater = Base.new(:tidalwater, 1.1)
    Trondheimsleia = Base.new(:trondheimsleia, 1.0)
    UVforecast = Base.new(:uvforecast, 1.0)
    Weatherformetnosite = Base.new(:weatherformetnosite, 1.0)
    Weathericon = Base.new(:weathericon, 1.0)
    Windforecast = Base.new(:windforecast, 1.0)
  end
end  