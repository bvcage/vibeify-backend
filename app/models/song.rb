class Song < ActiveRecord::Base
   has_one :audio_feature
   has_many :saves
   has_many :playlists, through: :saves
end