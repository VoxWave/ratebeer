Rails.application.routes.draw do
  root 'breweries#index'
  get 'kaikki_bisset', to: 'beers#index'
  get 'ratings', to: 'ratings#index'
  resources :beers
  resources :breweries
end
