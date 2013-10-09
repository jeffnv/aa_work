
# GET users users#index
# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users'
# ).to_s
#
# puts RestClient.get(url)

# POST user
# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users'
# ).to_s
#
# puts RestClient.post(url, user: {name: 'api_user', email: 'api@enail.com'})

# PUT /users/id users#update
# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/1'
# ).to_s
#
# puts RestClient.put(url, user: {name: 'change_user', email: 'change@enail.com'})

# #update
# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/789'
# ).to_s
#
# puts RestClient.get(url)

#destroy
url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/users/1'
).to_s

puts RestClient.delete(url)