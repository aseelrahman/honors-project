# config/routes.rb
Rails.application.routes.draw do
  root 'home#index'
  
  # Authentication
  get 'signup', to: 'registrations#new'
  post 'signup', to: 'registrations#create'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  # Public routes
  resources :photographers, only: [:index, :show]
  
  # Client routes
  namespace :client do
    get 'dashboard', to: 'dashboard#index'
    resources :bookings do
      resources :payments, only: [:new, :create]
      resources :reviews, only: [:new, :create]
    end
  end
  
  # Photographer routes
  namespace :photographer do
    get 'dashboard', to: 'dashboard#index'
    resource :profile, only: [:new, :create, :edit, :update]
    resources :packages
    resources :bookings, only: [:index, :show] do
      member do
        patch :accept
        patch :decline
        patch :complete
      end
    end
    resources :earnings, only: [:index]
  end
  
  # Omniauth callbacks (if using social login)
  # get '/auth/:provider/callback', to: 'sessions#omniauth'
end