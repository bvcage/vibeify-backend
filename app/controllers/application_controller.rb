class ApplicationController < Sinatra::Base
   set :default_content_type, 'application/json'
   
   # Add your routes here
   get "/" do
     { message: "Good luck with your project!" }.to_json
   end

   get "/users" do
      User.all
   end

   post "/users" do
      api = JSON.parse(request.body.read)
      user = User.find_or_create_by(spotify_id: api["spotify_id"]) do |user|
         user.username = api["username"]
      end
      user.to_json
   end

   get "/playlists" do
      Playlist.all
   end

   post "/playlists" do
      api = JSON.parse(request.body.read)
      # get logged in user via spotify id
      spotify_user_id = api["spotify_user_id"]
      user_id = User.find_by(spotify_id: spotify_user_id).id
      # save array to playlists table
      playlists_ary = api["playlists"]
      return_ary = playlists_ary.map do |api_playlist|
         db_playlist = Playlist.find_or_create_by(spotify_id: api_playlist["id"])
         db_playlist = db_playlist.update(
            name: api_playlist["name"],
            image_url: api_playlist["images"][0]["url"],
            user_id: user_id,
            owner_id: api_playlist["owner"]["id"],
         )
      end
      return_ary.to_json
   end

   get "/songs" do
      Song.all
   end

   post "/songs" do
      api = JSON.parse(request.body.read)
      songs_ary = api["songsAry"]
      return_ary = songs_ary.map do |api_song|
         db_song = Song.find_or_create_by(spotify_id: api_song["id"])
         db_song = db_song.update(
            name: api_song["name"],
            album_spotify_id: api_song["album"]["id"]
         )
      end
      return_ary.to_json
   end

end