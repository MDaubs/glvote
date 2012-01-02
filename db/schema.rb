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

ActiveRecord::Schema.define(:version => 20120101002236) do

  create_table "ballot_selections", :force => true do |t|
    t.integer  "ballot_id"
    t.integer  "candidate_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ballots", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "cast",       :default => false
  end

  create_table "booths", :force => true do |t|
    t.string  "voter_name"
    t.boolean "begin_pressed",          :default => false
    t.boolean "voter_name_confirmed",   :default => false
    t.boolean "instructions_confirmed", :default => false
    t.integer "active_ballot_id"
    t.integer "active_office_id"
  end

  create_table "candidates", :force => true do |t|
    t.string  "name"
    t.integer "office_id"
  end

  create_table "offices", :force => true do |t|
    t.string "name"
  end

end
