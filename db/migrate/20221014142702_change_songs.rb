class ChangeSongs < ActiveRecord::Migration[6.1]
  def change
    add_column :songs, :album_name, :string
    add_column :songs, :album_art_url, :string
    add_column :songs, :artist, :string
    add_column :songs, :spotify_url, :string
  end
end
