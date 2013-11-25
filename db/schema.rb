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

ActiveRecord::Schema.define(:version => 20131125033951) do

  create_table "accounts", :force => true do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "active_admin_comments", :force => true do |t|
    t.string   "resource_id",   :null => false
    t.string   "resource_type", :null => false
    t.integer  "author_id"
    t.string   "author_type"
    t.text     "body"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "namespace"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], :name => "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], :name => "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], :name => "index_admin_notes_on_resource_type_and_resource_id"

  create_table "appointment_set_records", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_set"
    t.date     "date_of_appointment"
    t.boolean  "support"
    t.decimal  "amount"
    t.date     "gift_date"
    t.date     "gift_confirmed_date"
    t.boolean  "asked_for_contacts"
    t.integer  "number_of_contacts_received"
    t.boolean  "thank_you_posted"
    t.integer  "date_set_week_id"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.integer  "user_id"
    t.integer  "date_of_appointment_week_id"
    t.integer  "gift_date_week_id"
    t.integer  "gift_confirmed_date_week_id"
    t.decimal  "frequency"
    t.decimal  "monthly"
  end

  create_table "contact_card_boxes", :force => true do |t|
    t.integer  "week_id"
    t.integer  "contact_cards",             :default => 0
    t.integer  "not_back_until",            :default => 0
    t.integer  "office_phone_only",         :default => 0
    t.integer  "research",                  :default => 0
    t.integer  "call_back_for_appointment", :default => 0
    t.integer  "call_back_for_decision",    :default => 0
    t.integer  "call_back_for_contacts",    :default => 0
    t.integer  "appointment_set",           :default => 0
    t.integer  "called_no_appointment_set", :default => 0
    t.integer  "appointment_no_support",    :default => 0
    t.integer  "new_ministry_partner",      :default => 0
    t.integer  "call_back_in_a_year",       :default => 0
    t.integer  "would_have_met",            :default => 0
    t.integer  "on_list",                   :default => 0
    t.integer  "maintainance",              :default => 0
    t.integer  "maintainance_done",         :default => 0
    t.integer  "user_id"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
  end

  create_table "contacts", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "currencies", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "currency_rates", :force => true do |t|
    t.date     "month"
    t.decimal  "rate"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "currency_id"
  end

  create_table "goals", :force => true do |t|
    t.integer  "type_id"
    t.integer  "account_id"
    t.decimal  "amount"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "goals", ["type_id", "account_id"], :name => "index_goals_on_type_id_and_account_id", :unique => true

  create_table "records", :force => true do |t|
    t.integer  "account_id"
    t.decimal  "amount"
    t.integer  "type_id"
    t.date     "date"
    t.text     "reason"
    t.string   "who"
    t.text     "subtext"
    t.datetime "created_at",                  :null => false
    t.datetime "updated_at",                  :null => false
    t.decimal  "balance",    :default => 0.0
    t.date     "month"
  end

  create_table "scopes", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "support_raising_developments", :force => true do |t|
    t.integer  "number_of_calls_made"
    t.integer  "appointments_asked_for"
    t.integer  "contacts_asked_for"
    t.integer  "user_id"
    t.integer  "week_id"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "hours_calling"
  end

  create_table "types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "definition"
    t.string   "code"
  end

  create_table "user_accounts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "by_id"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "admin"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.string   "email",             :default => "", :null => false
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "bootcamp_coach_id"
    t.integer  "currency_id"
  end

  add_index "users", ["username"], :name => "index_users_on_username", :unique => true

  create_table "week1s", :force => true do |t|
    t.boolean  "prayer_sheet"
    t.boolean  "memorize_prayer_sheet_passage"
    t.boolean  "share_call_testimony"
    t.boolean  "share_salvation_testimony"
    t.boolean  "recite_passage_from_dmpd_prayer_sheet"
    t.boolean  "listen_to_attitude_message"
    t.boolean  "practice_calling_blurbs"
    t.boolean  "review_how_to_prepare_appt_calling_boxes"
    t.boolean  "review_healthy_staff_support_is_essentials"
    t.boolean  "recite_the_flow"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
    t.integer  "user_id"
    t.boolean  "confirmed_coach"
    t.boolean  "confirmed_hr"
  end

  create_table "week2s", :force => true do |t|
    t.boolean  "prayer_sheet"
    t.boolean  "memorize_prayer_sheet_passage"
    t.boolean  "share_call_testimony"
    t.boolean  "share_salvation_testimony"
    t.boolean  "recite_passage_from_dmpd_prayer_sheet"
    t.boolean  "listen_to_attitude_message"
    t.boolean  "practice_calling_blurbs"
    t.boolean  "review_how_to_prepare_appt_calling_boxes"
    t.datetime "created_at",                               :null => false
    t.datetime "updated_at",                               :null => false
    t.integer  "user_id"
    t.boolean  "confirmed_coach"
    t.boolean  "confirmed_hr"
  end

  create_table "week3s", :force => true do |t|
    t.boolean  "prayer_sheet"
    t.boolean  "memorize_prayer_sheet_passage"
    t.boolean  "share_call_testimony"
    t.boolean  "share_salvation_testimony"
    t.boolean  "recite_passage_from_dmpd_prayer_sheet"
    t.boolean  "listen_to_attitude_message"
    t.boolean  "review_how_to_develop_your_ministry_partners"
    t.boolean  "practice_tandems_financial_policy"
    t.datetime "created_at",                                   :null => false
    t.datetime "updated_at",                                   :null => false
    t.integer  "user_id"
    t.boolean  "confirmed_coach"
    t.boolean  "confirmed_hr"
    t.boolean  "practice_our_teams_current_financial_needs"
    t.string   "vision_folder_file_name"
    t.string   "vision_folder_content_type"
    t.integer  "vision_folder_file_size"
    t.datetime "vision_folder_updated_at"
  end

  create_table "week4s", :force => true do |t|
    t.boolean  "prayer_sheet"
    t.boolean  "memorize_prayer_sheet_passage"
    t.boolean  "share_call_testimony"
    t.boolean  "share_salvation_testimony"
    t.boolean  "recite_passage_from_dmpd_prayer_sheet"
    t.boolean  "listen_to_attitude_message"
    t.boolean  "review_the_five_main_things"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.integer  "user_id"
    t.boolean  "confirmed_coach"
    t.boolean  "confirmed_hr"
  end

  create_table "week5s", :force => true do |t|
    t.boolean  "recite_passage_from_dmpd_prayer_sheet"
    t.boolean  "prayer_sheet"
    t.boolean  "share_call_testimony"
    t.boolean  "share_salvation_testimony"
    t.boolean  "review_non_negotiables_of_effective_mpd"
    t.boolean  "listen_to_attitude_message"
    t.text     "missionary_profile"
    t.boolean  "memorize_prayer_sheet_passage"
    t.boolean  "confirmed_coach"
    t.boolean  "confirmed_hr"
    t.integer  "user_id"
    t.datetime "created_at",                              :null => false
    t.datetime "updated_at",                              :null => false
  end

  create_table "week6s", :force => true do |t|
    t.integer  "user_id"
    t.boolean  "prayer_sheet"
    t.text     "salvation_testimony"
    t.boolean  "share_salvation_testimony"
    t.text     "call_testimony"
    t.boolean  "share_call_testimony"
    t.boolean  "review_purpose_of_dmpd_training"
    t.boolean  "review_how_to_get_contacts_faster_than_you_can_use_them"
    t.boolean  "listen_to_attitude_message"
    t.text     "discipleship_story_1"
    t.text     "discipleship_story_2"
    t.text     "discipleship_story_3"
    t.text     "victory_story_1"
    t.text     "victory_story_2"
    t.boolean  "memorize_prayer_sheet_passage"
    t.binary   "picture_of_you_1"
    t.binary   "picture_of_you_2"
    t.datetime "created_at",                                              :null => false
    t.datetime "updated_at",                                              :null => false
    t.boolean  "confirmed_coach"
    t.boolean  "confirmed_hr"
  end

  create_table "weeks", :force => true do |t|
    t.date     "date_start"
    t.date     "date_finished"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

end
