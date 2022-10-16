class ChangePlaylists < ActiveRecord::Migration[6.1]
  def change
    add_column :playlists, :vibeify, :boolean
    add_column :playlists, :description, :text
  end
end
