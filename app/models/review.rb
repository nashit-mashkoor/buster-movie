class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates_presence_of :title, :comment

  enum status: [:approved, :reported]
end
