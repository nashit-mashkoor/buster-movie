# frozen_string_literal: true

class User < ApplicationRecord
  attr_accessor :remove_profile_pic
  attr_accessor :skip_name_picture_validation

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :invitable, :confirmable
  validates :name, presence: true
  validate :user_attachment_format

  has_one_attached :profile_pic
  has_many :reviews, dependent: :destroy
  has_many :reports, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :favourite_movies, through: :favourites, source: :movie

  after_save :purge_profile_pic, if: :remove_profile_picture?
  after_validation :check_user_attachments
  after_invitation_accepted :confirm_email!

  def confirm_email!
    update confirmed_at: DateTime.now
  end

  # Delete profile picture
  def purge_profile_pic
    profile_pic.purge_later
  end

  def user_attachment_format
    return if profile_pic.attached? && !profile_pic.content_type.in?(%w[image/jpeg image/png])

    errors.add(:profile_pic, 'must be in JPG or PNG')
  end

  # purge all attachments
  def check_user_attachments
    return if errors[:profile_pic].any?

    profile_pic.purge if profile_pic.attached?
  end

  def remove_profile_picture?
    remove_profile_pic == '1'
  end
end
