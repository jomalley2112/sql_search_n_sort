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

  create_table "articles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "headline"
    t.string "by_line"
    t.datetime "date_pub"
    t.text "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.text "ctext"
    t.string "commentator"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "article_id"
  end

  create_table "items", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name"
    t.text "descr"
  end

  create_table "members", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "first_name"
    t.string "last_name"
    t.integer "age"
    t.string "email"
    t.text "bio"
    t.string "nickname"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "dob"
    t.integer "grade"
  end

  create_table "products", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.string "name"
    t.text "descr"
    t.integer "price"
    t.datetime "date_produced"
    t.string "manufacturer"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unsearchables", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "int"
    t.date "dt"
    t.time "tm"
    t.datetime "dtm"
    t.boolean "bool"
    t.float "flt", limit: 24
    t.decimal "dec", precision: 10
    t.binary "bn"
    t.datetime "ts"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "vehicles", id: :integer, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci" do |t|
    t.integer "year"
    t.string "manufacturer"
    t.string "model"
    t.string "color"
    t.string "engine"
    t.integer "doorrs"
    t.integer "cylinders"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
