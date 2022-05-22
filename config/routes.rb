Rails.application.routes.draw do
  root "sessions#new"
  resources :orders do
      resources :items
  end
  resources :customers
  resources :tables
  get 'sessions/new'
  get 'users/new'
  resources :products

  get "log_out" => "sessions#destroy", :as => "log_out"
  get "log_in" => "sessions#new", :as => "log_in"
  get "sign_up" => "users#new", :as => "sign_up"
  resources :users
  resources :sessions

end
