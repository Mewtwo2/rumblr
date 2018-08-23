require "sinatra"
require "sinatra/activerecord"
enable :sessions

require "active_record"
ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"])

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

get "/createpost" do
  erb :create_post
end

post "/createpost" do
  post = Post.new(
    title: params[:title],
    text_content: params[:content],
    user_id: session[:user][:id]
  )
  post.save
  session[:post] = post
  redirect "/sessionposts"
end

get "/sessionposts" do
  post = Post.find_by(session[:post])
  @title = post.title
  @content = post.text_content
  @posts = Post.where(user_id: session[:user][:id])
  erb :logged_user_posts
end

get "/searcheduserposts" do
  @user = User.find_by(email: params[:email])[:id]
  @posts = Post.where(user_id: @user)
  erb :searched_user_posts
end

get "/delete" do
  @user = session[:user][:id]
  User.destroy(@user)
  redirect "/logout"
end

require "./models"
