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

ActiveRecord::Schema.define(:version => 20130601144514) do

  create_table "accounts", :force => true do |t|
    t.string   "uid"
    t.string   "provider"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "accounts", ["user_id"], :name => "index_accounts_on_user_id"

  create_table "areas", :force => true do |t|
    t.string   "name"
    t.float    "latitude"
    t.float    "longitude"
    t.float    "radius"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "groups", :force => true do |t|
    t.string   "name"
    t.integer  "area_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "groups", ["area_id"], :name => "index_groups_on_area_id"

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
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "lunches", ["group_id"], :name => "index_lunches_on_group_id"

  create_table "restaurants", :force => true do |t|
    t.string   "name"
    t.integer  "category_id"
    t.integer  "location_id"
    t.integer  "area_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "logo_url"
  end

  add_index "restaurants", ["area_id"], :name => "index_restaurants_on_area_id"
  add_index "restaurants", ["category_id"], :name => "index_restaurants_on_category_id"
  add_index "restaurants", ["location_id"], :name => "index_restaurants_on_location_id"

  create_table "tag_definitions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.integer  "quantity"
    t.integer  "tag_definition_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  add_index "tags", ["restaurant_id"], :name => "index_tags_on_restaurant_id"
  add_index "tags", ["tag_definition_id"], :name => "index_tags_on_tag_definition_id"

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "avatar_url"
    t.integer  "group_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "users", ["group_id"], :name => "index_users_on_group_id"

  create_table "votes", :force => true do |t|
    t.integer  "lunch_id"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "votes", ["lunch_id"], :name => "index_votes_on_lunch_id"
  add_index "votes", ["restaurant_id"], :name => "index_votes_on_restaurant_id"
  add_index "votes", ["user_id"], :name => "index_votes_on_user_id"

end
