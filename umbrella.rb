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

pp "Latitude: #{latitude}, Longitude: #{longitude}"

#pp maps_url

#pirate weather api
pirate_weather_api_key = ENV.fetch("PIRATE_WEATHER_KEY")

# Assemble url string using website and api variable
# example of chicago pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/41.8887, -87.6355" 
# let's make the lat and lon not hardcoded
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_api_key + "/#{latitude},#{longitude}"

# GET request for URL
raw_response_weather = HTTP.get(pirate_weather_url)
parsed_pirate_weather = JSON.parse(raw_response_weather)

# Show current weather
current_weather = parsed_pirate_weather.fetch("currently")
current_temp = current_weather.fetch("temperature")
weather_summary = current_weather.fetch("summary")

pp "The current temp is #{current_temp} degrees."
pp "Weather summary: #{weather_summary}"

#Stretch goal
umbrella_needed = false

# Loop through the next 12 hours and check each hour's precipitation probability
parsed_pirate_weather["hourly"]["data"].first(12).each_with_index do |hour, index|
  # Get the precipitation probability (convert it to percentage by multiplying by 100)
  precip_prob = hour["precipProbability"] * 100

  if precip_prob > 10
    puts "In #{index} hour(s), there is a #{precip_prob}% chance of rain."
    umbrella_needed = true 
  end
end


if umbrella_needed
  puts "You might want to carry an umbrella!"
else
  puts "You probably will not need an umbrella today."
end
