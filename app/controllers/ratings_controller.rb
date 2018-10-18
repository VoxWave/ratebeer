class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @top_ratings = Rating.recent
    @top_breweries = Brewery.top(5)
    @top_beers = Beer.top(5)
    @top_styles = Style.top(3)
    @top_users = User.top(3)
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end

  def create
    beerid = params[:rating][:beer_id]
    if Beer.exists?(beerid)
      @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
      @rating.user = current_user
      if current_user.nil?
        redirect_to signin_path, notice: 'you should be signed in to rate a beer'
      elsif @rating.save
        session[:last_rating] = "#{@rating.beer.name} #{@rating.score} points"
        redirect_to current_user
      else
        @beers = Beer.all
        render :new
      end
    else
      redirect_to ratings_new_path, notice: "Beer does not exist"
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to user_path(current_user)
  end
end
