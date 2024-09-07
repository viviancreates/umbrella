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

pp maps_url

pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

# Assemble url string using website and api variable
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887, -87.6355"

# GET request for URL
raw_response = HTTP.get(pirate_weather_url)

parsed_response = JSON.parse(raw_response)
