Yr: a ruby lib for accessing yr.no's weather service

Very basic example:

require 'lib/yr'
oslo = Yr::Place.find("oslo")
todays_forecast = oslo.forecasts_for(Time.now)
puts "Forecast for #{todays_forecast.title}:"
puts todays_forecast.body
