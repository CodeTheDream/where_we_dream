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

ActiveRecord::Schema.define(version: 20151001023826) do

  create_table "comments", force: :cascade do |t|
    t.text     "content"
    t.integer  "original_comment_id"
    t.integer  "user_id"
    t.integer  "commentable_id"
    t.string   "commentable_type"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "comments", ["commentable_type", "commentable_id"], name: "index_comments_on_commentable_type_and_commentable_id"
  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "opinions", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "opinionable_id"
    t.string   "opinionable_type"
    t.boolean  "value"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "opinions", ["opinionable_type", "opinionable_id"], name: "index_opinions_on_opinionable_type_and_opinionable_id"
  add_index "opinions", ["user_id"], name: "index_opinions_on_user_id"

  create_table "questions", force: :cascade do |t|
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "rules", force: :cascade do |t|
    t.integer  "school_id"
    t.integer  "question_id"
    t.boolean  "answer"
    t.text     "details"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "rules", ["question_id"], name: "index_rules_on_question_id"
  add_index "rules", ["school_id"], name: "index_rules_on_school_id"

  create_table "schools", force: :cascade do |t|
    t.string   "name"
    t.decimal  "rating"
    t.string   "link"
    t.text     "description"
    t.integer  "students"
    t.integer  "undocumented_students"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.boolean  "public"
    t.boolean  "complete"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.text     "bio"
    t.text     "team_contribution"
    t.string   "facebook_url"
    t.string   "twitter_name"
    t.string   "linkedin_url"
    t.string   "email"
    t.string   "password_digest"
    t.string   "user_type"
    t.boolean  "activated"
    t.boolean  "banned"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

end
