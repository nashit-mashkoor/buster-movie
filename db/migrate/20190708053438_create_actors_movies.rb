class CreateActorsMovies < ActiveRecord::Migration[5.2]
  def change
    create_table :actors_movies, id: false do |t|
      t.belongs_to :movie, index: true
      t.belongs_to :actor, index: true
    end
  end
end
