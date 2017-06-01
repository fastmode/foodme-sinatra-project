class UsersController < ApplicationController

  get '/login' do
  	if logged_in?
  		redirect to "/reviews"
  	else
  		erb :'users/login'
  	end
  end

  post '/login' do
  	user = User.find_by(username: params[:username])
  	if user && user.authenticate(params[:password])
  		session[:user_id] = user.id
  		redirect to "/reviews"
  	else
  		redirect to '/signup'
  	end
  end

   get '/signup' do
  	if logged_in?
  		redirect to "/reviews"
  	else
      @user = User.new
  		erb :'users/signup'
  	end
  end

  post '/signup' do
    @user = User.new(:username => params[:username], :email => params[:email], :password => params[:password])
    errors = {}
  	if params[:username] == "" 
      errors[:username] = "* Username must be filled in."
    elsif User.find_by(username: params[:username])
      errors[:username] = "* Username is not available!"
    end
    if params[:email] == "" 
      errors[:email] = "* Email must be filled in."
    elsif User.find_by(email: params[:email])
      errors[:email] = "* Email is not available!"
    end
    if params[:password] == ""
      errors[:password] = "* Password must be filled."
    end
    if errors.empty?
    	@user.save
    	session[:user_id] = @user.id
    	flash[:message] = "Your account was successfully created! Woot!"
  		redirect to "/reviews"
    else 
      flash[:message] = errors
      erb :'users/signup'
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