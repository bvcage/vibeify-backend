class Song < ActiveRecord::Base
   has_one :audio_feature
   has_many :saves
   has_many :playlists, through: :saves

   def self.categorize_songs ( songs = Song.all )
      categories = ['happy', 'sad']

      list = {}
      categories.each do |cat|
         list[cat] = []
      end

      songs.each do |song|
         feat = song.audio_feature
         next if feat.nil?
         categories.each do |cat|
            if song.send("is_#{cat}") then list[cat] << song end
         end
      end

      list.map { |cat, songs|
         if songs.length > 20
            songs = 20.times.map {
               i = rand(0 .. songs.length-1)
               songs.slice!(i,1)
            }
         end
         [cat, songs]
      }.to_h
   end

   def is_happy
      feat = self.audio_feature
      return true if
         feat.energy > 0.7 &&
         feat.loudness > -6 &&
         feat.valence > 0.8
      return false
   end

   def is_sad
      feat = self.audio_feature
      return true if
         feat.energy < 0.4 &&
         feat.valence < 0.2
      return false
   end

end