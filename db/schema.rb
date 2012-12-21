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

ActiveRecord::Schema.define(:version => 20121221175105) do

  create_table "images", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "infos", :force => true do |t|
    t.string   "title"
    t.text     "text"
    t.integer  "topic_id"
    t.integer  "child_of"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "relative_layout", :default => 0
    t.integer  "images_id"
    t.string   "images_type"
  end

  create_table "posts", :force => true do |t|
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
  end

  create_table "topics", :force => true do |t|
    t.string   "name"
    t.string   "systematic_name"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "password"
    t.string   "password_digest"
    t.text     "bio"
    t.datetime "created_at",                           :null => false
    t.datetime "updated_at",                           :null => false
    t.string   "password_confirmation"
    t.string   "remember_token"
    t.string   "email"
    t.integer  "admin_level",           :default => 0
  end

  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
