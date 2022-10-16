class Playlist < ActiveRecord::Base
   belongs_to :user
   has_many :saves
   has_many :songs, through: :saves

   def self.get_defaults
      Playlist.all.where(vibeify: true)
   end

   def self.make_defaults user
      songs_list = Song.categorize_songs( user.own_songs )
      songs_list.map do |cat, songs|
         playlist = Playlist.find_or_create_by(
            name: "#{cat} vibes",
            vibeify: true,
            description: "made with vibeify",
            user_id: user.id,
            owner_id: user.spotify_id
         )
         playlist.songs << songs
         playlist.songs = playlist.songs.uniq
         playlist
      end
   end

end