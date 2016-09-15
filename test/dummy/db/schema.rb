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

ActiveRecord::Schema.define(version: 20160128023040) do

  create_table "articles", force: :cascade do |t|
    t.string   "headline",   limit: 255
    t.string   "by_line",    limit: 255
    t.datetime "date_pub"
    t.text     "body",       limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", force: :cascade do |t|
    t.text     "ctext",       limit: 65535
    t.string   "commentator", limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "article_id",  limit: 4
  end

  create_table "items", force: :cascade do |t|
    t.string "name",  limit: 255
    t.text   "descr", limit: 65535
  end

  create_table "members", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.string   "email",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: :cascade do |t|
    t.string   "first_name", limit: 255
    t.string   "last_name",  limit: 255
    t.integer  "age",        limit: 4
    t.string   "email",      limit: 255
    t.text     "bio",        limit: 65535
    t.string   "nickname",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "dob"
    t.integer  "grade",      limit: 4
  end

  create_table "products", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "descr",         limit: 65535
    t.integer  "price",         limit: 4
    t.datetime "date_produced"
    t.string   "manufacturer",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unsearchables", force: :cascade do |t|
    t.integer  "int",        limit: 4
    t.date     "dt"
    t.time     "tm"
    t.datetime "dtm"
    t.boolean  "bool"
    t.float    "flt",        limit: 24
    t.decimal  "dec",                      precision: 10
    t.binary   "bn",         limit: 65535
    t.datetime "ts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicles", force: :cascade do |t|
    t.integer  "year",         limit: 4
    t.string   "manufacturer", limit: 255
    t.string   "model",        limit: 255
    t.string   "color",        limit: 255
    t.string   "engine",       limit: 255
    t.integer  "doorrs",       limit: 4
    t.integer  "cylinders",    limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
