class Movie < ApplicationRecord

  validates_presence_of :title, :description
  validates_uniqueness_of :title
  validates_numericality_of :length, :rating
  validate :movie_attachment_format
  has_one_attached :thumbnail
  has_one_attached :trailer
  has_many_attached :posters
  has_and_belongs_to_many :actors

  after_validation :check_movie_attachments, only: [:create]
  before_destroy   :purge_posters


  #Resize thumb nail
  def thumb_nail(size = 40)

    if self.thumbnail.attached?
      self.thumbnail.variant(resize: "#{size}x#{size}!")
    else
      gravatar_id = 1
      return "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    end

  end

  #Resize a single poster
  def movie_poster(poster, size = 40)
    if posters.attached?
      poster.variant(resize: "#{size}x#{size}!")
    end
  end

  #Check attached file format
  def movie_attachment_format
    if thumbnail.attached? && !thumbnail.content_type.in?(%w(image/jpeg image/png))
      errors.add(:thumbnail, 'must be in JPG or PNG')
    end
    if trailer.attached? && !trailer.content_type.in?(%w(video/mp4 video/quicktime))
      errors.add(:thumbnail, 'must be in MP4 or Quicktime')
    end
    if posters.attached?
      posters.each do |poster|
        unless poster.content_type.in?(%w(image/jpeg image/png))
          errors.add(:images, 'need to be in JPEF or PNG')
        end
      end
    end
  end
  #purge all poster
  def purge_posters
    if posters.attached?
      posters.each do |poster|
        poster.purge
      end
      posters.purge
    end
  end
  #purge all attachments
  def check_movie_attachments
    if errors.any?
      thumbnail.purge if thumbnail.attached?
      trailer.purge if trailer.attached?
      purge_posters
    end
  end
end
