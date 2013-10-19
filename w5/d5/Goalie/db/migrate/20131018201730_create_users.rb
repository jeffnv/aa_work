class CreateUsers < ActiveRecord::Migration
  def change
    create_table "users", :force => true do |t|
      t.string   "username",        :null => false
      t.string   "password_digest", :null => false
      t.string   "session_token",   :null => false
      t.datetime "created_at",      :null => false
      t.datetime "updated_at",      :null => false
    end

    add_index "users", ["session_token"], :name => "index_users_on_session_token", :unique => true
    add_index "users", ["username"], :name => "index_users_on_username", :unique => true
   
  end
end
