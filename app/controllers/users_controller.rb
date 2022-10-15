class UsersController < ApplicationController

   get "/users" do
      User.all.to_json
   end

   post "/users" do
      api = JSON.parse(request.body.read)
      user = User.find_or_create_by(spotify_id: api["id"]) do |user|
         user.username = api["display_name"]
      end
      user.to_json
   end

   get "/users/:id" do
      user = User.find_by(spotify_id: params[:id])
      render json: user, status: :ok
   end
   
end