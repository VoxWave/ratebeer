class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
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
      if @rating.save
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
