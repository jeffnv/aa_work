require 'rest-client'
require 'json'
require 'addressable/uri'
require 'nokogiri'

ADDRESS = "1061 Market St., San Francisco, CA 94103"
KEY = 'AIzaSyASex8XVQrc__dIeS_J7lmhxeZ33LYt4qI'
LOCATION_COUNT = 3

def get_my_coords
  query = Addressable::URI.new(
     :scheme => "https",
     :host => "maps.googleapis.com",
     :path => "/maps/api/geocode/json",
     :query_values => { :address => ADDRESS,
                        :sensor => false
                      }
   ).to_s

  place_hash = JSON.parse(RestClient.get(query))

  results = place_hash["results"].first

  my_loc = results['geometry']['location']
  my_loc = "#{my_loc['lat']},#{my_loc['lng']}"

end



def get_ice_cream_destinations(my_loc)
  #======GET PLACES
  query = Addressable::URI.new(
     :scheme => "https",
     :host => "maps.googleapis.com",
     :path => "/maps/api/place/nearbysearch/json",
     :query_values => { :sensor => false,
                        key: KEY,
                        location: my_loc,
                        radius: 1000,
                        keyword: 'ice cream',
                        type: 'food'

                      }
   ).to_s

  ice_cream_places  = JSON.parse(RestClient.get(query))['results'][0...LOCATION_COUNT]

  destinations =[]
  ice_cream_places.each do |place|
    name = place['name']
    ice_cream_loc = place["geometry"]["location"]
    ice_cream_loc = "#{ice_cream_loc['lat']},#{ice_cream_loc['lng']}"
    destinations << [name, ice_cream_loc]
  end
  destinations
end

my_loc = get_my_coords
destinations = get_ice_cream_destinations(my_loc)

#=========GET DIRECTIONS
destinations.each do |destination|

  query = Addressable::URI.new(
  :scheme => "https",
  :host => "maps.googleapis.com",
  :path => "/maps/api/directions/json",
  :query_values => { :origin => my_loc,
    :destination => destination[1],
    :sensor => false,
    :mode => "walking"
  }
  ).to_s

  directions = JSON.parse(RestClient.get(query))
  puts "\n\nDIRECTIONS to #{destination[0]}:\n"
  instructions = directions['routes'].first['legs'].first['steps']
  instructions.each do |instruction|
    puts Nokogiri::HTML(instruction['html_instructions']).text
  end

end

