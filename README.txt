= Yr: a ruby lib for accessing yr.no's weather service

This is a Ruby API towards the Norwegian weather API site yr.no

== Examples:

=== By named place:

* You can look up the weather given the name of a place.

    require 'lib/yr'
	  oslo = Yr::Place.find("oslo")
	  todays_forecast = oslo.forecasts_for(Time.now)
	  puts "Forecast for #{todays_forecast.title}:"
	  puts todays_forecast.body


=== By position:

* You can also look up the weather given a position (longitude + latitude)

    require 'lib/yr'
    location = Yr::Location.new(10.80, 10.22)
    puts location.current_weather   # Will show the current weather at +location+

== Checkout the source

* Check out the source
The source is found at http://gitorious.org/projects/yr-api

* To install this code:
    
    gem install yr_api