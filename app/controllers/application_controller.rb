require './config/environment'

class ApplicationController < Sinatra::Base

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
  	erb: login
  end

  post '/login' do
  	user = User.find_by(username: params[:username])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect to '/tweets'
  	else
  		redirect to '/signup'
  	end
  end


end