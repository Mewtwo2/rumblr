require "sinatra"
require "sinatra/activerecord"

set :database, "sqlite3:rumblr.sqlite3"

get "/" do
  erb :home
end

get "/signup" do
  erb :signup
end

post "/signup" do
  @email = params[:email]
  @first_name = params[:first_name]
  @last_name = params[:last_name]
  @birthday = params[:birthday]

  puts @email
  puts @first_name
  puts @last_name
  puts @birthday
end

require "./models"
