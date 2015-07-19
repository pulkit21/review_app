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

ActiveRecord::Schema.define(version: 20150719063858) do

  create_table "comments", force: :cascade do |t|
    t.string   "site"
    t.integer  "rating"
    t.text     "review"
    t.string   "semantics"
    t.integer  "merchant_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.string   "user_name"
    t.string   "negative_analysis"
    t.string   "positive_analysis"
    t.string   "neutral_analysis"
    t.string   "analysis_label"
  end

  add_index "comments", ["merchant_id"], name: "index_comments_on_merchant_id"

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.integer  "merchant_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "items", ["merchant_id"], name: "index_items_on_merchant_id"

  create_table "merchants", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "product_ratings", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "comment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "product_ratings", ["comment_id"], name: "index_product_ratings_on_comment_id"
  add_index "product_ratings", ["item_id"], name: "index_product_ratings_on_item_id"

end
