class Api::V1::MoviesController < Api::V1::ApiBaseController
  #before_action :authenticate_request!

  def index
    if params[:search].present?
       @movies = Movie.search params[:search], operator: "or"
    else
      @movies = Movie.all
    end
    render json: @movies
  end
end
