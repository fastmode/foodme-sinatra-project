class ReviewsController < ApplicationController

	get '/reviews' do
    @reviews = Review.all
  	erb :'reviews/index'
  end

  get '/reviews/new' do
    if logged_in?
      erb :'reviews/new-review'
    else
      redirect to '/login'
    end
  end

  post '/reviews' do
    if params[:dish][:name] == "" || params[:dish][:price] = "" || params[:content] == "" || params[:restaurant] == "" || params[:city] == ""
      flash[:message] = "* Please fill out every field."
      redirect to '/reviews/new'
    else
      city = City.find_or_create_by(name: params[:city])
      restaurant = Restaurant.find_or_create_by(name: params[:restaurant]) do |r|
        r.city_id = city.id
      end
      dish = Dish.find_or_create_by(name: params[:dish][:name]) do |d|
        d.price = params[:dish][:price]
        d.vegetarian = params[:dish][:vegetarian]
        d.gluten_free = params[:dish][:gluten_free]
        d.restaurant_id = restaurant.id
      end
      @review = Review.create(content: params[:content], dish_id: dish.id, user_id: current_user.id)
      redirect to '/reviews'
    end
  end

  get '/:slug' do
    @user = User.find_by_slug(params[:slug])
    @reviews = Review.all
    erb :'reviews/user-reviews'
  end

  get '/reviews/:id' do
    @review = Review.find_by_id(params[:id])
    erb :'reviews/show-review'
  end

  get '/reviews/:id/edit' do
    if logged_in?
      @review = Review.find_by_id(params[:id])
      if @review.user_id == current_user.id
        erb :'reviews/edit-review'
      else
        redirect to '/reviews'
      end
    else
      redirect to '/login'
    end
  end

  patch '/reviews/:id' do
    @review = Review.find_by_id(params[:id])
    @review.dish.name = params[:dish][:name]
    @review.dish.price = params[:dish][:price]
    @review.dish.gluten_free = params[:dish][:gluten_free]
    @review.dish.vegetarian = params[:dish][:vegetarian]
    @review.content = params[:content]
    @review.dish.restaurant.name = params[:restaurant]
    @review.dish.restaurant.city.name = params[:city]
    @review.save
    @review.dish.save
    @review.dish.restaurant.save
    @review.dish.restaurant.city.save
    redirect to "/reviews/#{@review.id}"
  end

  delete '/reviews/:id/delete' do
    if logged_in?
      @review = Review.find_by_id(params[:id])
      if @review.user_id == current_user.id
        @review.delete
        redirect to "/#{current_user.username}"
      else
        redirect to '/reviews'
      end
    else
      redirect to '/login'
		end
	end
end