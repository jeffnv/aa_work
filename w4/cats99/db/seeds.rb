# t.integer  "age",        :null => false
# t.datetime "birth_date", :null => false
# t.string   "color",      :null => false
# t.string   "name",       :null => false
# t.string   "sex",        :null => false
# t.datetime "created_at", :null => false
# t.datetime "updated_at", :null => false

ActiveRecord::Base.logger = Logger.new(STDOUT)

Cat.create!(name: 'hank', age: 10, sex: 'M',
           color: 'black', birth_date: DateTime.new(2003))

Cat.create!(name: 'Jim', age: 10, sex: 'M',
           color: 'black', birth_date: DateTime.new(2003))

Cat.create!(name: 'Bill', age: 10, sex: 'M',
           color: 'black', birth_date: DateTime.new(2003))

CatRentalRequest.create!(cat_id: 1,
                         start_date: DateTime.new(2001),
                         end_date: DateTime.new(2006),
                         status: "APPROVED")
#
# CatRentalRequest.create!(cat_id: 1,
#                          start_date: DateTime.new(2003),
#                          end_date: DateTime.new(2009))

