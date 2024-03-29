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

ActiveRecord::Schema.define(:version => 20111018062457) do

  create_table "leagues", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.boolean  "visible"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matches", :force => true do |t|
    t.integer  "team_1_id"
    t.integer  "team_2_id"
    t.date     "began_on"
    t.integer  "goals_1"
    t.integer  "goals_2"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "league_id"
    t.integer  "half_goals_1"
    t.integer  "half_goals_2"
    t.float    "team_1_odds"
    t.float    "team_2_odds"
    t.float    "draw_odds"
    t.float    "rating"
  end

  add_index "matches", ["rating"], :name => "index_matches_on_rating"

  create_table "teams", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
  end

end
