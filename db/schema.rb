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

ActiveRecord::Schema.define(version: 2019_09_10_210557) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cards", force: :cascade do |t|
    t.string "name"
    t.string "category"
    t.integer "cost"
    t.integer "victory_points"
    t.integer "spending_power"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "buying_power"
    t.integer "actions_provided"
    t.integer "cards_to_draw"
    t.string "image"
    t.string "desc"
    t.string "tags"
  end

  create_table "game_cards", force: :cascade do |t|
    t.bigint "game_id"
    t.bigint "card_id"
    t.bigint "player_id"
    t.boolean "trashed", default: false
    t.boolean "discarded", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "deck_index"
    t.index ["card_id"], name: "index_game_cards_on_card_id"
    t.index ["game_id"], name: "index_game_cards_on_game_id"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "turn", default: 0
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.bigint "game_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_players_on_game_id"
  end

  add_foreign_key "game_cards", "cards"
  add_foreign_key "game_cards", "games"
  add_foreign_key "players", "games"
end
