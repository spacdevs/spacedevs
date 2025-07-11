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

ActiveRecord::Schema[8.0].define(version: 2025_05_23_015039) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "contents", force: :cascade do |t|
    t.string "title"
    t.text "body"
    t.bigint "discipline_id", null: false
    t.integer "kind", default: 1
    t.string "slug"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "position", default: 1
    t.string "video_id"
    t.index ["discipline_id"], name: "index_contents_on_discipline_id"
    t.index ["slug"], name: "index_contents_on_slug", unique: true
  end

  create_table "discipline_subscribers", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "discipline_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discipline_id"], name: "index_discipline_subscribers_on_discipline_id"
    t.index ["user_id"], name: "index_discipline_subscribers_on_user_id"
  end

  create_table "disciplines", force: :cascade do |t|
    t.string "title"
    t.string "abstract", limit: 120
    t.integer "position", default: 1
    t.string "slug"
    t.text "body"
    t.datetime "available_on"
    t.datetime "datetime"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["slug"], name: "index_disciplines_on_slug", unique: true
    t.index ["title"], name: "index_disciplines_on_title", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "document", null: false
    t.string "avatar"
    t.datetime "birthday", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug", null: false
    t.string "fullname"
    t.string "whatsapp"
    t.index ["slug"], name: "index_profiles_on_slug", unique: true
    t.index ["user_id"], name: "index_profiles_on_user_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name", null: false
    t.string "url"
    t.string "sourceable_type", null: false
    t.bigint "sourceable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["sourceable_type", "sourceable_id"], name: "index_resources_on_sourceable"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name", null: false
    t.boolean "enable", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "ip_address"
    t.string "user_agent"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sessions_on_user_id"
  end

  create_table "team_disciplines", force: :cascade do |t|
    t.bigint "discipline_id", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discipline_id"], name: "index_team_disciplines_on_discipline_id"
    t.index ["team_id"], name: "index_team_disciplines_on_team_id"
  end

  create_table "team_users", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "team_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_id"], name: "index_team_users_on_team_id"
    t.index ["user_id"], name: "index_team_users_on_user_id"
  end

  create_table "teams", force: :cascade do |t|
    t.string "name"
    t.boolean "active", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_school_enrollments", force: :cascade do |t|
    t.integer "period", default: 1
    t.integer "degree", default: 1
    t.bigint "school_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_user_school_enrollments_on_school_id"
    t.index ["user_id"], name: "index_user_school_enrollments_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email_address", null: false
    t.string "registration_code", null: false
    t.integer "role", default: 0, null: false
    t.string "password_digest", null: false
    t.datetime "disabled_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "school_id", null: false
    t.index ["email_address"], name: "index_users_on_email_address", unique: true
    t.index ["registration_code"], name: "index_users_on_registration_code", unique: true
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "contents", "disciplines"
  add_foreign_key "discipline_subscribers", "disciplines"
  add_foreign_key "discipline_subscribers", "users"
  add_foreign_key "profiles", "users"
  add_foreign_key "sessions", "users"
  add_foreign_key "team_disciplines", "disciplines"
  add_foreign_key "team_disciplines", "teams"
  add_foreign_key "team_users", "teams"
  add_foreign_key "team_users", "users"
  add_foreign_key "user_school_enrollments", "schools"
  add_foreign_key "user_school_enrollments", "users"
  add_foreign_key "users", "schools"
end
