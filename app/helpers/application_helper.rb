module ApplicationHelper
  # Returns the Gravatar for the given user.

  def user_profile_pic(user, size= 40)

    if user.profile_pic.attached?
      user.profile_pic.variant(resize: "#{size}x#{size}!")
    else
      gravatar_id = 1
      return "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    end

  end

end
