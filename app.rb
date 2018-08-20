require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:rumblr.sqlite3"

get "/" do
  erb :home
end

get "/signup" do
  erb :signup
end

require "./models"
