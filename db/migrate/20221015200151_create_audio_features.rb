class CreateAudioFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :audio_features do |t|
      t.integer :song_id
      t.string :spotify_song_id
      t.float :acousticness
      t.float :danceability
      t.float :energy
      t.float :instrumentalness
      t.integer :key
      t.float :liveness
      t.float :loudness
      t.integer :mode
      t.float :speechiness
      t.float :tempo
      t.integer :time_signature
      t.float :valence

      t.timestamps
    end
  end
end
