class User < ActiveRecord::Base
   has_many :playlists
   has_many :songs, through: :playlists

   def own_songs
      playlists = self.playlists.where(owner_id: self.spotify_id)
      songs = playlists.map { |playlist| playlist.songs }
      songs.flatten
   end

end