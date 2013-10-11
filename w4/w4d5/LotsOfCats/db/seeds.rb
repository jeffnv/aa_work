# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create!(:user_name => 'jim', :password => "asdf")
Cat.create([{name: 'Earl', age: 10, sex: 'M', birth_date: '10/5/2010', color: 'brown', user_id: 1},
            {name: 'Dave', age: 8, sex: 'F', birth_date: '5/1/2011', color: 'orange', user_id: 1}])