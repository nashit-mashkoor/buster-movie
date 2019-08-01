# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only:%i[show load_favourites load_rated add_favourite remove_favourite]
  before_action :set_movie, only:%i[add_favourite remove_favourite]
  before_action :set_favourites, only: %i[show load_favourites]
  before_action :set_rated, only: %i[show load_rated]

  def show; end

  def load_favourites
    respond_to do |format|
      format.js
    end
  end

  def load_rated
    respond_to do |format|
      format.js
    end
  end

  def add_favourite
    respond_to do |format|
      if @user.favourites.build(movie_id: @movie.id)&.save
        flash.now[:notice] = 'Movie added to favourites'
      else
        flash.now[:alert] = 'Movie can not be added to favourites'
      end 
      format.js 
    end
  end

  def remove_favourite
    respond_to do |format|
      if @user.favourites.find_by(movie_id: @movie.id)&.destroy
        flash.now[:notice] = 'Movie removed from favourites'
      else
        flash.now[:alert] = 'Movie can not be removed from favourites'
      end 
      format.js 
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:favourite_id])
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:id, :name, :email, :profile_pic, :password, :current_password, :remove_profile_pic)
  end

  def set_favourites
    @total_favourites = @user.favourite_movies.count
    @favourites_per_page = 10
    @favourites = @user.favourite_movies.page(params[:page]).per(@favourites_per_page)
  end

  def set_rated
    @total_rated_count = Review.where(user_id: current_user.id).count
    @rated_per_page = 10
    @total_rated = Review.includes(:movie).where(user_id: current_user.id).page(params[:page]).per(@rated_per_page)
  end
end
