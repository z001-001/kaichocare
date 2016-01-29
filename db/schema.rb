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

ActiveRecord::Schema.define(version: 20160128001026) do

  create_table "bowels", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "shape",        default: 0, null: false
    t.string   "color"
    t.integer  "amount"
    t.string   "comment"
    t.string   "feeling"
    t.datetime "occurred_at",              null: false
    t.integer  "public_level", default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "bowels", ["user_id", "occurred_at"], name: "index_bowels_on_user_id_and_occurred_at"
  add_index "bowels", ["user_id"], name: "index_bowels_on_user_id"

  create_table "health_events", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "comment"
    t.string   "feeling"
    t.datetime "occurred_at",              null: false
    t.datetime "ended_at"
    t.integer  "public_level", default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "health_events", ["user_id", "occurred_at"], name: "index_health_events_on_user_id_and_occurred_at"
  add_index "health_events", ["user_id"], name: "index_health_events_on_user_id"

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "friend"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "share_posts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "comment"
    t.integer  "public_level", default: 0, null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "share_posts", ["user_id", "created_at"], name: "index_share_posts_on_user_id_and_created_at"
  add_index "share_posts", ["user_id"], name: "index_share_posts_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                     default: "", null: false
    t.string   "encrypted_password",        default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",           default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "username"
    t.string   "description"
    t.string   "location"
    t.string   "url"
    t.string   "avatar"
    t.integer  "bowel_public_level",        default: 1,  null: false
    t.integer  "health_event_public_level", default: 1,  null: false
    t.integer  "share_post_public_level",   default: 1,  null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true

end
