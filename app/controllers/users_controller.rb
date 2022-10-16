class UsersController < ApplicationController

   get "/users" do
      User.all.to_json
   end

   post "/users" do
      api = JSON.parse(request.body.read)
      data = api["data"]
      user = User.find_or_create_by(spotify_id: data["id"]) do |user|
         user.username = data["display_name"]
      end
      user.to_json
   end

   get "/users/:id" do
      user = User.find_by(id: params[:id])
      render json: user, status: :ok
   end

   get "/users/:id/playlists" do
      user = User.find_by!(id: params[:id])
      user.playlists.to_json
   rescue ActiveRecord::RecordNotFound
      { 'error': 'no user found' }.to_json
   end

   get "/users/:id/vibeify" do
      user = User.find_by!(id: params[:id])
      defaults = Playlist.make_defaults user
      vibeify = Playlist.all.where(vibeify: true)
      vibeify.to_json(include: :songs)
   rescue ActiveRecord::RecordNotFound
      { 'error': 'no user found' }.to_json
   end

   delete "/users/:id/cleanup" do
      user = User.find_by!(id: params[:id])
      user.playlists.where(vibeify: true).destroy_all
   rescue ActiveRecord::RecordNotFound
      { 'error': 'no user found' }.to_json
   end

end