class PlaylistsController < ApplicationController

   get "/playlists" do
      Playlist.all.to_json
   end

   post "/playlists" do
      api = JSON.parse(request.body.read)
      # get user
      spotify_user_id = api["user"]
      user = User.find_or_create_by(spotify_id: spotify_user_id)
      # save playlists array to table
      playlists_ary = api["data"]
      return_ary = playlists_ary.map do |api_playlist|
         db_playlist = Playlist.find_or_create_by(spotify_id: api_playlist["id"])
         db_playlist.update(
            name: api_playlist["name"],
            image_url: api_playlist["images"][0]["url"],
            user_id: user.id,
            owner_id: api_playlist["owner"]["id"],
            description: api_playlist["description"]
         )
         db_playlist
      end
      # return saved playlists
      status :accepted
      return_ary.to_json
   end

   get "/playlists/defaults" do
      defaults = Playlist.get_defaults
      if defaults.empty? then defaults = Playlist.make_defaults end
      defaults.to_json(include: :songs)
   end

   post "/playlists/merge" do
      api = JSON.parse(request.body.read)
      # get user
      user_id = api["user"]
      if user_id.is_a? String
         user = User.find_by(spotify_id: user_id)
      elsif user_id.is_a? Integer
         user = User.find_by(id: user_id)
      end
      # create merge playlist
      list = api["data"]
      merge = list.map { |item| Playlist.find(item)}
      description = "made with vibeify: merge of " + merge.pluck(:name).join(' & ')
      playlist = Playlist.create(
         name: "my vibeify playlist",
         user_id: user.id,
         owner_id: user.spotify_id,
         vibeify: true,
         description: description
      )
      # create joins
      songs = merge.map do |item|
         item.songs.each do |song|
            Save.find_or_create_by(
               playlist_id: playlist.id,
               song_id: song.id
            ) do |s|
               s.song_spotify_id = song.spotify_id
            end
            song
         end
         item.songs
      end
      { **playlist.attributes, songs: songs.flatten.uniq }.to_json
   end

   delete "/playlists" do
      Playlist.destroy_all
      render status: 204
   end

end