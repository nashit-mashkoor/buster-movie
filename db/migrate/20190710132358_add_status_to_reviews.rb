class AddStatusToReviews < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :status, :integer
  end
end
