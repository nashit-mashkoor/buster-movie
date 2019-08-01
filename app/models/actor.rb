# frozen_string_literal: true

class Actor < ApplicationRecord
  validates :name, presence: true
  validate :check_actor_attachment
  after_validation :purge_actor_attachments, only: [:create]
  has_one_attached :actor_pic
  has_and_belongs_to_many :movies

  # Validate image
  def check_actor_attachment
    return if actor_pic.attached? && !actor_pic.content_type.in?(%w[image/jpeg image/png])

    errors.add(:actor_pic, 'must be in JPG or PNG')
  end

  # purge  attachment
  def purge_actor_attachments
    return if errors[:actor_pic].any?

    actor_pic.purge if actor_pic.attached?
  end

  # resize picture
  def resized_actor_pic(wsize = 40, hsize = 40)
    actor_pic.variant(resize: "#{wsize}x#{hsize}!") if actor_pic.attached?
  end
end
