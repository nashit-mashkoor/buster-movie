class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates_presence_of :title, :comment, :rating
  has_many :reports, dependent: :destroy

  enum status: [:approved, :reported]
end
