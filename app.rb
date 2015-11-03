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
  if session[:session_user_id].nil?
  erb :signup
else
  redirect '/'
end
end

post '/createuser' do
  User.create(user_name: params[:newusername], password: params[:newuserpw], email: params[:newemail], location: params[:location], about: params[:about])
  redirect '/'
end

get '/logout' do
	session.clear
	redirect '/'
end

post '/post' do
  Post.create(user_id: current_user.id, post_content: params[:content])
  redirect '/'
end

get '/:user_name' do
  @profile = params[:user_name]
  erb :profile
end

post '/changeuser' do
  @newname = User.find(current_user)
  @newname.update(user_name: params[:newusername])
  redirect '/'
end

post '/changeemail' do
  @newemail = User.find(current_user)
  @newemail.update(email: params[:newemail])
  redirect '/'
end

post '/changelocation' do
  @newlocation = User.find(current_user)
  @newlocation.update(location: params[:newlocation])
  redirect '/'
end
post '/changeabout' do
  @newabout = User.find(current_user)
  @newabout.update(about: params[:newabout])
  redirect '/'
end

post '/changepassword' do
  @newpass = User.find(current_user)
  @newpass.update(password: params[:newpass])
  redirect '/'
end

post '/deleteaccount' do
  if params[:yousure] == 'yes'
  Post.where(user_id: current_user.id).each do |t|
    t.destroy
  end
  @account = User.find(current_user)
  @account.destroy
  session.clear
  redirect '/'
  else
  redirect '/'
end
end

post '/follow' do
  @test = params[:followname]
  puts @test
end

def follow!(user)
followed << user
end
