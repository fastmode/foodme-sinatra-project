class UsersController < ApplicationController

  get '/login' do
  	if logged_in?
  		redirect to "/#{current_user.username}"
  	else
  		erb :'users/login'
  	end
  end

  post '/login' do
  	user = User.find_by(username: params[:username])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect to "/#{current_user.username}"
  	else
  		redirect to '/signup'
  	end
  end

   get '/signup' do
  	if logged_in?
  		redirect to "/#{current_user.username}"
  	else
  		erb :'users/signup'
  	end
  end

  post '/signup' do
  	if params[:username] == "" || params[:email] == "" || params[:password] == ""
  		flash[:message] = "* Please fill out every field."
      redirect to '/signup'
    else
    	user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    	user.save
    	session[:user_id] = user.id
    	flash[:message] = "Your account was successfully created! Woot!"
  		redirect to "/#{current_user.username}"
  	end
  end

  get '/logout' do
  	if logged_in?
  		session.clear
  		flash[:message] = "* Your are now logged out.  Thank you!"
  		redirect to '/'
  	else
  		flash[:message] = "* Please sign up or log in."
  		redirect to '/'
  	end
  end
end