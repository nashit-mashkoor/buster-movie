# frozen_string_literal: true

class Favourite < ApplicationRecord
  validate :unique_record

  belongs_to :user
  belongs_to :movie

  def unique_record
    errors.add(:movie, 'already added as favourite') if Favourite.where(movie_id: movie, user_id: user).exists?
  end
end
