require "http"
require "json"

pp "Hello!"
pp "Where are you located?"

user_location = gets.chomp

pp user_location

# Original pasted looks like https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key=jdijxidjYADAYADAthisWASanAPICODE
# This is turned to below
# maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=Merchandise%20Mart%20Chicago&key="+ ENV.fetch("GMAPS_KEY")

# HOWEVER, we want to NOT hardcode location too, so...
# add the user input variable 
maps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=" + user_location + "&key=" + ENV.fetch("GMAPS_KEY")

resp = HTTP.get(maps_url)

# pp resp 
# use to string method
raw_response = resp.to_s
parsed_response = JSON.parse(raw_response)
results = parsed_response.fetch("results")
# pp results

first_result = results.at(0)

# check pp first_result.class, its a hash
# then pp first_result.keys to see the keys
# this tells you what you are looking for in json data and what to fetch
# then add geo variable
geo = first_result.fetch("geometry")

# check pp geo to find next step
# then add loc variable
loc = geo.fetch("location")

pp latitude = loc.fetch("lat")
pp longitude = loc.fetch("lng")

# check pp loc to find next step
pp loc

#pp maps_url

#pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

# Assemble url string using website and api variable
# pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887, -87.6355"

# GET request for URL
# raw_response = HTTP.get(pirate_weather_url)
