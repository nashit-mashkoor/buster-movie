module ApplicationHelper

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
end
