Rails.application.routes.draw do
  devise_for :users, controllers: { 
  	sessions: 'users/sessions',
  	passwords: 'users/passwords'
 	}

  resources :users
  get 'profile', to: 'users#show'

  resources :projects, except: [:show]
  get 'projects/current',       to: 'projects#show',    as: :current_project
  get 'projects/current/edit',  to: 'projects#edit',    as: :edit_current_project
  post 'projects/current',      to: 'projects#current', as: :set_current_project


  resources :tasks
  resources :jobs, only: [:create, :destroy]
  
  root 'static#home'
  get 'static/example'
  get 'static/home'
end