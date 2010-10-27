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

ActiveRecord::Schema.define(:version => 20101027062552) do

  create_table "answers", :force => true do |t|
    t.integer "job_id"
    t.integer "answer_type",                :null => false
    t.integer "question_id",                :null => false
    t.integer "data1",       :default => 0, :null => false
    t.integer "data2",       :default => 0, :null => false
    t.integer "data3",       :default => 0, :null => false
    t.integer "data4",       :default => 0, :null => false
    t.integer "profile_id",                 :null => false
  end

  create_table "companies", :force => true do |t|
    t.string   "company_name", :limit => 200
    t.integer  "headquarters"
    t.string   "apply_email",  :limit => 100
    t.boolean  "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "soft_deleted",                :default => false
  end

  create_table "jobs", :force => true do |t|
    t.string   "title",        :limit => 100
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "work_site_id"
    t.integer  "profile_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "soft_deleted",                :default => false
  end

  create_table "profiles", :force => true do |t|
    t.string   "fullname"
    t.integer  "birth_day"
    t.integer  "birth_month"
    t.integer  "birth_year"
    t.integer  "gender"
    t.string   "time_zone"
    t.text     "address"
    t.string   "country"
    t.string   "state"
    t.integer  "user_id"
    t.boolean  "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "demo"
    t.boolean  "soft_deleted", :default => false
  end

  create_table "question_answers", :force => true do |t|
    t.string   "text"
    t.integer  "question_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "questions", :force => true do |t|
    t.integer  "question_type"
    t.text     "text"
    t.integer  "created_by"
    t.boolean  "verified"
    t.boolean  "completed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "soft_deleted",  :default => false
  end

  create_table "statistics", :force => true do |t|
    t.string   "name"
    t.integer  "int_value"
    t.float    "float_value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "",    :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "",    :null => false
    t.string   "password_salt",                       :default => "",    :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",                     :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.string   "login",                :limit => 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "admin",                               :default => false
  end

  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

  create_table "utterly_naive_matches", :force => true do |t|
    t.integer  "howgood"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "work_sites", :force => true do |t|
    t.string   "company_name", :limit => 200
    t.integer  "company_id"
    t.string   "description",  :limit => 200
    t.text     "address"
    t.boolean  "verified"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "soft_deleted",                :default => false
  end

end
