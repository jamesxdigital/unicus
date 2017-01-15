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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160510172810) do

  create_table "company_values", force: :cascade do |t|
    t.string   "company_value"
    t.string   "icon"
    t.string   "colour"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority"

  create_table "mailer_settings", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "when_objective_added",     default: true
    t.boolean "when_objective_proposed",  default: true
    t.boolean "when_objective_approved",  default: true
    t.boolean "when_objective_rejected",  default: true
    t.boolean "when_peer_review_added",   default: true
    t.boolean "when_peer_review_updated", default: true
    t.boolean "when_user_added",          default: true
    t.boolean "when_account_activated",   default: true
  end

  add_index "mailer_settings", ["user_id"], name: "index_mailer_settings_on_user_id"

  create_table "messages", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "content_id"
    t.integer  "sender_id"
    t.boolean  "seen"
    t.string   "message_type"
    t.string   "title"
    t.text     "message"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "messages", ["content_id"], name: "index_messages_on_content_id"
  add_index "messages", ["sender_id"], name: "index_messages_on_sender_id"
  add_index "messages", ["user_id"], name: "index_messages_on_user_id"

  create_table "objectives", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.boolean  "completed",   default: false
    t.datetime "deadline"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "status",      default: 0
  end

  create_table "peer_reviews", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "manager_id"
    t.text     "e_objective_response"
    t.text     "e_overall_comments"
    t.text     "e_personal_development"
    t.text     "m_objective_response"
    t.text     "m_overall_comments"
    t.text     "m_personal_development"
    t.datetime "deadline"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "photo"
  end

  create_table "photos", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "requests", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "category"
    t.text     "comments"
    t.boolean  "approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "objective_id"
    t.text     "comments"
    t.text     "managers_comments"
    t.string   "title"
    t.boolean  "completed"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "sessions", force: :cascade do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", unique: true
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at"

  create_table "training_categories", force: :cascade do |t|
    t.text     "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",              default: "", null: false
    t.integer  "sign_in_count",      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "manager"
    t.boolean  "admin"
    t.integer  "manager_id"
    t.string   "username"
    t.string   "uid"
    t.string   "mail"
    t.string   "ou"
    t.string   "dn"
    t.string   "sn"
    t.string   "givenname"
  end

  add_index "users", ["email"], name: "index_users_on_email"
  add_index "users", ["manager_id"], name: "index_users_on_manager_id"
  add_index "users", ["username"], name: "index_users_on_username"

end
