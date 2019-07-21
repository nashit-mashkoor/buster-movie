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
  resources :users, only: [:show]  do
    member do
      get 'load_favourites', to: 'users#load_favourites', as: 'load_favourites'
      get 'load_rated', to: 'users#load_rated', as: 'load_rated'
      post 'add_favourite/:favourite_id', to: 'users#add_favourite', as: 'add_favourite'
      delete 'remove_favourite/:favourite_id', to: 'users#remove_favourite', as: 'remove_favourite'
    end 
  end
  get 'pages/index'
  namespace :admin do
    resources :reports, only: [:index, :create, :destroy]  
    resources :users, only: [:index, :destroy, :edit, :update]
  end

  namespace :api do
    namespace :v1 do
        post 'auth_user', to: 'authentication#authenticate_user'
        resources :movies, only: [:index]
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'movies#home'

end
