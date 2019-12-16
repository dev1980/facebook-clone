Rails.application.routes.draw do
  root  'posts#index'
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :posts, only: [:index, :show, :new, :create, :destroy]
  resources :users, only: [:index, :show]
  resources :comments, only: :create
  resources :likings, only: [:create, :destroy]
  resources :friendships, only: [:create, :update, :index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
