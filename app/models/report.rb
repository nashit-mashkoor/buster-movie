class Report < ApplicationRecord
  belongs_to :user
  belongs_to :review
  validates_uniqueness_of :user, scope: :review
end
