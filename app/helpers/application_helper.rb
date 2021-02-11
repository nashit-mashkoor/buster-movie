# frozen_string_literal: true

module ApplicationHelper

  def calculate_average_review(movie)
    @average_review = if movie.reviews.blank? || movie.reviews.nil?
                        0
                      else
                        movie.reviews.average(:rating).round(2)
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
      "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{wsize}"
    end
  end

  def is_admin?
    (!current_user.nil? && current_user.super_user?)
  end

  def authenticate_admin!
    redirect_to(home_movies_path, alert: 'You are not a admin') unless is_admin?
  end

  def is_reportable?(review)
    !is_admin? && !@user_reports.include?(review.id) && review.user != current_user
  end

  def is_editable?(review)
    (is_admin? || (current_user == review.user))
  end

  def is_reviewable?(user_id, movie_id)
    !Review.where(user_id: user_id, movie_id: movie_id).exists?
  end
end
