class CreateMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.text   :description
      t.float :length
      t.float :rating
      t.date :year
      t.timestamps
    end
  end
end
