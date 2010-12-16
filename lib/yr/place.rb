module Yr
  class Place
    attr_accessor :fylke, :kommune,  :sted

    def initialize(opts)
      opts.each{|k,v| self.send("#{k}=", v)}
    end

    class << self
      def all_places
        YAML::load_file(File.join(File.dirname(__FILE__), "../../config/places.yml"))
      end
      def find(place_name)
        all_places.find{|p| p.sted == place_name}
      end
    end

    def weather_url
     "http://www.yr.no/sted/Norge/#{URI.encode(fylke.capitalize)}/#{URI.encode(kommune.capitalize)}/#{URI.encode(sted.capitalize)}/varsel.xml"
    end

    def forecast_for(time)
      forecasts.find{|f| f.time_range.include?(time)}
    end

    def details_for(time)
      details.find{|d| d.time_range.include?(time)}
    end

    def forecasts
      @forecasts ||= fetch_forecasts
    end
    
    def details
      @details ||= fetch_details
    end
    
    def to_s
      sted
    end

    def fetch_details
      @details = []
      (xml_doc/"weatherdata/forecast/tabular/time").each do |t|
        d = Detail.new
        d.from = Time.xmlschema((t["from"]))
        d.to = Time.xmlschema((t["to"]))
        d.precipitation = t.at("precipitation").attributes["value"].to_f
        s = Symbol.new(t.at("symbol").attributes["number"].to_i, t.at("symbol").attributes["name"])
        d.symbol = s
        wind = Wind.new
        wind.direction = t.at("winddirection").attributes["deg"].to_f
        wind.speed_name = t.at("windspeed").attributes["name"]
        wind.speed_mps = t.at("windspeed").attributes["mps"].to_f
        d.wind = wind
        d.temperature = t.at("temperature").attributes["value"].to_f
        @details << d
      end
      return @details.sort!{|a,b|a.from<=>b.from}
    end

    def fetch_forecasts
      @forecasts = []
      # xml = open(weather_url).read
      # doc = Hpricot(xml)
      (xml_doc/"weatherdata/forecast/text/location/time").each do |e|
        f = Forecast.new
        f.title = (e/"title").inner_html
        f.body = (e/"body").inner_html
        f.from = (e["from"])
        f.to = Time.xmlschema((e["to"]))
        f.from = Time.xmlschema((e["from"]))
        f.place = self
        @forecasts << f
      end
      return @forecasts
    end
    
    def xml_doc
      return @xml_doc unless @xml_doc.nil?
      xml = open(weather_url).read
      @xml_doc = Hpricot(xml)      
    end
  end
end