class MoviesController < ApplicationController
  include MoviesHelper
  before_action :set_movie, only: [:show, :edit, :update, :destroy]
  before_action :get_reviews, only: [:show]

  # GET /movies
  # GET /movies.json
  def home
    @per_page_count = 5
    @movies = Movie.page(params[:page]).per(@per_page_count)
  

  end
  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
    @new_review =  Review.new
    @actors = @movie.actors
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit; end

  # POST /movies
  # POST /movies.json
  def create


    @movie = Movie.new movie_params
    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.'}
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      actor_ids = @movie.actor_ids
      options = movie_params.merge(actor_ids: movie_params[:actor_ids] + actor_ids)

      if @movie.update(options)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.'}
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.'}
      format.json { head :no_content }
    end
  end

  #DELETE /movies/1/delete_poster/1
  def delete_poster
    @image = ActiveStorage::Attachment.find(params[:poster_id])
    @image.purge
    redirect_to movie_path(params[:id]), notice: 'Poster was successfully removed'
  end

  #DELETE /movies/1/delete_trailer
  def delete_trailer
    @movie = set_movie
    @movie.trailer.purge_later
    redirect_to movie_path(@movie), notice: 'Trailer was successfully removed'
  end
  #DELETE /movies/1/remove_actor/1
  def remove_actor
    @movie = set_movie
    @movie.actors.delete(params[:actor_id])
    redirect_to movie_path(@movie), notice: 'Actor was successfully removed'
  end

  #GET /movies/land also the root page
  def land
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_movie
    @movie = Movie.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def movie_params
    params.require(:movie).permit(:id, :title, :description, :length, :rating, :year, :thumbnail, :trailer, actor_ids: [], posters: [])
  end

  def get_reviews 
    @reviews_per_page = 4
    @reviews = Review.page(params[:page]).per(@reviews_per_page).where(movie_id: @movie.id)
  

  end

end
