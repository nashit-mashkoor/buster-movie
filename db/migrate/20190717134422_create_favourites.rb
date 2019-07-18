class CreateFavourites < ActiveRecord::Migration[5.2]
  def change
    create_table :favourites do |t|
      t.integer :movie_id
      t.integer :user_id

      t.timestamps
    end
    add_index :favourites, [:movie_id, :user_id]
  end
end
