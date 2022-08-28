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

ActiveRecord::Schema.define(version: 2017_08_16_104944) do

  create_table "activities", force: :cascade do |t|
    t.text "name"
    t.text "color"
    t.integer "position"
  end

  create_table "events", force: :cascade do |t|
    t.date "day"
    t.integer "activity_id"
    t.text "description"
    t.integer "rating"
    t.index ["day"], name: "index_events_on_day"
  end

  create_table "photos", force: :cascade do |t|
    t.string "image_uid"
    t.integer "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_photos_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "email"
    t.boolean "can_download"
    t.boolean "can_edit_activity"
    t.boolean "can_edit_event"
    t.boolean "can_see_legend"
    t.boolean "can_see_description"
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
    t.boolean "is_admin"
    t.index ["email"], name: "index_users_on_email"
    t.index ["remember_token"], name: "index_users_on_remember_token"
  end

end
