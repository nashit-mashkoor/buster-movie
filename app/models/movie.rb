class Movie < ApplicationRecord

  validates_presence_of :title, :description
  validates_uniqueness_of :title
  validates_numericality_of :length
  validate :movie_attachment_format
  has_one_attached :thumbnail
  has_one_attached :trailer
  has_many_attached :posters
  has_and_belongs_to_many :actors

  after_validation :check_movie_attachments, only: [:create]
  before_destroy   :purge_posters

  has_many :reviews
  

  #Resize thumb nail
  def thumb_nail(wsize = 40, hsize = 40)

    if self.thumbnail.attached?
      self.thumbnail.variant(resize: "#{wsize}x#{hsize}!")
    else
      gravatar_id = 1
      return "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{wsize}"
    end

  end

  #Resize a single poster
  def movie_poster(poster, wsize = 40, hsize = 40)
    if posters.attached?
      poster.variant(resize: "#{wsize}x#{hsize}!")
    end
  end

  #Check attached file format
  def movie_attachment_format
    if !thumbnail.attached?
      errors.add(:thumbnail, 'must be attached')
    end
    if thumbnail.attached? && !thumbnail.content_type.in?(%w(image/jpeg image/png))
      errors.add(:thumbnail, 'must be in JPG or PNG')
    end
    if trailer.attached? && !trailer.content_type.in?(%w(video/mp4 video/quicktime))
      errors.add(:trailer, 'must be in MP4 or Quicktime')
    end
    if posters.attached?
      posters.each do |poster|
        unless poster.content_type.in?(%w(image/jpeg image/png))
          errors.add('posters'+poster.id.to_s, 'need to be in JPEF or PNG')
        end
      end
    end
  end
  #purge all poster
  def purge_posters
    if posters.attached?
      posters.each do |poster|
        poster.purge if errors['poster'+poster.id.to_s].any?
      end
    end
  end
  #purge all attachments
  def check_movie_attachments
    if errors.any?
      thumbnail.purge if thumbnail.attached? && errors[:thumbnail].any?
      trailer.purge if trailer.attached? && errors[:trailer].any? 
      purge_posters
    end
  end
end
