class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates_presence_of :title, :comment, :rating

  enum status: [:approved, :reported]
end
