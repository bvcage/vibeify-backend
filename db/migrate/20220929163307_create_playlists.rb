class CreatePlaylists < ActiveRecord::Migration[6.1]
  def change
    create_table :playlists do |t|
      t.string :spotify_id
      t.string :name
      t.string :image_url
      t.string :owner_id
      t.integer :user_id
    end
  end
end
