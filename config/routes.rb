Rails.application.routes.draw do
  devise_for :users

  root 'home#landing'

  namespace :home do
    get 'landing'
    get 'personel'
    get 'profile'
    get 'public'
    get 'notifications'
  end

  namespace :notifications do
    get 'accept'
    get 'reject'
  end

  resource :user_detail, only: [:update]
  resource :avatar, only: [:update]
  resource :posts, only: [:create]

  get 'posts/:page_id', to: 'posts#fetch_posts'
  get 'users', to: 'users#fetch_users'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
