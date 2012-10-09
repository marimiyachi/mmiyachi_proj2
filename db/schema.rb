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

ActiveRecord::Schema.define(:version => 20121009001140) do

  create_table "items", :force => true do |t|
    t.string   "name"
    t.integer  "price"
    t.integer  "quantity"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "store_id"
  end

  create_table "storekeepers", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "remember_token"
  end

  add_index "storekeepers", ["email"], :name => "index_storekeepers_on_email", :unique => true
  add_index "storekeepers", ["remember_token"], :name => "index_storekeepers_on_remember_token"

  create_table "stores", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.integer  "storekeeper_id"
  end

end
