class Playlist < ActiveRecord::Base
   belongs_to :user
   has_many :saves
   has_many :songs, through: :saves

   def self.get_defaults
      Playlist.all.where(vibeify: true)
   end

   def self.make_defaults
      songs_list = Song.categorize_songs
      songs_list.map do |cat, songs|
         playlist = Playlist.find_or_create_by(
            name: "#{cat} vibes",
            vibeify: true,
            description: "made with vibeify"
         )
         if playlist.songs.count < 20 then playlist.songs << songs end
         playlist
      end
   end

end