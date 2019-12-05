Rails.application.routes.draw do
  root  'posts#index'

  devise_for :users
  resources :posts, only: [:index, :show, :new, :create]
  resources :users, only: [:show, :index]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
