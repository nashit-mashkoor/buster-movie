class Favourite < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  validate :unique_record

  def unique_record
    errors.add(:movie, 'alredy added as favourite') if Favourite.where(movie_id: movie, user_id: user).exists?
  end
      
end
