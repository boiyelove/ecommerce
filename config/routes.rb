Rails.application.routes.draw do

  get 'cart' => "cart#show", as: "cart"
  delete 'cart/:id' => "cart#destroy"

  post 'order_items/:id/add' => "order_items#add_quantity", as: "order_item_add"
  post 'order_items/:id/reduce' => "order_items#reduce_quantity", as: "order_item_reduce"
  post 'order_items' => "order_items#create"
  get 'order_items/:id' => "order_items#show", as: "order_item"
  delete 'order_items/:id' => "order_items#destroy"

  get 'search' => 'products#search', as: 'search'
  # get 'sessions/new'
  # get 'sessions/create'
  # get 'sessions/destroy'
  resources :sessions, only: [:new, :create, :destroy]

  get 'register', to: 'users#new' , as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :orders
  # resources :order_items
  resources :products

  root :to => 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
