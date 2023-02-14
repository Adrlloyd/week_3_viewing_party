class MoviesController < ApplicationController
    def index 
        @user = current_user
        @movies = Movie.all
    end 

    def show 
        @user = current_user
        @movie = Movie.find(params[:id])
    end
end 