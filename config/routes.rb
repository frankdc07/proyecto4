Rails.application.routes.draw do
  root 'users#show'  
  resources :contests

  resources :videos
  
  #devise_for :users
  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :users

  get '/contest/:contest_id/:url', to: 'videos#index'
  get '/contest/:contest_id/:url/new', to: 'videos#new'
  post '/contest/:contest_id/:url/save', to: 'videos#create'
  get '/contest/:contest_id/:url/show/:id', to: 'videos#show'
  
  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
