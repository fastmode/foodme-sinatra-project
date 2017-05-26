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
  		redirect to '/your'
  	else
  		flash[:message] = "Please log in."
  		erb :'users/login'
  	end
  end

  post '/login' do
  	user = User.find_by(username: params[:username])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		binding.pry
  		redirect to '/your-food'
  	else
  		redirect to '/signup'
  	end
  end

  get '/logout' do
  	if logged_in?
  		session.clear
  		flash[:message] = "Please log in."
  		redirect to '/'
  	else
  		flash[:message] = "Please sign up or log in."
  		redirect to '/'
  	end
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