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

ActiveRecord::Schema.define(version: 2021_07_28_111418) do

  create_table "lives", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "streamer_id", null: false
    t.index ["streamer_id"], name: "index_lives_on_streamer_id"
  end

  create_table "messages", force: :cascade do |t|
    t.datetime "send_date"
    t.text "body"
    t.integer "user_id", null: false
    t.integer "live_id", null: false
    t.index ["live_id"], name: "index_messages_on_live_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "streamers", force: :cascade do |t|
    t.string "name"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.string "tier"
    t.integer "user_id", null: false
    t.integer "streamer_id", null: false
    t.index ["streamer_id"], name: "index_subscriptions_on_streamer_id"
    t.index ["user_id"], name: "index_subscriptions_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
  end

  create_table "watchings", force: :cascade do |t|
    t.integer "duration_in_seconds"
    t.integer "user_id", null: false
    t.integer "live_id", null: false
    t.index ["live_id"], name: "index_watchings_on_live_id"
    t.index ["user_id"], name: "index_watchings_on_user_id"
  end

  add_foreign_key "lives", "streamers"
  add_foreign_key "messages", "lives", column: "live_id"
  add_foreign_key "messages", "users"
  add_foreign_key "subscriptions", "streamers"
  add_foreign_key "subscriptions", "users"
  add_foreign_key "watchings", "lives", column: "live_id"
  add_foreign_key "watchings", "users"
end
