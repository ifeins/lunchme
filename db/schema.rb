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

ActiveRecord::Schema.define(:version => 20140312173349) do

  create_table "accepted_payment_methods", :force => true do |t|
    t.integer "restaurant_id"
    t.integer "payment_method_id"
  end

  create_table "accounts", :force => true do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "locations", :force => true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "street"
    t.string   "city"
  end

  create_table "lunches", :force => true do |t|
    t.date     "date"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "offices", :force => true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "offices", ["location_id"], :name => "index_offices_on_location_id"

  create_table "payment_methods", :force => true do |t|
    t.string   "name"
    t.string   "logo_url"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.integer  "location_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.string   "logo"
    t.string   "localized_name"
  end

  add_index "restaurants", ["location_id"], :name => "index_restaurants_on_location_id"

  create_table "surveys", :force => true do |t|
    t.string   "status"
    t.integer  "user_id"
    t.integer  "lunch_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "surveys", ["lunch_id"], :name => "index_surveys_on_lunch_id"
  add_index "surveys", ["user_id"], :name => "index_surveys_on_user_id"

  create_table "tag_definitions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.integer  "quantity",          :default => 1
    t.integer  "tag_definition_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  add_index "tags", ["restaurant_id"], :name => "index_tags_on_restaurant_id"
  add_index "tags", ["tag_definition_id"], :name => "index_tags_on_tag_definition_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "avatar_url"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "office_id"
    t.boolean  "banned",     :default => false
  end

  create_table "users_tags", :id => false, :force => true do |t|
    t.integer "user_id", :null => false
    t.integer "tag_id",  :null => false
  end

  create_table "visits", :force => true do |t|
    t.integer  "lunch_id"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "visits", ["lunch_id"], :name => "index_visits_on_lunch_id"
  add_index "visits", ["restaurant_id"], :name => "index_visits_on_restaurant_id"
  add_index "visits", ["user_id"], :name => "index_visits_on_user_id"

  create_table "votes", :force => true do |t|
    t.integer  "lunch_id"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "votes", ["lunch_id", "restaurant_id", "user_id"], :name => "index_votes_on_lunch_id_and_restaurant_id_and_user_id", :unique => true
  add_index "votes", ["lunch_id"], :name => "index_votes_on_lunch_id"
  add_index "votes", ["restaurant_id"], :name => "index_votes_on_restaurant_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
