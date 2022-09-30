class CreateSaves < ActiveRecord::Migration[6.1]
  def change
    create_table :saves do |t|
      t.string :playlist_spotify_id
      t.integer :playlist_id
      t.string :song_spotify_id
      t.integer :song_id
    end
  end
end
