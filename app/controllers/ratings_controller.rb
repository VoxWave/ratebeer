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
        if Beer.exists?( beerid ) then
            Rating.create params.require(:rating).permit(:score, :beer_id)
            redirect_to ratings_path
        else
            puts "Beer does not exist"
            redirect_to ratings_new_path
        end
    end

    def destroy
        rating = Rating.find(params[:id])
        rating.delete
        redirect_to ratings_path
    end
end