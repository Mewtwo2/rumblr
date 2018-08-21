require "sinatra"
require "sinatra/activerecord"
enable :sessions

set :database, "sqlite3:rumblr.sqlite3"

get "/" do
  erb :home
end

get "/account" do
  erb :account
end

get "/signup" do
  erb :signup
end

post "/signup" do
  user = User.new(
    email: params[:email],
    first_name: params[:first_name],
    last_name: params[:last_name],
    password: params[:password],
    birthday: params[:birthday]
  )
  user.save
  redirect "/"
end

get "/login" do
  erb :login
end

post "/login" do
  @email = params[:email]
  @given_password = params[:password]

  user = User.find_by(email: @email)
  if user.password == @given_password
    session[:user] = user
    redirect "/account"
  else
    p "Incorrect Email or Password"
    redirect "/"
  end
end

get "/logout" do
  session[:user] = nil
  p "User has logged out"
  redirect "/"
end

require "./models"
