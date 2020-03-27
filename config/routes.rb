Rails.application.routes.draw do
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  resources :sessions, only: [:new, :create, :destroy]

  get 'register', to: 'users#new' , as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  resources :users
  resources :orders
  resources :order_items
  resources :products

  root :to => 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
