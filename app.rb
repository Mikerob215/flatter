require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/flash'
enable :sessions
set :database, "sqlite3:microblog.sqlite3"

require './models'

def current_user
  if session[:session_user_id]
    @current_user = User.find(session[:session_user_id])
  end
end

get '/' do
  @posts = Post.where(user_id: current_user)
  if session[:session_user_id].nil?
    erb :login
  else
    erb :home
  end
end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.where(user_name: params[:user_name]).first
  if User.where(user_name: params[:user_name]).exists?
    if @user.password == params[:password]
  		flash[:notice] = "Congratulations!"
  		session[:session_user_id] = @user.id
  		session[:session_user_name] = @user.user_name
  		redirect '/'
  	else
  		flash[:alert] = "Bad News!"
  		redirect '/'
  	end
  else
    flash[:alert] = "Bad News!"
    redirect '/'
  end
end

get '/signup' do
  erb :signup
end

post '/createuser' do
  User.create(user_name: params[:newusername], password: params[:newuserpw], email: params[:newemail])
end

get '/logout' do
	session.clear
	redirect '/'
end

post '/post' do
  Post.create(user_id: current_user.id, post_content: params[:content])
  redirect '/'
end
