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

ActiveRecord::Schema.define(version: 20150827075208) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "playlist_songs", force: :cascade do |t|
    t.integer  "playlist_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "song_title"
    t.string   "artist_name"
    t.string   "notes"
    t.string   "song_uid"
    t.integer  "spotify_index"
  end

  add_index "playlist_songs", ["playlist_id"], name: "index_playlist_songs_on_playlist_id", using: :btree

  create_table "playlist_styles", force: :cascade do |t|
    t.integer  "playlist_id"
    t.string   "background_color"
    t.string   "color"
    t.string   "font_family"
    t.string   "font_size"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "playlist_styles", ["playlist_id"], name: "index_playlist_styles_on_playlist_id", using: :btree

  create_table "playlists", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "title"
  end

  add_foreign_key "playlist_songs", "playlists"
  add_foreign_key "playlist_styles", "playlists"
end
