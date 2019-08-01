# frozen_string_literal: true

module MoviesHelper
  def get_actors_for_movie movie
    Actor.where.not(id: movie.actors.pluck(:id)).map{ |actor| [actor.name, actor.id] }
  end
end