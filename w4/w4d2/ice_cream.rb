require 'rest-client'
require 'json'
require 'addressable/uri'
require 'nokogiri'

address = "1061 Market St., San Francisco, CA 94103"
key = 'AIzaSyASex8XVQrc__dIeS_J7lmhxeZ33LYt4qI'
LOCATION_COUNT = 1

# Addressable::URI.new(
#    :scheme => "http",
#    :host => "www.bing.com",
#    :path => "search",
#    :query_values => {:q => "test"}
#  ).to_s
#  => "http://www.bing.com/search?q=test"
# https://maps.googleapis.com/maps/api/place/textsearch/json?query=restaurants+in+Sydney&sensor=true&key=AIzaSyASex8XVQrc__dIeS_J7lmhxeZ33LYt4qI

query = Addressable::URI.new(
   :scheme => "https",
   :host => "maps.googleapis.com",
   :path => "/maps/api/geocode/json",
   :query_values => { :address => address,
                      :sensor => false
                    }
 ).to_s

#

p query
puts "\n\n"
place_hash = JSON.parse(RestClient.get(query))
puts "\n\n"

results = place_hash["results"].first
p results
results.each { |el| puts el }
puts "\n\n"
p results["geometry"]
puts "\n\n"

my_loc = results['geometry']['location']
my_loc = "#{my_loc['lat']},#{my_loc['lng']}"
p my_loc
# https://maps.googleapis.com/maps/api/place/nearbysearch/output?parameters

query = Addressable::URI.new(
   :scheme => "https",
   :host => "maps.googleapis.com",
   :path => "/maps/api/place/nearbysearch/json",
   :query_values => { :sensor => false,
                      key: key,
                      location: my_loc,
                      radius: 1000,
                      keyword: 'ice cream',
                      type: 'food'

                    }
 ).to_s


 p query
 puts "\n\nICE CREAM PLACES:\n"
ice_cream_places  = JSON.parse(RestClient.get(query))['results'][0...LOCATION_COUNT]
p ice_cream_places
ice_cream_loc = ice_cream_places.first["geometry"]["location"]
ice_cream_loc = "#{ice_cream_loc['lat']},#{ice_cream_loc['lng']}"

p ice_cream_loc


query = Addressable::URI.new(
   :scheme => "https",
   :host => "maps.googleapis.com",
   :path => "/maps/api/directions/json",
   :query_values => { :origin => my_loc,
                      :destination => ice_cream_loc,
                      :sensor => false,
                      :mode => "walking"
                    }
 ).to_s

 directions = JSON.parse(RestClient.get(query))
 puts "\n\nDIRECTIONS:\n"
 instructions = directions['routes'].first['legs'].first['steps']
 instructions.each do |instruction|
   puts Nokogiri::HTML(instruction['html_instructions']).text
 end


