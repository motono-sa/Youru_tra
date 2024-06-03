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

ActiveRecord::Schema[7.1].define(version: 2024_06_03_085328) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "training_parts", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_video_searches", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "training_part_id", null: false
    t.bigint "video_id", null: false
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["training_part_id"], name: "index_user_video_searches_on_training_part_id"
    t.index ["user_id"], name: "index_user_video_searches_on_user_id"
    t.index ["video_id"], name: "index_user_video_searches_on_video_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "crypted_password"
    t.string "salt"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  create_table "videos", force: :cascade do |t|
    t.string "title"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "user_video_searches", "training_parts"
  add_foreign_key "user_video_searches", "users"
  add_foreign_key "user_video_searches", "videos"
end
