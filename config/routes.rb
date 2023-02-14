Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  get '/login', to: 'users#login_form'
  post '/login', to: 'users#login_user'
  post '/logout', to: 'users#logout_user'

  get '/register', to: 'users#new'
  get '/dashboard', to: 'users#show', as: 'user'
  get '/dashboard/movies', to: 'movies#index', as: 'movies'
  get '/dashboard/movies/:id', to: 'movies#show', as: 'movie'

 
  resources :users, only: [:create]
  resources :viewing_parties, only: [:new]
end