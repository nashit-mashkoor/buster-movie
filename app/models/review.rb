# frozen_string_literal: true

class Review < ApplicationRecord
  validates_presence_of :title, :comment, :rating
  validates_uniqueness_of :user, scope: :movie

  belongs_to :user
  belongs_to :movie
  has_many :reports, dependent: :destroy

  enum status: %i[approved reported]

end
