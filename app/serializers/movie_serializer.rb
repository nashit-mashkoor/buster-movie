# frozen_string_literal: true

class MovieSerializer < ActiveModel::Serializer
  attributes :title, :description, :length, :released

  has_many :actors
  has_many :reviews

  def thumbnail
    url_image(object.thumbnail)
  end

  def released
    object.year
  end
end
