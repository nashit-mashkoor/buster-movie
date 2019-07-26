class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates_presence_of :title, :comment, :rating
  validates_uniqueness_of :user, scope: :movie
  has_many :reports, dependent: :destroy

  enum status: [:approved, :reported]

end
