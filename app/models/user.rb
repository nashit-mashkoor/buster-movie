class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attr_accessor :remove_profile_pic
  validates :name, presence: true
  validate :user_attachment_format
  has_one_attached :profile_pic
  after_save :purge_profile_pic, if: :remove_profile_pic
  after_validation :check_user_attachments

  #Delete profile picture
  def purge_profile_pic
    profile_pic.purge_later
  end

  def user_attachment_format
    if profile_pic.attached? && !profile_pic.content_type.in?(%w(image/jpeg image/png))
      errors.add(:thumbnail, 'must be in JPG or PNG')
    end
  end

  #purge all attachments
  def check_user_attachments
    if errors.any?
      profile_pic.purge if profile_pic.attached?
    end
  end
end
