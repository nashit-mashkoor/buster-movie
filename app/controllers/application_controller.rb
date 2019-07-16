class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  #before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  #before_action :validate_resource, if: :devise_controller?, only: [:update]


  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:name, :email, :password, :profile_pic]
    devise_parameter_sanitizer.permit :account_update, keys: [:name, :email, :profile_pic, :password, :current_password,:remove_profile_pic]
    devise_parameter_sanitizer.permit :accept_invitation, keys: [:name, :profile_pic]


  end

  def authenticate_inviter!
      return (!current_user.nil? && current_user.super_user?)
  end
  def validate_resource
    unless update_resource(resource, account_update_params.except(:profile_pic))
      clean_up_passwords resource
      set_minimum_password_length
      respond_with resource
    end
  end
end
