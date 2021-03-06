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

ActiveRecord::Schema.define(version: 20160620082157) do

  create_table "maps", force: :cascade do |t|
    t.string   "image"
    t.string   "status1",    default: "f"
    t.string   "status2",    default: "f"
    t.string   "status3",    default: "f"
    t.string   "status4",    default: "f"
    t.integer  "user_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "recommend_items", force: :cascade do |t|
    t.string   "product_name"
    t.string   "url"
    t.integer  "stamp_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "reward_items", force: :cascade do |t|
    t.string   "product_name"
    t.string   "image"
    t.string   "description"
    t.string   "catelogue"
    t.integer  "map_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "stamp_codes", force: :cascade do |t|
    t.string   "code"
    t.integer  "user_id"
    t.integer  "stamp_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "stamps", force: :cascade do |t|
    t.string   "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "address1"
    t.string   "address2"
    t.string   "address3"
    t.integer  "phone_number"
    t.integer  "map_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
