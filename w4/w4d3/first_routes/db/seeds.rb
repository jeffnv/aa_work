User.create!({name: "user1", email: "user1@gmail.com"})
User.create!({name: "user2", email: "user2@gmail.com"})
User.create!({name: "user3", email: "user3@gmail.com"})

User.find_by_id(1).contacts << Contact.new(name: 'contact1', email: 'c1@e.com')
User.find_by_id(2).contacts << Contact.new(name: 'contact2', email: 'c2@e.com')
User.find_by_id(3).contacts << Contact.new(name: 'contact3', email: 'c3@e.com')

ContactShare.create!(user_id: 1, contact_id: 2)