class Api::V1::MoviesController < Api::V1::ApiBaseController
  #before_action :authenticate_request!
  def index
    if params[:search].present?
      @parameter = params[:search].downcase  
      @movies = Movie.where("title LIKE :search", search: @parameter).page(params[:page]).per(@per_page_count)
    else
      @movies = Movie.all.page(params[:page]).per(@per_page_count)
    end
    render json: @movies
  end
end
