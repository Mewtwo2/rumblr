require "sinatra"
require "sinatra/activerecord"
enable :sessions

set :database, "sqlite3:rumblr.sqlite3"

get "/" do
  erb :home
end

get "/signup" do
  erb :signup
end

post "/signup" do
  user = User.new(
    email: params['email'],
    first_name: params['first_name'],
    last_name: params['last_name'],
    password: params['password'],
    birthday: params['birthday']
  )
  user.save
  redirect "/"
end

require "./models"
