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

ActiveRecord::Schema.define(version: 20150210073550) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_categories", force: true do |t|
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "code"
    t.integer  "state"
    t.integer  "effect"
    t.boolean  "salary",     default: false
    t.boolean  "cumulative", default: false
  end

  create_table "account_goals", force: true do |t|
    t.integer  "category_id"
    t.integer  "account_id"
    t.decimal  "amount"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "account_goals", ["category_id", "account_id"], name: "index_account_goals_on_category_id_and_account_id", unique: true, using: :btree

  create_table "account_records", force: true do |t|
    t.integer  "account_id"
    t.decimal  "amount"
    t.integer  "category_id"
    t.date     "date"
    t.text     "reason"
    t.string   "who"
    t.text     "subtext"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.decimal  "balance",         default: 0.0
    t.date     "month"
    t.boolean  "affects_balance", default: true
  end

  create_table "accounts", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "currency",   default: "nzd"
  end

  create_table "active_admin_comments", force: true do |t|
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_admin_notes_on_resource_type_and_resource_id", using: :btree

  create_table "badges_sashes", force: true do |t|
    t.integer  "badge_id"
    t.integer  "sash_id"
    t.boolean  "notified_user", default: false
    t.datetime "created_at"
  end

  add_index "badges_sashes", ["badge_id", "sash_id"], name: "index_badges_sashes_on_badge_id_and_sash_id", using: :btree
  add_index "badges_sashes", ["badge_id"], name: "index_badges_sashes_on_badge_id", using: :btree
  add_index "badges_sashes", ["sash_id"], name: "index_badges_sashes_on_sash_id", using: :btree

  create_table "delayed_jobs", force: true do |t|
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

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "dmpd_assignments", force: true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "kind"
    t.integer  "taskset_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dmpd_call_sessions", force: true do |t|
    t.integer  "user_id"
    t.integer  "partner_id"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dmpd_contact_appointments", force: true do |t|
    t.datetime "time"
    t.boolean  "support"
    t.decimal  "amount"
    t.integer  "contact_id"
    t.boolean  "reccuring"
    t.decimal  "frequency"
    t.text     "notes"
    t.string   "address"
    t.date     "gift_date"
    t.date     "gift_confirmed_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "result",              default: 0
  end

  create_table "dmpd_contact_call_events", force: true do |t|
    t.integer  "state",      default: 0
    t.integer  "step",       default: 0
    t.integer  "call_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "message"
    t.integer  "transition"
  end

  create_table "dmpd_contact_calls", force: true do |t|
    t.integer  "state",      default: 0
    t.integer  "step",       default: 0
    t.integer  "contact_id"
    t.datetime "end_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "reason"
  end

  create_table "dmpd_contact_return_calls", force: true do |t|
    t.integer  "contact_id"
    t.datetime "time"
    t.text     "notes"
    t.integer  "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "dmpd_contacts", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.integer  "priority_code"
    t.boolean  "new_church"
    t.string   "email"
    t.string   "address"
    t.string   "primary_phone"
    t.string   "home_phone"
    t.string   "office_phone"
    t.integer  "referer_id"
    t.string   "how_knows"
    t.string   "occupation"
    t.string   "church"
    t.string   "children"
    t.date     "anniversary"
    t.text     "search"
    t.integer  "status",        default: 0
    t.integer  "category",      default: 0
    t.text     "notes"
    t.decimal  "amount"
    t.decimal  "frequency"
    t.date     "gift_date"
    t.boolean  "thanks",        default: false
    t.boolean  "confirmed",     default: false
  end

  create_table "dmpd_logs", force: true do |t|
    t.date     "start"
    t.date     "finish"
    t.decimal  "calling_hours"
    t.integer  "calls_made"
    t.integer  "appointment_asks"
    t.integer  "response_to_appointment_ask"
    t.integer  "appointment_set"
    t.integer  "contact_asks"
    t.integer  "decisions"
    t.integer  "yes_to_monthly"
    t.decimal  "total_monthly_pledged"
    t.decimal  "total_special_pledged"
    t.decimal  "total_monthly_confirmed"
    t.decimal  "total_special_confirmed"
    t.integer  "used_contacts"
    t.integer  "received_contacts"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  create_table "dmpd_tasksets", force: true do |t|
    t.string   "name"
    t.integer  "due_week"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "events", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.text     "additional_information"
    t.text     "speaker_description"
    t.integer  "logo_id"
    t.integer  "programme_id"
    t.integer  "venue_id"
    t.integer  "speaker_id"
    t.integer  "information_id"
    t.date     "start_date"
    t.date     "finish_date"
    t.decimal  "adult_cost"
    t.decimal  "teen_cost"
    t.boolean  "teens_can_attend",         default: true
    t.decimal  "child_cost"
    t.boolean  "children_can_attend",      default: true
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "registration_information"
  end

  create_table "gma_measurements", force: true do |t|
    t.integer  "gma_organization_id"
    t.integer  "gma_staff_report_id"
    t.integer  "gma_id"
    t.string   "name"
    t.text     "description"
    t.decimal  "value"
    t.string   "strategy"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gma_measurements", ["gma_id", "gma_staff_report_id", "gma_organization_id"], name: "gma_measurements_triple_index", unique: true, using: :btree

  create_table "gma_memberships", force: true do |t|
    t.integer  "user_id"
    t.integer  "gma_organization_id"
    t.boolean  "director",            default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gma_memberships", ["user_id", "gma_organization_id"], name: "index_gma_memberships_on_user_id_and_gma_organization_id", unique: true, using: :btree

  create_table "gma_organizations", force: true do |t|
    t.integer  "gma_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "gma_organizations", ["gma_id"], name: "index_gma_organizations_on_gma_id", using: :btree

  create_table "gma_staff_reports", force: true do |t|
    t.integer  "user_id"
    t.integer  "gma_organization_id"
    t.integer  "gma_id"
    t.date     "end_date"
    t.date     "start_date"
    t.integer  "version"
    t.boolean  "submitted"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "gma_update"
  end

  create_table "merit_actions", force: true do |t|
    t.integer  "user_id"
    t.string   "action_method"
    t.integer  "action_value"
    t.boolean  "had_errors",    default: false
    t.string   "target_model"
    t.integer  "target_id"
    t.text     "target_data"
    t.boolean  "processed",     default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "merit_activity_logs", force: true do |t|
    t.integer  "action_id"
    t.string   "related_change_type"
    t.integer  "related_change_id"
    t.string   "description"
    t.datetime "created_at"
  end

  create_table "merit_score_points", force: true do |t|
    t.integer  "score_id"
    t.integer  "num_points", default: 0
    t.string   "log"
    t.datetime "created_at"
  end

  create_table "merit_scores", force: true do |t|
    t.integer "sash_id"
    t.string  "category", default: "default"
  end

  create_table "ministries", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "review_questions", force: true do |t|
    t.string   "text"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "reviews", force: true do |t|
    t.date     "open"
    t.date     "due"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roadblocks", force: true do |t|
    t.string   "title"
    t.text     "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sashes", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", force: true do |t|
    t.string   "session_id", null: false
    t.text     "data"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sessions", ["session_id"], name: "index_sessions_on_session_id", using: :btree
  add_index "sessions", ["updated_at"], name: "index_sessions_on_updated_at", using: :btree

  create_table "user_accounts", force: true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "by_id"
  end

  create_table "user_achievements", force: true do |t|
    t.integer  "user_id"
    t.integer  "achievement_id"
    t.integer  "count",          default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_achievements", ["achievement_id"], name: "index_user_achievements_on_achievement_id", using: :btree
  add_index "user_achievements", ["user_id"], name: "index_user_achievements_on_user_id", using: :btree

  create_table "user_assignments", force: true do |t|
    t.integer  "assignment_id"
    t.integer  "user_id"
    t.text     "answer_text"
    t.boolean  "answer_boolean"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "taskset_id"
    t.integer  "document_id"
  end

  add_index "user_assignments", ["taskset_id"], name: "index_user_assignments_on_taskset_id", using: :btree

  create_table "user_documents", force: true do |t|
    t.integer  "user_id",                             null: false
    t.string   "direct_upload_url",                   null: false
    t.string   "upload_file_name"
    t.string   "upload_content_type"
    t.integer  "upload_file_size"
    t.datetime "upload_updated_at"
    t.boolean  "processed",           default: false, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_documents", ["processed"], name: "index_user_documents_on_processed", using: :btree
  add_index "user_documents", ["user_id"], name: "index_user_documents_on_user_id", using: :btree

  create_table "user_kids", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.text     "dietary_requirements"
    t.text     "medical_requirements"
    t.boolean  "media_waiver"
    t.text     "comments"
    t.integer  "swimming_capability"
    t.boolean  "outings"
    t.text     "activity_limitations"
    t.text     "toileting_assistance"
    t.date     "date_of_birth"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_registrations", force: true do |t|
    t.integer  "user_id"
    t.integer  "event_id"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_review_answers", force: true do |t|
    t.integer  "user_review_id"
    t.integer  "review_question_id"
    t.integer  "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_review_answers", ["review_question_id"], name: "index_user_review_answers_on_review_question_id", using: :btree
  add_index "user_review_answers", ["user_review_id"], name: "index_user_review_answers_on_user_review_id", using: :btree

  create_table "user_reviews", force: true do |t|
    t.integer  "review_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_reviews", ["review_id"], name: "index_user_reviews_on_review_id", using: :btree
  add_index "user_reviews", ["user_id"], name: "index_user_reviews_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "email",                default: "", null: false
    t.string   "first_name"
    t.string   "last_name"
    t.decimal  "mpd_goal"
    t.integer  "sign_in_count",        default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "encrypted_password"
    t.integer  "gma_id"
    t.string   "gma_update"
    t.string   "primary_phone"
    t.string   "home_phone"
    t.string   "office_phone"
    t.string   "address"
    t.integer  "contacts_count",       default: 0
    t.integer  "roles_mask",           default: 0
    t.string   "search"
    t.integer  "sash_id"
    t.integer  "level",                default: 0
    t.integer  "ministry_id"
    t.text     "dietary_requirements"
    t.text     "medical_requirements"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

end
