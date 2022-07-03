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

ActiveRecord::Schema.define(version: 2022_07_03_171716) do

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.integer "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "administrations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "school_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_administrations_on_school_id"
    t.index ["user_id", "school_id"], name: "index_administrations_on_user_id_and_school_id", unique: true
    t.index ["user_id"], name: "index_administrations_on_user_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.integer "course_id"
    t.datetime "due_at"
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_assignments_on_course_id"
  end

  create_table "conversation_participations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "conversation_id"
    t.datetime "viewed_at", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "conversation_id"], name: "index_participation_user_conversation", unique: true
  end

  create_table "conversations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "course_participations", force: :cascade do |t|
    t.integer "course_id"
    t.integer "user_id"
    t.integer "role"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_course_participations_on_course_id"
    t.index ["user_id", "course_id"], name: "index_course_participations_on_user_id_and_course_id", unique: true
    t.index ["user_id"], name: "index_course_participations_on_user_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "name"
    t.integer "school_id"
    t.date "starts_on"
    t.date "ends_on"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_courses_on_school_id"
  end

  create_table "data_files", force: :cascade do |t|
    t.string "name"
    t.string "repository_type"
    t.integer "repository_id"
    t.string "uuid"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["repository_type", "repository_id"], name: "index_data_files_on_repository_type_and_repository_id"
  end

  create_table "group_participations", force: :cascade do |t|
    t.integer "user_id"
    t.string "group_type"
    t.integer "group_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["group_type", "group_id"], name: "index_group_participations_on_group_type_and_group_id"
    t.index ["user_id"], name: "index_group_participations_on_user_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.integer "course_id"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.text "description"
    t.string "location"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["course_id"], name: "index_lectures_on_course_id"
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "conversation_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id", "created_at"], name: "index_messages_on_conversation_id_and_created_at"
    t.index ["conversation_id"], name: "index_messages_on_conversation_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "news_posts", force: :cascade do |t|
    t.string "name"
    t.text "content"
    t.integer "user_id"
    t.string "news_feed_type"
    t.integer "news_feed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["news_feed_type", "news_feed_id"], name: "index_news_posts_on_news_feed_type_and_news_feed_id"
    t.index ["user_id"], name: "index_news_posts_on_user_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "submissions", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.integer "assignment_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_submissions_on_assignment_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "login"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.integer "gender", default: 0
    t.string "phone"
    t.date "birth_date"
    t.string "picture"
    t.integer "school_id"
    t.boolean "admin", default: false
    t.index ["login"], name: "index_users_on_login", unique: true
    t.index ["school_id"], name: "index_users_on_school_id"
  end

  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
end
