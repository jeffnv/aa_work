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

ActiveRecord::Schema.define(:version => 20131018001554) do

  create_table "comments", :force => true do |t|
    t.string   "body",              :null => false
    t.integer  "parent_comment_id"
    t.integer  "link_id",           :null => false
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.integer  "author_id",         :null => false
  end

  add_index "comments", ["link_id"], :name => "index_comments_on_link_id"
  add_index "comments", ["parent_comment_id"], :name => "index_comments_on_parent_comment_id"

  create_table "link_subs", :force => true do |t|
    t.integer  "link_id",    :null => false
    t.integer  "sub_id",     :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "links", :force => true do |t|
    t.string   "title",        :null => false
    t.string   "url",          :null => false
    t.string   "body",         :null => false
    t.integer  "submitter_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "links", ["submitter_id"], :name => "index_links_on_submitter_id"

  create_table "subs", :force => true do |t|
    t.string   "name",         :null => false
    t.integer  "moderator_id", :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "subs", ["moderator_id"], :name => "index_subs_on_moderator_id"
  add_index "subs", ["name"], :name => "index_subs_on_name"

  create_table "user_votes", :force => true do |t|
    t.integer "link_id",  :null => false
    t.integer "voter_id", :null => false
    t.integer "vote",     :null => false
  end

  add_index "user_votes", ["link_id"], :name => "index_user_votes_on_link_id"
  add_index "user_votes", ["voter_id"], :name => "index_user_votes_on_voter_id"

  create_table "users", :force => true do |t|
    t.string   "username",        :null => false
    t.string   "session_token",   :null => false
    t.string   "password_digest", :null => false
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  add_index "users", ["session_token"], :name => "index_users_on_session_token"
  add_index "users", ["username"], :name => "index_users_on_username"

end
