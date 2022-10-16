class SongsController < ApplicationController

   get "/songs" do
      Song.all.to_json
   end

   post "/songs" do
      api = JSON.parse(request.body.read)
      songs = api["data"]
      return_ary = songs.map do |api_song|
         # validation / error checks
         next if api_song.nil?   # skip if song empty / removed
         if api_song.key?(:track) then api_song = api_song["track"] end   # remove extra info
         if api_song.key?(:is_local) then next if api_song["is_local"] end   # skip if local
         # save song
         db_song = Song.find_or_create_by(spotify_id: api_song["id"])
         artists = api_song["artists"].map{|artist| artist["name"]}.join(', ')
         album_art_url = api_song["album"]["images"].length > 0 ? api_song["album"]["images"][0]["url"] : nil
         db_song.update(
            name: api_song["name"],
            artist: artists,
            album_name: api_song["album"]["name"],
            album_spotify_id: api_song["album"]["id"],
            album_art_url: album_art_url,
            spotify_url: api_song["external_urls"]["spotify"]
         )
         db_song
      end
      status :accepted
      return_ary.compact.to_json
   end

   patch "/songs/multi" do
      api = JSON.parse(request.body.read)
      songs = api["data"]
   end

   patch "/songs/:id" do
   end
   
end