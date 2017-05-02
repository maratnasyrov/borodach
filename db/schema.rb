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

ActiveRecord::Schema.define(version: 20170501012901) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string   "name",               null: false
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.integer  "provider_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name",                         null: false
    t.boolean  "not_for_sale", default: false, null: false
    t.integer  "brand_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  create_table "client_histories", force: :cascade do |t|
    t.integer  "client_id"
    t.integer  "work_day_id"
    t.integer  "day_id"
    t.integer  "master_id"
    t.integer  "record_id"
    t.boolean  "new_client",  default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string   "name",                   null: false
    t.string   "phone",                  null: false
    t.integer  "number",     default: 0, null: false
    t.integer  "record_id"
    t.integer  "master_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "costs", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "days", force: :cascade do |t|
    t.integer "number_of_the_day", null: false
    t.integer "month_id"
  end

  create_table "finance_days", force: :cascade do |t|
    t.integer  "day_id"
    t.integer  "month_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "finances", force: :cascade do |t|
    t.integer  "master_id"
    t.integer  "day_id"
    t.boolean  "cash_type",        default: false, null: false
    t.integer  "price",                            null: false
    t.string   "comment"
    t.string   "client_name"
    t.string   "client_phone"
    t.boolean  "service_type"
    t.integer  "service_id"
    t.boolean  "finance_type",     default: false, null: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.integer  "finance_day_id"
    t.integer  "record_id"
    t.integer  "working_shift_id"
  end

  create_table "landing_images", force: :cascade do |t|
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "masters", force: :cascade do |t|
    t.string   "name",                           default: "", null: false
    t.string   "last_name",                      default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.string   "phone",               limit: 11
    t.string   "email"
    t.date     "birthday"
    t.string   "about_master"
    t.boolean  "master_active"
    t.boolean  "online_record"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
  end

  create_table "month_salaries", force: :cascade do |t|
    t.integer  "sales",      default: 0
    t.integer  "services",   default: 0
    t.integer  "master_id"
    t.integer  "month_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "months", force: :cascade do |t|
    t.string  "name_of_the_month", null: false
    t.integer "year_id"
    t.integer "number"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "name",          null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "status"
    t.boolean  "closed_status"
    t.integer  "invoice"
    t.integer  "provider_id"
    t.date     "closed_date"
    t.boolean  "wait"
  end

  create_table "pre_records", force: :cascade do |t|
    t.integer  "day_id"
    t.integer  "record_id"
    t.string   "client_name"
    t.string   "client_phone"
    t.integer  "master_id"
    t.string   "after"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "product_lists", force: :cascade do |t|
    t.string   "name",                          null: false
    t.integer  "price",                         null: false
    t.integer  "number",                        null: false
    t.integer  "order_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.boolean  "closed_status", default: false
    t.integer  "purchase_id"
    t.integer  "bulk"
  end

  create_table "providers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.string   "contact_name"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "purchase_histories", force: :cascade do |t|
    t.integer  "purchase_id"
    t.integer  "number_changes", null: false
    t.integer  "price",          null: false
    t.string   "seller"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "purchases", force: :cascade do |t|
    t.string   "name",                         null: false
    t.integer  "price",                        null: false
    t.integer  "number",       default: 0
    t.integer  "initial_cost"
    t.integer  "bulk",                         null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "brand_id",     default: 0
    t.boolean  "not_for_sale", default: false
    t.integer  "category_id"
    t.integer  "need_number",  default: 2
  end

  create_table "record_purchases", force: :cascade do |t|
    t.integer  "record_id"
    t.integer  "purchase_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "record_services", force: :cascade do |t|
    t.integer  "record_id"
    t.integer  "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "record_shelves", force: :cascade do |t|
    t.integer  "record_id"
    t.integer  "shelf_id"
    t.integer  "day_id"
    t.integer  "number",     default: 0
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "records", force: :cascade do |t|
    t.string   "client_name"
    t.string   "client_phone"
    t.string   "payment_method"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "comment"
    t.integer  "discount"
    t.integer  "price"
    t.boolean  "dinner",         default: false, null: false
    t.boolean  "client_added",   default: false, null: false
    t.boolean  "closed_record",  default: false, null: false
    t.integer  "work_day_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.boolean  "online"
    t.boolean  "not_show",       default: false
    t.integer  "record_id"
  end

  create_table "salons", force: :cascade do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string   "name",       null: false
    t.integer  "price",      null: false
    t.string   "time",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "master_id"
    t.boolean  "coloration"
  end

  create_table "shelf_histories", force: :cascade do |t|
    t.integer  "shelf_id"
    t.integer  "master_id"
    t.integer  "day_id"
    t.integer  "number_changes", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "record_id"
  end

  create_table "shelves", force: :cascade do |t|
    t.string   "name"
    t.integer  "number"
    t.integer  "bulk"
    t.integer  "purchase_id"
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "brand_id",    default: 0
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "full_name",              limit: 255
    t.string   "role"
    t.integer  "telegram_chat_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "work_days", force: :cascade do |t|
    t.integer  "master_id"
    t.integer  "day_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "salon_id"
  end

  create_table "working_shifts", force: :cascade do |t|
    t.integer  "sales",           default: 0
    t.integer  "services",        default: 0
    t.integer  "master_id"
    t.integer  "day_id"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "month_salary_id"
  end

  create_table "years", force: :cascade do |t|
    t.integer "number", null: false
  end

end
