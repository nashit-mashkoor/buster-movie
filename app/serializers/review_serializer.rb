class ReviewSerializer < ActiveModel::Serializer
 attributes :title, :rating, :comment, :reviewer_name
 def reviewer_name
   object.user.name
 end
end
