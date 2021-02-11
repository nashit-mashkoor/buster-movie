# frozen_string_literal: true

class Report < ApplicationRecord
  validates_uniqueness_of :user, scope: :review

  belongs_to :user
  belongs_to :review
end
