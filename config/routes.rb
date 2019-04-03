Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :items, only: [:index]

  resources :merchants, only: [:index]

  resources :users, only: [:new, :show, :create, :edit, :update]

  get '/login', to: "sessions#new"
  post '/login', to: "sessions#create"

  get '/logout', to: "sessions#destroy"

  get '/cart', to: "carts#show"


end
