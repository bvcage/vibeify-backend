# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_10_16_022712) do

  create_table "audio_features", force: :cascade do |t|
    t.integer "song_id"
    t.string "spotify_song_id"
    t.float "acousticness"
    t.float "danceability"
    t.float "energy"
    t.float "instrumentalness"
    t.integer "key"
    t.float "liveness"
    t.float "loudness"
    t.integer "mode"
    t.float "speechiness"
    t.float "tempo"
    t.integer "time_signature"
    t.float "valence"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "playlists", force: :cascade do |t|
    t.string "spotify_id"
    t.string "name"
    t.string "image_url"
    t.string "owner_id"
    t.integer "user_id"
    t.boolean "vibeify"
    t.text "description"
  end

  create_table "saves", force: :cascade do |t|
    t.string "playlist_spotify_id"
    t.integer "playlist_id"
    t.string "song_spotify_id"
    t.integer "song_id"
  end

  create_table "songs", force: :cascade do |t|
    t.string "spotify_id"
    t.string "name"
    t.string "album_spotify_id"
    t.string "album_name"
    t.string "album_art_url"
    t.string "artist"
    t.string "spotify_url"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "spotify_id"
  end

end
