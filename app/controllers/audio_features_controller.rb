class AudioFeaturesController < ApplicationController

   post "/audio-features" do
      api = JSON.parse(request.body.read)
      profiles = api["data"]
      return_ary = profiles.map do |api_profile|
         song = Song.find_by!(spotify_id: api_profile["id"])
         profile = AudioFeature.find_or_create_by(song_id: song.id) do |profile|
            profile.acousticness = api_profile["acousticness"]
            profile.danceability = api_profile["danceability"]
            profile.energy = api_profile["energy"]
            profile.instrumentalness = api_profile["instrumentalness"]
            profile.key = api_profile["key"]
            profile.liveness = api_profile["liveness"]
            profile.loudness = api_profile["loudness"]
            profile.mode = api_profile["mode"]
            profile.speechiness = api_profile["speechiness"]
            profile.tempo = api_profile["tempo"]
            profile.time_signature = api_profile["time_signature"]
            profile.valence = api_profile["valence"]
            profile.spotify_song_id = song.spotify_id
         end
         profile
      end
      return_ary.to_json
   rescue ActiveRecord::RecordNotFound
      {'data':'not ok'}.to_json
   end

end