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

ActiveRecord::Schema.define(version: 20170816104944) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", id: :serial, force: :cascade do |t|
    t.text "name"
    t.text "color"
    t.integer "position"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.date "day", null: false
    t.integer "activity_id"
    t.text "description"
    t.integer "rating"
    t.index ["day"], name: "day_idx"
  end

  create_table "photos", id: :serial, force: :cascade do |t|
    t.string "image_uid"
    t.integer "event_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.text "email"
    t.boolean "can_download"
    t.boolean "can_edit_activity"
    t.boolean "can_edit_event"
    t.boolean "can_see_legend"
    t.boolean "can_see_description"
    t.boolean "is_admin"
    t.string "encrypted_password", limit: 128
    t.string "confirmation_token", limit: 128
    t.string "remember_token", limit: 128
  end

end
