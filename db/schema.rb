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

ActiveRecord::Schema.define(version: 2021_07_23_085851) do

  create_table "contests", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.integer "closing_day"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["user_id"], name: "index_contests_on_user_id"
  end

  create_table "photos", charset: "utf8mb4", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.string "image"
    t.bigint "user_id", null: false
    t.bigint "contest_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["contest_id"], name: "index_photos_on_contest_id"
    t.index ["user_id"], name: "index_photos_on_user_id"
  end

  create_table "user_photo_comments", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "photo_id", null: false
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["photo_id"], name: "index_user_photo_comments_on_photo_id"
    t.index ["user_id"], name: "index_user_photo_comments_on_user_id"
  end

  create_table "user_photo_likes", charset: "utf8mb4", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "photo_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["photo_id"], name: "index_user_photo_likes_on_photo_id"
    t.index ["user_id"], name: "index_user_photo_likes_on_user_id"
  end

  create_table "users", charset: "utf8mb4", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "profile"
  end

  add_foreign_key "contests", "users"
  add_foreign_key "photos", "contests"
  add_foreign_key "photos", "users"
  add_foreign_key "user_photo_comments", "photos"
  add_foreign_key "user_photo_comments", "users"
  add_foreign_key "user_photo_likes", "photos"
  add_foreign_key "user_photo_likes", "users"
end
