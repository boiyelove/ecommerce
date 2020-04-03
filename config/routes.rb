Rails.application.routes.draw do

  get 'admin/dashboard'
  get 'dashboard' => "products#dashboard", as: "dashboard"

  post 'checkout' => "cart#checkout", as: "checkout"
  patch 'checkout' => "cart#checkout"
  get 'checkout' => "cart#show"
  get 'cart' => "cart#show", as: "cart"
  delete 'cart/:id' => "cart#destroy"

  post 'order_items/:id/add' => "order_items#add_quantity", as: "order_item_add"
  post 'order_items/:id/reduce' => "order_items#reduce_quantity", as: "order_item_reduce"
  post 'order_items' => "order_items#create"
  get 'order_items/:id' => "order_items#show", as: "order_item"
  delete 'order_items/:id' => "order_items#destroy"
  

  resources :sessions, only: [:new, :create, :destroy]

  get 'register', to: 'users#new' , as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'

  resources :users
  resources :orders

  resources :products

  root :to => 'products#index'

  scope "/admin", admin_scope: true do
    resources :products, :orders, :users
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
