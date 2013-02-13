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

ActiveRecord::Schema.define(:version => 20130213151035) do

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "cust_emails", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "customers", :force => true do |t|
    t.string   "FirstName"
    t.string   "LastName"
    t.string   "Company"
    t.string   "Address1"
    t.string   "Address2"
    t.string   "Email"
    t.string   "City"
    t.string   "StateCountry"
    t.string   "PostalCode"
    t.string   "Phone"
    t.integer  "PO"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "line_items", :force => true do |t|
    t.string   "product_desc"
    t.integer  "cart_id"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.string   "product_id"
    t.integer  "duration"
    t.string   "duration_type"
  end

  create_table "order_starts", :force => true do |t|
    t.string   "customer_email"
    t.string   "agency_email"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

end
