class ReviewsController < ApplicationController
  before_action :find_movie, except: [:index, :show, :edit, :update, :destroy]
  before_action :find_review, only:  [:edit, :update, :destroy, :show]
  before_action :authenticate_user!, only: [:new, :edit]

  def index
    @reviews_per_page = 25
    @reviews = Review.page(params[:page]).per(@reviews_per_page)
    @review = Review.first
  end
  def show; end
  def new
    @review = Review.new

  end

  def create
    @review = Review.new(review_params)
    @review.movie_id = @movie.id
    @review.user_id = current_user.id

    if @review.save
     redirect_to movie_path(@movie)
     flash[:notice] = "Review created Successfully"
   else
    byebug
    flash[:alert] = "Review creation Unsuccessfull"
    #This stops error from reload
    redirect_to movie_path(@movie)

   end
   
  end

  def edit
     session[:return_to] = request.referer
  end

  def update
    if @review.update(review_params)
      redirect_to session.delete(:return_to)  
      flash[:notice] = "Review updated Successfully"
    else
      flash[:alert] = "Review update Unsuccessfull"
      render 'edit'
    end
  end

  def destroy
    @review.destroy
    redirect_to request.referer, notice: 'Review was successfully deleted'
  end

  private

    def review_params
      params.require(:review).permit(:title,:rating, :comment)
    end

    def find_movie
      @movie = Movie.find(params[:movie_id])
    end

    def find_review
      @review = Review.find(params[:id])
    end

end
