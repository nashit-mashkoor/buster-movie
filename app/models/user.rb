class User < ApplicationRecord
  attr_accessor :remove_profile_pic
  attr_accessor :skip_name_picture_validation
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable
  validates :name, presence: true
  validate :user_attachment_format
  has_one_attached :profile_pic
  after_save :purge_profile_pic, if: :remove_profile_picture?
  after_validation :check_user_attachments

  has_many :reviews, dependent: :destroy
  has_many :reports, dependent: :destroy

  #Delete profile picture
  def purge_profile_pic
    profile_pic.purge_later
  end

  def user_attachment_format
    if profile_pic.attached? && !profile_pic.content_type.in?(%w(image/jpeg image/png))
      errors.add(:profile_pic, 'must be in JPG or PNG')
    end
  end

  #purge all attachments
  def check_user_attachments
    if errors[:profile_pic].any?
      profile_pic.purge if profile_pic.attached?
    end
  end

  def remove_profile_picture?
    remove_profile_pic == '1'
  end
end
