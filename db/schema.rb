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

ActiveRecord::Schema[7.0].define(version: 2023_08_26_101343) do
  create_table "activities", force: :cascade do |t|
    t.text "name"
    t.text "color"
    t.integer "position"
  end

  create_table "event_activities", force: :cascade do |t|
    t.integer "event_id"
    t.integer "activity_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events", force: :cascade do |t|
    t.date "day"
    t.text "description"
    t.integer "rating"
    t.index ["day"], name: "index_events_on_day"
  end

  create_table "photos", force: :cascade do |t|
    t.string "image_uid"
    t.integer "event_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["event_id"], name: "index_photos_on_event_id"
  end

  create_table "users", force: :cascade do |t|
    t.text "email"
    t.boolean "can_download"
    t.boolean "can_edit_activity"
    t.boolean "can_edit_event"
    t.boolean "can_see_legend"
    t.boolean "can_see_description"
    t.string "password_digest", limit: 128
    t.boolean "is_admin"
    t.index ["email"], name: "index_users_on_email"
  end

end
