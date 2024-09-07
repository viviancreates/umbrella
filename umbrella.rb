require "http"
require "json"

pp "Hello!"
pp "Where are you located?"

user_location = gets.chomp

pp user_location

pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

# Assemble url string using website and api variable
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887, -87.6355"

# GET request for URL
raw_response = HTTP.get(pirate_weather_url)

parsed_response = JSON.parse(raw_response)
