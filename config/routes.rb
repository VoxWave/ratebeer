Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :beers
  resources :breweries
  resource :session, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  resources :places, only: [:index, :show]
  post 'places', to:'places#search'
end
