Rails.application.routes.draw do
  resources :services, only: [:index, :edit, :update]
  get 'services', to: 'services#index'
  resources :kitchens
  resources :types
  get 'history', to: 'history#index'
  root "sessions#new"
  resources :orders do
      resources :items, except: [:index, :show]
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
