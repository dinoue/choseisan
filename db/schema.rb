# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_07_203903) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "event_entries", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "user_id", null: false
    t.string "comment"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_id", "user_id"], name: "index_event_entries_on_event_id_and_user_id", unique: true
    t.index ["event_id"], name: "index_event_entries_on_event_id"
    t.index ["user_id", "event_id"], name: "index_event_entries_on_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_event_entries_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "title"
    t.string "memo"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "hash_id", null: false
    t.index ["hash_id"], name: "index_events_on_hash_id", unique: true
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "option_entries", force: :cascade do |t|
    t.integer "feeling", default: 0, null: false
    t.bigint "option_id", null: false
    t.bigint "event_entry_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_entry_id", "option_id"], name: "index_option_entries_on_event_entry_id_and_option_id", unique: true
    t.index ["event_entry_id"], name: "index_option_entries_on_event_entry_id"
    t.index ["option_id", "event_entry_id"], name: "index_option_entries_on_option_id_and_event_entry_id", unique: true
    t.index ["option_id"], name: "index_option_entries_on_option_id"
  end

  create_table "options", force: :cascade do |t|
    t.string "text", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "status", default: 0, null: false
    t.index ["event_id"], name: "index_options_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "login_id", default: "", null: false
    t.string "name", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["login_id"], name: "index_users_on_login_id", unique: true
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "event_entries", "events"
  add_foreign_key "event_entries", "users"
  add_foreign_key "option_entries", "event_entries"
  add_foreign_key "option_entries", "options"
  add_foreign_key "options", "events"
end
