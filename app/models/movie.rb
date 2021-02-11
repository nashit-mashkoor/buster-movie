# frozen_string_literal: true

class Movie < ApplicationRecord
  # searchkick searchable: [:title, :description], callbacks: :async
  validates_presence_of :title, :description
  validates_uniqueness_of :title
  validates_numericality_of :length
  validate :movie_attachment_format

  has_one_attached :thumbnail
  has_one_attached :trailer
  has_many_attached :posters
  has_and_belongs_to_many :actors
  has_many :reviews, dependent: :destroy
  has_many :favourites, dependent: :destroy
  has_many :rated_by, through: :favourites, source: :movie

  after_validation :check_movie_attachments, only: [:create]
  before_destroy   :purge_posters

  # Resize thumb nail
  def thumb_nail(wsize = 40, hsize = 40)
    if thumbnail.attached?
      thumbnail.variant(resize: "#{wsize}x#{hsize}!")
    else
      gravatar_id = 1
      "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{wsize}"
    end
  end

  # Resize a single poster
  def movie_poster(poster, wsize = 40, hsize = 40)
    poster.variant(resize: "#{wsize}x#{hsize}!") if posters.attached?
  end

  # Check attached file format
  def movie_attachment_format
    errors.add(:thumbnail, 'must be attached') unless thumbnail.attached?
    if thumbnail.attached? && !thumbnail.content_type.in?(%w[image/jpeg image/png])
      errors.add(:thumbnail, 'must be in JPG or PNG')
    end
    if trailer.attached? && !trailer.content_type.in?(%w[video/mp4 video/quicktime])
      errors.add(:trailer, 'must be in MP4 or Quick time')
    end
    return if posters.attached?

    posters.each do |poster|
      unless poster.content_type.in?(%w[image/jpeg image/png])
        errors.add('posters' + poster.id.to_s, 'need to be in JPEG or PNG')
      end
    end
  end

  # purge all poster
  def purge_posters
    return if posters.attached?

    posters.each do |poster|
      poster.purge if errors['poster'+poster.id.to_s].any?
    end
  end

  # purge all attachments
  def check_movie_attachments
    return if errors.any?

    thumbnail.purge if thumbnail.attached? && errors[:thumbnail].any?
    trailer.purge if trailer.attached? && errors[:trailer].any?
    purge_posters
  end
end
