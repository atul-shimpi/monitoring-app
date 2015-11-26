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

ActiveRecord::Schema.define(version: 20151124205633) do

  create_table "host_and_matrices_record_ids", force: :cascade do |t|
    t.integer  "host_id",        limit: 4
    t.string   "type",           limit: 255
    t.integer  "last_record_id", limit: 4
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "host_and_matrices_record_ids", ["host_id"], name: "index_host_and_matrices_record_ids_on_host_id", using: :btree

  create_table "host_configurations", force: :cascade do |t|
    t.integer  "host_id",    limit: 4
    t.string   "os",         limit: 25,               null: false
    t.string   "cpu_size",   limit: 10, default: "0", null: false
    t.integer  "disk_size",  limit: 4,  default: 0,   null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "hosts", force: :cascade do |t|
    t.string   "description",       limit: 50
    t.string   "ip_or_host_name",   limit: 50,                null: false
    t.integer  "port",              limit: 4,  default: 3000, null: false
    t.integer  "connection_status", limit: 4,  default: 0
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  create_table "hosts_and_matrices", force: :cascade do |t|
    t.integer  "host_id",         limit: 4
    t.datetime "collection_time",             null: false
    t.string   "type",            limit: 255, null: false
    t.float    "usage",           limit: 24,  null: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "hosts_and_matrices", ["host_id"], name: "index_hosts_and_matrices_on_host_id", using: :btree

  add_foreign_key "host_and_matrices_record_ids", "hosts"
  add_foreign_key "hosts_and_matrices", "hosts"
end
