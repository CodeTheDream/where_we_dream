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

ActiveRecord::Schema.define(version: 20150824005209) do

  create_table "questions", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rules", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "question_id"
    t.boolean  "answer"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "rules", ["question_id"], name: "index_rules_on_question_id"
  add_index "rules", ["school_id"], name: "index_rules_on_school_id"

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.decimal  "rating"
    t.string   "link"
    t.integer  "students"
    t.integer  "undocumented_students"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "public"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

end
