Rails.application.routes.draw do
  resources :actors
  resources :movies do
  resources :reviews, only: [:new, :create]
    member do
      delete 'delete_poster/:poster_id', to: 'movies#delete_poster', as: 'delete_poster'
      delete 'delete_trailer', to: 'movies#delete_trailer', as: 'delete_trailer'
      delete 'remove_actor/:actor_id', to: 'movies#remove_actor', as: 'remove_actor'
    end
    collection do
      get 'home', to: 'movies#home'
      get 'land', to: 'movies#land'
    end
  end 
  #Temporarily
  resources :reviews, only: [:show, :index, :edit, :update, :destroy]  
  devise_for :users
  get 'pages/index'
  namespace :admin do
    resources :reports, only: [:index, :create, :destroy]  
    resources :users, only: [:index, :destroy, :edit, :update]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'movies#home'

end
