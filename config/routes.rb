Rails.application.routes.draw do
  root 'static_pages#home'
  
  get '/help', to: 'static_pages#help'
  get '/user_api', to: 'api#user_api'
  get '/feed_api', to: 'api#feed_api'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'

  get '/test', to: 'static_pages#test'
  
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete  '/logout', to: 'sessions#destroy'
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :microposts, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
end