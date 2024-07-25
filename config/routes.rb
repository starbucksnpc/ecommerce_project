Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  resources :users, only: [:show, :edit, :update, :destroy]
  resources :provinces
  resources :products, only: [:index, :show]
  resources :categories, only: [:show]
  resources :orders, only: [:show]
  resources :order_items

  resource :cart, only: [:show, :update, :destroy] do
    post 'add', to: 'carts#add'
    delete 'remove', to: 'carts#remove'
    patch 'update_quantity', to: 'carts#update_quantity'
    get 'checkout', to: 'carts#checkout'
  end

  resources :cart_items

  resources :checkouts, only: [:new, :create]
  
  get "up" => "rails/health#show", as: :rails_health_check

  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  root "home#index"
end
