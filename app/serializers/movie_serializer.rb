class MovieSerializer < ActiveModel::Serializer
   attributes :title, :description, :length, :released, :thumbnail
   has_many :actors
   has_many :reviews

   def thumbnail
    return url_image(object.thumbnail)
   end
   def released
    object.year
   end
end
