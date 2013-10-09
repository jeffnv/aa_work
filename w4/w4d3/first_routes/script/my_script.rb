
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
# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/1'
# ).to_s
#
# puts RestClient.delete(url)

# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/1/contacts'
# ).to_s
#
# puts RestClient.get(url)

#POST contact

# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/1/contacts'
# ).to_s
#
# puts RestClient.post(url, contact: { user_id: '1',  name: 'contact_name_1', email: 'contact1@enail.com'})

#PUT /users/id

# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/1/contacts/4'
# ).to_s
#
# puts RestClient.put(url, contact: {name: 'change_user', email: 'change@enail.com'})

#show contact
# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/1/contacts/4'
# ).to_s
#
# puts RestClient.get(url)

#destroy contact
# url = Addressable::URI.new(
#   scheme: 'http',
#   host: 'localhost',
#   port: 3000,
#   path: '/users/1/contacts/4'
# ).to_s
#
# puts RestClient.delete(url)

#create contact_share
url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/contact_shares'
).to_s

puts RestClient.post(url, contact_share: {user_id: 2, contact_id: 3})

url = Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  port: 3000,
  path: '/contact_shares/2'
).to_s

puts RestClient.delete(url)