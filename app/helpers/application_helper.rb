module ApplicationHelper

  def calculate_average_review (movie)
    if movie.reviews.blank? || movie.reviews.nil?
      
      @average_review = 0
    else
      
      @average_review = movie.reviews.average(:rating).round(2)
    end
  end
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
  # Returns the Gravatar for the given user.
  def user_profile_pic(user, wsize = 40, hsize = 40)

    if user.profile_pic.attached?
      url_for(user.profile_pic.variant(resize: "#{wsize}x#{hsize}!"))
    else
      gravatar_id = 1
      return "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{wsize}"
    end
  end

  def is_admin?
    return (!current_user.nil? && current_user.super_user?)
  end
  def authenticate_admin!
    redirect_to(root_path, alert: 'You are not a admin') unless  is_admin?
  end
end
