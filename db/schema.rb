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

ActiveRecord::Schema.define(version: 20140829104912) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: true do |t|
    t.string   "login"
    t.string   "name"
    t.string   "mail"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requests_clonings", force: true do |t|
    t.string   "name"
    t.string   "company"
    t.string   "mail"
    t.string   "phone"
    t.string   "shipping_address"
    t.string   "group_leader"
    t.integer  "payment_method"
    t.string   "sample_name"
    t.string   "sample_volume"
    t.string   "pcr_product_size"
    t.string   "inv_name"
    t.string   "inv_rfc"
    t.string   "inv_address"
    t.integer  "inv_state_id"
    t.string   "inv_municipality"
    t.string   "inv_mail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "type",             default: 1
    t.integer  "sequencing_type"
  end

  create_table "requests_states", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
