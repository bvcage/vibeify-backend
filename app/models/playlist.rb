class Playlist < ActiveRecord::Base
   belongs_to :user
   has_many :saves
   has_many :songs, through: :saves
end