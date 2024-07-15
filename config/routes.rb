Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'home/index'
  resources :users
  resources :provinces
  resources :products, only: [:show]
  resources :categories, only: [:show]
  resources :orders
  resources :order_items
  resources :carts
  resources :cart_items
  
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'


  # Defines the root path route ("/")
  root "home#index"
end
