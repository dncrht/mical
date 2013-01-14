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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130114184415) do

  create_table "activities", :force => true do |t|
    t.text    "name"
    t.text    "color"
    t.integer "position"
  end

  create_table "events", :force => true do |t|
    t.date    "day",         :null => false
    t.integer "activity_id"
    t.text    "description"
  end

  add_index "events", ["day"], :name => "day_idx"

  create_table "users", :force => true do |t|
    t.text    "email"
    t.boolean "can_download"
    t.boolean "can_edit_activity"
    t.boolean "can_edit_event"
    t.boolean "can_see_legend"
    t.boolean "can_see_description"
    t.boolean "is_admin"
    t.string  "encrypted_password",  :limit => 128
    t.string  "confirmation_token",  :limit => 128
    t.string  "remember_token",      :limit => 128
  end

end
