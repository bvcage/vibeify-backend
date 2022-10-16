class SavesController < ApplicationController

   post "/saves" do
      api = JSON.parse(request.body.read)
      playlists = api["data"]
      return_ary = playlists.map do |api_playlist|
         db_playlist = Playlist.find_by(spotify_id: api_playlist['spotify_id'])
         songs = api_playlist['songs']
         songs = songs.map do |api_song|
            api_song = api_song['track']
            next if api_song.nil?   # skip if empty
            db_song = Song.find_or_create_by(spotify_id: api_song['id'])
            Save.find_or_create_by(playlist_spotify_id: db_playlist.spotify_id, song_spotify_id: db_song.spotify_id) do |save|
               save.playlist_id = db_playlist.id
               save.song_id = db_song.id
            end
            api_song
         end
         api_playlist['songs'] = songs
         api_playlist
      end
      return_ary.to_json
   end

end