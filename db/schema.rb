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

ActiveRecord::Schema.define(version: 20161011030629) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.string   "state"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "domain_memberships", force: :cascade do |t|
    t.integer  "domain_id"
    t.integer  "city_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_domain_memberships_on_city_id", using: :btree
    t.index ["domain_id"], name: "index_domain_memberships_on_domain_id", using: :btree
  end

  create_table "domains", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "legacy_survey_responses", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "zip_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "token"
  end

  create_table "project_domains", force: :cascade do |t|
    t.string   "project_key"
    t.integer  "domain_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["domain_id"], name: "index_project_domains_on_domain_id", using: :btree
  end

  create_table "tasks", force: :cascade do |t|
    t.string   "project_key"
    t.integer  "city_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "token",       null: false
    t.index ["city_id"], name: "index_tasks_on_city_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "zip_code"
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "legacy_survey_response_id"
    t.string   "email",                     default: "",    null: false
    t.string   "encrypted_password",        default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",             default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.boolean  "admin",                     default: false, null: false
    t.float    "latitude"
    t.float    "longitude"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["legacy_survey_response_id"], name: "index_users_on_legacy_survey_response_id", using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "domain_memberships", "cities"
  add_foreign_key "domain_memberships", "domains"
  add_foreign_key "tasks", "cities"
end
