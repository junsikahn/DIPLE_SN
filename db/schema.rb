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

ActiveRecord::Schema.define(version: 20170623210652) do

  create_table "banks", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "book_histories", force: :cascade do |t|
    t.integer  "match_id",        null: false
    t.integer  "book_id",         null: false
    t.integer  "book_unit_id"
    t.date     "started_at"
    t.date     "planned_at"
    t.date     "completed_at"
    t.integer  "start_page"
    t.integer  "planned_page"
    t.integer  "completed_page"
    t.integer  "book_history_id"
    t.string   "tag_color"
    t.integer  "rating"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["book_history_id"], name: "index_book_histories_on_book_history_id"
    t.index ["book_id"], name: "index_book_histories_on_book_id"
    t.index ["book_unit_id"], name: "index_book_histories_on_book_unit_id"
    t.index ["match_id"], name: "index_book_histories_on_match_id"
  end

  create_table "book_publishers", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "book_units", force: :cascade do |t|
    t.integer "subject_id",             null: false
    t.integer "book_id",                null: false
    t.integer "order"
    t.integer "depth",      default: 0
    t.string  "name"
    t.integer "page"
    t.index ["book_id"], name: "index_book_units_on_book_id"
    t.index ["subject_id"], name: "index_book_units_on_subject_id"
  end

  create_table "books", force: :cascade do |t|
    t.integer "subject_id",        null: false
    t.integer "book_publisher_id", null: false
    t.string  "name"
    t.string  "series"
    t.integer "total_page"
    t.date    "published_at"
    t.index ["book_publisher_id"], name: "index_books_on_book_publisher_id"
    t.index ["subject_id"], name: "index_books_on_subject_id"
  end

  create_table "careers", force: :cascade do |t|
    t.integer  "user_id",       null: false
    t.string   "category",      null: false
    t.string   "school"
    t.string   "major_1"
    t.string   "major_2"
    t.string   "major_3"
    t.string   "status"
    t.date     "entrance_year"
    t.date     "graduate_year"
    t.datetime "authorized_at"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["user_id"], name: "index_careers_on_user_id"
  end

  create_table "comments", force: :cascade do |t|
    t.integer  "match_id",     null: false
    t.integer  "user_id",      null: false
    t.integer  "subject_id",   null: false
    t.text     "content"
    t.date     "completed_at"
    t.integer  "comment_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["comment_id"], name: "index_comments_on_comment_id"
    t.index ["match_id"], name: "index_comments_on_match_id"
    t.index ["subject_id"], name: "index_comments_on_subject_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "favored_subjects", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.integer  "subject_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_favored_subjects_on_subject_id"
    t.index ["user_id"], name: "index_favored_subjects_on_user_id"
  end

  create_table "highschools", force: :cascade do |t|
    t.string "name",     null: false
    t.string "location"
    t.string "address"
  end

  create_table "locations", force: :cascade do |t|
    t.integer  "user_id",                          null: false
    t.string   "full_address",                     null: false
    t.string   "lng"
    t.string   "lat"
    t.string   "mountain"
    t.string   "localName_1"
    t.string   "localName_2"
    t.string   "localName_3"
    t.string   "main_address"
    t.string   "sub_address"
    t.string   "building_address"
    t.string   "is_new_address"
    t.string   "new_address"
    t.string   "zipcode"
    t.string   "zone_no"
    t.integer  "distance"
    t.boolean  "is_checked",       default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["user_id"], name: "index_locations_on_user_id"
  end

  create_table "majors", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "matches", force: :cascade do |t|
    t.integer  "mentor_id",  null: false
    t.integer  "mentee_id",  null: false
    t.text     "study"
    t.text     "school"
    t.text     "history"
    t.text     "korean"
    t.text     "english"
    t.text     "math"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentee_id"], name: "index_matches_on_mentee_id"
    t.index ["mentor_id"], name: "index_matches_on_mentor_id"
  end

  create_table "mentees", force: :cascade do |t|
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_mentees_on_user_id"
  end

  create_table "mentors", force: :cascade do |t|
    t.integer  "user_id",                        null: false
    t.text     "self_introduction", default: ""
    t.string   "bank_name"
    t.string   "account_number"
    t.datetime "recruited_at"
    t.datetime "interviewed_at"
    t.datetime "authorized_at"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["user_id"], name: "index_mentors_on_user_id"
  end

  create_table "online_lecture_histories", force: :cascade do |t|
    t.integer  "match_id",                  null: false
    t.integer  "online_lecture_id",         null: false
    t.integer  "online_lecture_list_id"
    t.date     "started_at"
    t.date     "planned_at"
    t.date     "completed_at"
    t.integer  "online_lecture_history_id"
    t.string   "tag_color"
    t.integer  "rating"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["match_id"], name: "index_online_lecture_histories_on_match_id"
    t.index ["online_lecture_history_id"], name: "index_online_lecture_histories_on_online_lecture_history_id"
    t.index ["online_lecture_id"], name: "index_online_lecture_histories_on_online_lecture_id"
    t.index ["online_lecture_list_id"], name: "index_online_lecture_histories_on_online_lecture_list_id"
  end

  create_table "online_lecture_lists", force: :cascade do |t|
    t.integer  "online_lecture_id",              null: false
    t.integer  "order"
    t.string   "title",             default: ""
    t.integer  "time",              default: 0
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["online_lecture_id"], name: "index_online_lecture_lists_on_online_lecture_id"
  end

  create_table "online_lectures", force: :cascade do |t|
    t.integer  "subject_id",                         null: false
    t.integer  "online_provider_id",                 null: false
    t.string   "uid",                                null: false
    t.string   "title",                              null: false
    t.integer  "online_teacher_id",                  null: false
    t.string   "target",             default: ""
    t.integer  "lecture_count",      default: 0
    t.boolean  "is_completed",       default: false
    t.string   "package_ids",        default: ""
    t.boolean  "is_collected",       default: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.index ["online_provider_id"], name: "index_online_lectures_on_online_provider_id"
    t.index ["online_teacher_id"], name: "index_online_lectures_on_online_teacher_id"
    t.index ["subject_id"], name: "index_online_lectures_on_subject_id"
  end

  create_table "online_providers", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "online_teachers", force: :cascade do |t|
    t.string  "name",               null: false
    t.string  "uid",                null: false
    t.integer "online_provider_id", null: false
    t.integer "subject_id",         null: false
    t.index ["online_provider_id"], name: "index_online_teachers_on_online_provider_id"
    t.index ["subject_id"], name: "index_online_teachers_on_subject_id"
  end

  create_table "problem_collection_histories", force: :cascade do |t|
    t.integer  "match_id",              null: false
    t.integer  "problem_collection_id", null: false
    t.integer  "score"
    t.date     "planned_at"
    t.date     "completed_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["match_id"], name: "index_problem_collection_histories_on_match_id"
    t.index ["problem_collection_id"], name: "index_problem_collection_histories_on_problem_collection_id"
  end

  create_table "problem_collection_to_problems", force: :cascade do |t|
    t.integer "problem_collection_id", null: false
    t.integer "problem_id",            null: false
    t.integer "order"
    t.index ["problem_collection_id"], name: "index_problem_collection_to_problems_on_problem_collection_id"
    t.index ["problem_id"], name: "index_problem_collection_to_problems_on_problem_id"
  end

  create_table "problem_collections", force: :cascade do |t|
    t.integer  "subject_id",                        null: false
    t.integer  "problem_source_id",                 null: false
    t.string   "name",                              null: false
    t.integer  "problem_count",     default: 0
    t.integer  "total_score",       default: 0
    t.date     "test_day"
    t.boolean  "published",         default: false
    t.integer  "solved_count",      default: 0
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["problem_source_id"], name: "index_problem_collections_on_problem_source_id"
    t.index ["subject_id"], name: "index_problem_collections_on_subject_id"
  end

  create_table "problem_histories", force: :cascade do |t|
    t.integer  "match_id",                      null: false
    t.integer  "subject_id",                    null: false
    t.integer  "problem_collection_id",         null: false
    t.integer  "problem_id",                    null: false
    t.integer  "problem_collection_history_id"
    t.string   "users_answer"
    t.boolean  "correct"
    t.boolean  "check"
    t.string   "comment_image_file_name"
    t.string   "comment_image_content_type"
    t.integer  "comment_image_file_size"
    t.datetime "comment_image_updated_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["match_id"], name: "index_problem_histories_on_match_id"
    t.index ["problem_collection_history_id"], name: "index_problem_histories_on_problem_collection_history_id"
    t.index ["problem_collection_id"], name: "index_problem_histories_on_problem_collection_id"
    t.index ["problem_id"], name: "index_problem_histories_on_problem_id"
    t.index ["subject_id"], name: "index_problem_histories_on_subject_id"
  end

  create_table "problem_sources", force: :cascade do |t|
    t.string "name", null: false
  end

  create_table "problems", force: :cascade do |t|
    t.integer  "subject_id",                                              null: false
    t.integer  "level"
    t.integer  "score",                                       default: 0
    t.text     "content",                    limit: 16777215
    t.text     "exm_1"
    t.text     "exm_2"
    t.text     "exm_3"
    t.text     "exm_4"
    t.text     "exm_5"
    t.string   "answer"
    t.text     "explanation",                limit: 16777215
    t.integer  "total_count",                                 default: 0
    t.integer  "correct_count",                               default: 0
    t.integer  "problem_id"
    t.boolean  "set"
    t.string   "content_image_file_name"
    t.string   "content_image_content_type"
    t.integer  "content_image_file_size"
    t.datetime "content_image_updated_at"
    t.string   "answer_image_file_name"
    t.string   "answer_image_content_type"
    t.integer  "answer_image_file_size"
    t.datetime "answer_image_updated_at"
    t.string   "audio_file_name"
    t.string   "audio_content_type"
    t.integer  "audio_file_size"
    t.datetime "audio_updated_at"
    t.datetime "created_at",                                              null: false
    t.datetime "updated_at",                                              null: false
    t.index ["problem_id"], name: "index_problems_on_problem_id"
    t.index ["subject_id"], name: "index_problems_on_subject_id"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "match_id"
    t.integer  "day_of_week", null: false
    t.integer  "time_start",  null: false
    t.integer  "time_end",    null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["match_id"], name: "index_schedules_on_match_id"
    t.index ["user_id"], name: "index_schedules_on_user_id"
  end

  create_table "subjects", force: :cascade do |t|
    t.string  "name",            null: false
    t.integer "order"
    t.integer "depth"
    t.string  "path"
    t.integer "subject_id"
    t.integer "main_subject_id"
    t.index ["main_subject_id"], name: "index_subjects_on_main_subject_id"
    t.index ["subject_id"], name: "index_subjects_on_subject_id"
  end

  create_table "universities", force: :cascade do |t|
    t.string "name",     null: false
    t.string "location"
    t.string "address"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",                default: "", null: false
    t.string   "encrypted_password",  default: "", null: false
    t.string   "phone",                            null: false
    t.integer  "pin"
    t.datetime "pin_sent_at"
    t.datetime "verified_at"
    t.string   "email",               default: ""
    t.boolean  "gender"
    t.date     "birthday"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.datetime "agreed_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",       default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "last_seen"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.index ["phone"], name: "index_users_on_phone", unique: true
  end

end
