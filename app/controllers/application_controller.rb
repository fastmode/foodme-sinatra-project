require 'rack-flash'
require './config/environment'


class ApplicationController < Sinatra::Base
	use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get '/' do
  	erb :index
  end

  get '/login' do
  	if logged_in?
  		redirect to "/reviews/#{current_user.username}"
  	else
  		erb :'users/login'
  	end
  end

  post '/login' do
  	user = User.find_by(username: params[:username])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect to "/reviews/#{current_user.username}"
  	else
  		redirect to '/signup'
  	end
  end

   get '/signup' do
  	if logged_in?
  		redirect to "/reviews/#{current_user.username}"
  	else
  		erb :'users/signup'
  	end
  end

  post '/signup' do
  	if params[:username] == "" || params[:email] == "" || params[:password] == ""
  		flash[:message] = "Please fill out every field."
      redirect to '/signup'
    else
    	user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    	user.save
    	session[:user_id] = user.id
    	flash[:message] = "Your account was successfully created! Woot!"
  		redirect to "/reviews/#{current_user.username}"
  	end
  end

  get '/logout' do
  	if logged_in?
  		session.clear
  		flash[:message] = "Your are now logged out.  Thank you!"
  		redirect to '/'
  	else
  		flash[:message] = "Please sign up or log in."
  		redirect to '/'
  	end
  end

  get '/reviews' do
  	@users = User.all
  	erb :'reviews/index'
  end

  get '/reviews/:slug' do
  	@user = User.find_by_slug(params[:slug])
  	erb :'reviews/user-reviews'
  end

  helpers do
  	def logged_in?
  		!!session[:user_id]
  	end

  	def current_user
  		User.find(session[:user_id])
  	end
  end

end