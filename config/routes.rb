Rails.application.routes.draw do
  devise_for :users, controllers: { 
  	sessions: 'users/sessions',
  	passwords: 'users/passwords'
 	}

  resources :users
  get 'profile', to: 'users#show'

  resources :projects
  post 'projects/current', to: 'projects#current', as: :current_project


  resources :tasks
  resources :jobs, only: [:create, :destroy]
  
  root 'static#home'
  get 'static/example'
  get 'static/home'
end