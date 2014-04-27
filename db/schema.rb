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

ActiveRecord::Schema.define(version: 20140427121128) do

  create_table "atendances", force: true do |t|
    t.integer  "user_id"
    t.integer  "university_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "from"
    t.date     "to"
    t.boolean  "currently_attending", default: false, null: false
  end

  create_table "audios", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "documents", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media", force: true do |t|
    t.integer  "user_id"
    t.string   "content_type"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "medium"
    t.string   "file_name"
    t.integer  "file_size"
    t.boolean  "medium_processing"
  end

  add_index "media", ["content_type"], name: "index_media_on_content_type"
  add_index "media", ["user_id"], name: "index_media_on_user_id"

  create_table "timeline_posts", force: true do |t|
    t.integer  "timeline_id"
    t.integer  "user_id"
    t.integer  "parent_id"
    t.integer  "state",       default: 1
    t.string   "body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timeline_posts", ["parent_id"], name: "index_timeline_posts_on_parent_id"
  add_index "timeline_posts", ["state"], name: "index_timeline_posts_on_state"
  add_index "timeline_posts", ["timeline_id"], name: "index_timeline_posts_on_timeline_id"

  create_table "timeline_user_permissions", force: true do |t|
    t.integer  "timeline_id"
    t.integer  "user_id"
    t.integer  "role"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "timeline_user_permissions", ["role"], name: "index_timeline_user_permissions_on_role"
  add_index "timeline_user_permissions", ["timeline_id"], name: "index_timeline_user_permissions_on_timeline_id"
  add_index "timeline_user_permissions", ["user_id"], name: "index_timeline_user_permissions_on_user_id"

  create_table "timelines", force: true do |t|
    t.string   "title",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "universities", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",            default: "", null: false
    t.string   "crypted_password", default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",                    null: false
    t.string   "last_name",                     null: false
    t.string   "salt"
    t.integer  "user_id"
    t.string   "profile_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["profile_name"], name: "index_users_on_profile_name", unique: true

  create_table "videos", force: true do |t|
    t.string   "title"
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
