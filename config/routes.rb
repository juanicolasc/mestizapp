Rails.application.routes.draw do
  resources :orders
  resources :customers
  resources :tables
  get 'sessions/new'
  get 'users/new'
  resources :products

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  root "sessions#new"
  resources :users
  resources :sessions

end
