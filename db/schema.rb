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

ActiveRecord::Schema[8.0].define(version: 2024_12_31_201734) do
  create_table "contents", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.integer "discipline_id", null: false
    t.integer "kind", default: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "available_on"
    t.index ["discipline_id"], name: "index_contents_on_discipline_id"
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "title"
    t.string "abstract", limit: 120
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 1
    t.index ["title"], name: "index_disciplines_on_title", unique: true
  end

  create_table "sessions", force: :cascade do |t|
    t.integer "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "registration_code", null: false
    t.integer "role", default: 0, null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["registration_code"], name: "index_users_on_registration_code", unique: true
  end

  add_foreign_key "contents", "disciplines"
  add_foreign_key "sessions", "users"
end
