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
         )
         db_playlist
      end
      # return saved playlists
      status :accepted
      return_ary.to_json
   end

   delete "/playlists" do
      Playlist.destroy_all
      render status: 204
   end

end