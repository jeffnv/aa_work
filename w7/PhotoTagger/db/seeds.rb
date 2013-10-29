# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#assuming at least 2 users exist
# attr_accessible  :title, :url #to prevent assigning lots of photos bad
# validates :owner_id, :title, :url, presence: true
# validates :url, uniqueness: true
p1 = Photo.new(
  :title => "Cat1",
  :url => "http://placekitten.com/500/300"
  )

p1.owner_id = User.first.id;
p1.save


p2 = Photo.new(
  :title => "Cat2",
  :url => "http://placekitten.com/300/300"
  )

p2.owner_id = User.last.id;
p2.save