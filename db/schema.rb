# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_07_05_195237) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.string "kind", null: false
    t.boolean "weekly_recurring"
    t.bigint "tenant_id"
    t.bigint "home_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["home_id"], name: "index_appointments_on_home_id"
    t.index ["tenant_id"], name: "index_appointments_on_tenant_id"
  end

  create_table "homes", force: :cascade do |t|
    t.string "name"
    t.bigint "proprietor_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "appointment_id", null: false
    t.index ["appointment_id"], name: "index_homes_on_appointment_id"
    t.index ["proprietor_id"], name: "index_homes_on_proprietor_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string "email"
    t.integer "appointment_id"
    t.integer "sender_id"
    t.integer "recipient_id"
    t.string "token"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "proprietors", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_proprietors_on_user_id"
  end

  create_table "relations", force: :cascade do |t|
    t.bigint "tenant_id", null: false
    t.bigint "homes_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["homes_id"], name: "index_relations_on_homes_id"
    t.index ["tenant_id"], name: "index_relations_on_tenant_id"
  end

  create_table "tenants", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_tenants_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "homes", "appointments"
  add_foreign_key "homes", "proprietors"
  add_foreign_key "proprietors", "users"
  add_foreign_key "relations", "homes", column: "homes_id"
  add_foreign_key "relations", "tenants"
  add_foreign_key "tenants", "users"
end
