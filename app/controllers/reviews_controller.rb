# frozen_string_literal: true

class ReviewsController < ApplicationController
  include ApplicationHelper
  before_action :find_movie, except: %i[index edit update destroy]
  before_action :find_review, only:  %i[edit update destroy]
  before_action :authenticate_user!, only: %i[new edit]

  def index
    @reviews_per_page = 10
    @reviews = Review.page(params[:page]).per(@reviews_per_page)
    @review = Review.first
  end

  def new
    @review = Review.new

  end

  def create
    @review = Review.new(review_params)
    @review.movie_id = @movie.id
    @review.user_id = current_user.id
    respond_to do |format|
      if @review.save
        flash.now[:notice] = 'Review created Successfully'
        format.html{ redirect_to movie_path(@movie), notice: 'Review created Successfully' }
        format.js
      else
        flash.now[:alert] = 'Review creation failed'
        format.html{ redirect_to movie_path(@movie), notice: 'Review creation failed' }
        format.js
      end
    end
  end

  def edit
    if is_editable?(@review)
      session[:return_to] = request.referer
    else
      flash[:alert] = 'You can not  edit this review'
      redirect_to root_path
    end
  end

  def update
    if @review.update(review_params)
      redirect_to session.delete(:return_to)  
      flash[:notice] = 'Review updated Successfully'
    else
      flash[:alert] = 'Review update Unsuccessfull'
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      flash.now[:alert] = 'Review was successfully deleted'
      format.html { redirect_to request.referer, notice: 'Review was successfully deleted' }
      format.js
    end
  end

  private

  def review_params
    params.require(:review).permit(:title, :rating, :comment)
  end

  def find_movie
    @movie = Movie.find(params[:movie_id])
  end

  def find_review
    @review = Review.find(params[:id])
  end
end
