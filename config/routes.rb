Rails.application.routes.draw do
  devise_for :users, controllers: { 
  	sessions: 'users/sessions',
  	passwords: 'users/passwords'
 	}

  resources :users
  get 'profile', to: 'users#show'

  resources :projects do
    member do
      put :current
    end
  	collection do
  		post :current
  	end
  end

  resources :tasks
  resources :jobs, only: [:create, :destroy]
  
  root 'static#home'
  get 'static/example'
  get 'static/home'
end