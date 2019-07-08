Rails.application.routes.draw do
  resources :actors
  resources :movies do
    member do
      delete 'delete_poster/:poster_id', to: 'movies#delete_poster', as: 'delete_poster'
      delete 'delete_trailer', to: 'movies#delete_trailer', as: 'delete_trailer'
      delete 'remove_actor/:actor_id', to: 'movies#remove_actor', as: 'remove_actor'

    end
  end
  devise_for :users
  get 'pages/index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#index'
end
