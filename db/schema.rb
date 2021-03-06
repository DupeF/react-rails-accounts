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

ActiveRecord::Schema.define(version: 20151031193627) do

  create_table "group_memberships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "group_id"
    t.string   "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "group_memberships", ["group_id"], name: "index_group_memberships_on_group_id"
  add_index "group_memberships", ["user_id"], name: "index_group_memberships_on_user_id"

  create_table "groups", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "personal_balances", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.string   "name",       default: "", null: false
  end

  add_index "personal_balances", ["user_id"], name: "index_personal_balances_on_user_id"

  create_table "personal_records", force: :cascade do |t|
    t.integer  "personal_balance_id"
    t.string   "title"
    t.date     "date"
    t.float    "amount"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "personal_records", ["personal_balance_id"], name: "index_personal_records_on_personal_balance_id"

  create_table "record_involvements", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "record_id"
    t.float    "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "record_involvements", ["record_id"], name: "index_record_involvements_on_record_id"
  add_index "record_involvements", ["user_id"], name: "index_record_involvements_on_user_id"

  create_table "records", force: :cascade do |t|
    t.string   "title"
    t.date     "date"
    t.float    "amount"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "group_id"
    t.integer  "payer_id"
  end

  add_index "records", ["group_id"], name: "index_records_on_group_id"
  add_index "records", ["payer_id"], name: "index_records_on_payer_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",   null: false
    t.string   "encrypted_password",     default: "",   null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,    null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "locale",                 default: "fr", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
