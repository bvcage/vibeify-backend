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
 
end