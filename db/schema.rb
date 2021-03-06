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

ActiveRecord::Schema.define(version: 20180129161103) do

  create_table "problem_collection_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",               null: false
    t.integer  "problem_collection_id", null: false
    t.integer  "score"
    t.date     "planned_at"
    t.date     "completed_at"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.index ["problem_collection_id"], name: "index_problem_collection_histories_on_problem_collection_id", using: :btree
    t.index ["user_id"], name: "index_problem_collection_histories_on_user_id", using: :btree
  end

  create_table "problem_collection_to_problems", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "problem_collection_id", null: false
    t.integer "problem_id",            null: false
    t.integer "order"
    t.index ["problem_collection_id"], name: "index_problem_collection_to_problems_on_problem_collection_id", using: :btree
    t.index ["problem_id"], name: "index_problem_collection_to_problems_on_problem_id", using: :btree
  end

  create_table "problem_collections", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "subject_id",                    null: false
    t.string   "name",                          null: false
    t.integer  "problem_count", default: 0
    t.integer  "total_score",   default: 0
    t.date     "test_day"
    t.boolean  "published",     default: false
    t.integer  "solved_count",  default: 0
    t.integer  "avg_score",     default: 0
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "curriculum"
    t.index ["subject_id"], name: "index_problem_collections_on_subject_id", using: :btree
  end

  create_table "problem_histories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "user_id",                       null: false
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
    t.index ["problem_collection_history_id"], name: "index_problem_histories_on_problem_collection_history_id", using: :btree
    t.index ["problem_collection_id"], name: "index_problem_histories_on_problem_collection_id", using: :btree
    t.index ["problem_id"], name: "index_problem_histories_on_problem_id", using: :btree
    t.index ["subject_id"], name: "index_problem_histories_on_subject_id", using: :btree
    t.index ["user_id"], name: "index_problem_histories_on_user_id", using: :btree
  end

  create_table "problem_images", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "image_file_name",    null: false
    t.string   "image_content_type", null: false
    t.integer  "image_file_size",    null: false
    t.datetime "image_updated_at",   null: false
    t.integer  "problem_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["problem_id"], name: "index_problem_images_on_problem_id", using: :btree
  end

  create_table "problem_source_orders", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "problem_id",        null: false
    t.integer "problem_source_id", null: false
    t.integer "order",             null: false
    t.index ["problem_id"], name: "index_problem_source_orders_on_problem_id", using: :btree
    t.index ["problem_source_id"], name: "index_problem_source_orders_on_problem_source_id", using: :btree
  end

  create_table "problem_sources", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",       null: false
    t.boolean "category"
    t.integer "year"
    t.integer "time"
    t.integer "subject_id"
    t.integer "curriculum"
    t.integer "grade"
    t.integer "location"
    t.integer "institute"
  end

  create_table "problem_subjects", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "problem_id", null: false
    t.integer "subject_id", null: false
    t.index ["problem_id"], name: "index_problem_subjects_on_problem_id", using: :btree
    t.index ["subject_id"], name: "index_problem_subjects_on_subject_id", using: :btree
  end

  create_table "problem_tags", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name"
    t.string  "keyword"
    t.integer "refer_count", default: 0
  end

  create_table "problem_tags_problems", id: false, force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer "problem_tag_id", null: false
    t.integer "problem_id",     null: false
  end

  create_table "problems", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "subject_id"
    t.integer  "level"
    t.integer  "score",                                 default: 0
    t.integer  "year",                                  default: 2017
    t.text     "content",              limit: 16777215
    t.text     "exm_1",                limit: 65535
    t.text     "exm_2",                limit: 65535
    t.text     "exm_3",                limit: 65535
    t.text     "exm_4",                limit: 65535
    t.text     "exm_5",                limit: 65535
    t.string   "answer"
    t.text     "explanation",          limit: 16777215
    t.integer  "total_count",                           default: 0
    t.integer  "correct_count",                         default: 0
    t.integer  "problem_id"
    t.boolean  "set"
    t.datetime "created_at",                                           null: false
    t.datetime "updated_at",                                           null: false
    t.integer  "problem_source_id"
    t.integer  "problem_source_order"
    t.boolean  "is_objective",                          default: true
    t.integer  "correct_ratio"
    t.integer  "exm_1_ratio"
    t.integer  "exm_2_ratio"
    t.integer  "exm_3_ratio"
    t.integer  "exm_4_ratio"
    t.integer  "exm_5_ratio"
    t.index ["problem_id"], name: "index_problems_on_problem_id", using: :btree
    t.index ["subject_id"], name: "index_problems_on_subject_id", using: :btree
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string  "name",            null: false
    t.integer "order"
    t.integer "depth"
    t.string  "path"
    t.integer "subject_id"
    t.integer "main_subject_id"
    t.index ["main_subject_id"], name: "index_subjects_on_main_subject_id", using: :btree
    t.index ["subject_id"], name: "index_subjects_on_subject_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "uid",                              null: false
    t.string   "encrypted_password",  default: "", null: false
    t.string   "name",                default: "", null: false
    t.boolean  "gender",                           null: false
    t.date     "birthday",                         null: false
    t.boolean  "liberal",                          null: false
    t.datetime "remember_created_at"
    t.datetime "last_seen"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

end
