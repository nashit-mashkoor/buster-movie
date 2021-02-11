# frozen_string_literal: true

class Api::V1::MoviesController < Api::V1::ApiBaseController
  before_action :authenticate_request!

  def index
    if params[:search].present?
      @parameter = params[:search].downcase
      @movies = Movie.where('lower(title) like ?', "%#{@parameter}%")
    else
      @movies = Movie.all
    end
    render json: @movies
  end
end
