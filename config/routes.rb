Rails.application.routes.draw do
  resources :users
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :beers
  resources :breweries
  get 'signup', to: 'users#new'
end
