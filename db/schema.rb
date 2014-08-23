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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140823080949) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accepted_payment_methods", force: true do |t|
    t.integer "restaurant_id"
    t.integer "payment_method_id"
  end

  create_table "accounts", force: true do |t|
    t.string   "uid",        null: false
    t.string   "provider",   null: false
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "accounts", ["provider", "uid"], name: "index_accounts_on_provider_and_uid", unique: true, using: :btree
  add_index "accounts", ["user_id"], name: "index_accounts_on_user_id", using: :btree

  create_table "locations", force: true do |t|
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "street"
    t.string   "city"
  end

  create_table "lunches", force: true do |t|
    t.date     "date",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "lunches", ["date"], name: "index_lunches_on_date", unique: true, using: :btree

  create_table "offices", force: true do |t|
    t.string   "name",        null: false
    t.integer  "location_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "offices", ["location_id"], name: "index_offices_on_location_id", using: :btree
  add_index "offices", ["name"], name: "index_offices_on_name", unique: true, using: :btree

  create_table "payment_methods", force: true do |t|
    t.string   "name",       null: false
    t.string   "logo_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "payment_methods", ["name"], name: "index_payment_methods_on_name", unique: true, using: :btree

  create_table "restaurants", force: true do |t|
    t.string   "name",           null: false
    t.integer  "location_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "logo"
    t.string   "localized_name"
  end

  add_index "restaurants", ["location_id"], name: "index_restaurants_on_location_id", using: :btree
  add_index "restaurants", ["name"], name: "index_restaurants_on_name", unique: true, using: :btree

  create_table "tag_definitions", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tag_definitions", ["name"], name: "index_tag_definitions_on_name", unique: true, using: :btree

  create_table "tags", force: true do |t|
    t.integer  "quantity",          default: 1
    t.integer  "tag_definition_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "tags", ["restaurant_id"], name: "index_tags_on_restaurant_id", using: :btree
  add_index "tags", ["tag_definition_id", "restaurant_id"], name: "index_tags_on_tag_definition_id_and_restaurant_id", unique: true, using: :btree
  add_index "tags", ["tag_definition_id"], name: "index_tags_on_tag_definition_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "avatar_url"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.integer  "office_id"
    t.boolean  "banned",              default: false
    t.datetime "forced_signed_in_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "users_tags", id: false, force: true do |t|
    t.integer "user_id", null: false
    t.integer "tag_id",  null: false
  end

  create_table "visits", force: true do |t|
    t.integer  "lunch_id"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "visits", ["lunch_id"], name: "index_visits_on_lunch_id", using: :btree
  add_index "visits", ["restaurant_id"], name: "index_visits_on_restaurant_id", using: :btree
  add_index "visits", ["user_id"], name: "index_visits_on_user_id", using: :btree

  create_table "votes", force: true do |t|
    t.integer  "lunch_id"
    t.integer  "user_id"
    t.integer  "restaurant_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "votes", ["lunch_id", "restaurant_id", "user_id"], name: "index_votes_on_lunch_id_and_restaurant_id_and_user_id", unique: true, using: :btree
  add_index "votes", ["lunch_id"], name: "index_votes_on_lunch_id", using: :btree
  add_index "votes", ["restaurant_id"], name: "index_votes_on_restaurant_id", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

end
