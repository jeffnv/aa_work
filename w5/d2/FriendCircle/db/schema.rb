# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131015232329) do

  create_table "circles", :force => true do |t|
    t.string   "name",       :null => false
    t.integer  "owner_id",   :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "circles", ["name"], :name => "index_circles_on_name"
  add_index "circles", ["owner_id"], :name => "index_circles_on_owner_id"

  create_table "friendships", :force => true do |t|
    t.integer  "friender_id", :null => false
    t.integer  "friendee_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "friendships", ["friendee_id"], :name => "index_friendships_on_friendee_id"
  add_index "friendships", ["friender_id"], :name => "index_friendships_on_friender_id"

  create_table "memberships", :force => true do |t|
    t.integer  "user_id",    :null => false
    t.integer  "circle_id",  :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "memberships", ["circle_id"], :name => "index_memberships_on_circle_id"
  add_index "memberships", ["user_id"], :name => "index_memberships_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "session_token",   :null => false
    t.string   "password_digest", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "reset_token"
  end

  add_index "users", ["email"], :name => "index_users_on_email"

end
