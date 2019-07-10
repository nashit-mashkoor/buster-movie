class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie

  enum status: [:approved, :reported]
end
