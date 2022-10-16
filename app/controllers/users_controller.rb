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
      { 'error': 'no user found' }
   end

end