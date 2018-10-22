Rails.application.routes.draw do
  resources :memberships
  resources :beer_clubs
  resources :users do
    post 'toggle_closed', on: :member
  end
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  resources :ratings, only: [:index, :new, :create, :destroy]
  resources :beers
  get 'beerlist', to:'beers#list'
  resources :breweries do
    post 'toggle_activity', on: :member
  end
  get 'brewerylist', to:'breweries#list'
  resources :styles, only:[:index, :show]
  resource :session, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new'
  get 'signin', to: 'sessions#new'
  delete 'signout', to: 'sessions#destroy'
  resources :places, only: [:index, :show]
  post 'places', to:'places#search'
end
