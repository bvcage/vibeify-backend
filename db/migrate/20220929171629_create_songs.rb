class CreateSongs < ActiveRecord::Migration[6.1]
  def change
    create_table :songs do |t|
      t.string :spotify_id
      t.string :name
      t.string :album_spotify_id
    end
  end
end
