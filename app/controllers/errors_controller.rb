# frozen_string_literal: true

class ErrorsController < ApplicationController
  skip_before_action :authenticate_user!

  def not_found
    render layout: false
  end

  def internal_error
    render layout: false
  end
end
