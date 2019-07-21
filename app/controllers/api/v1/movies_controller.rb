class Api::V1::MoviesController < Api::V1::ApiBaseController
  before_action :authenticate_request!

  def index
    render json: { 'logged_in' => true }
  end
end
