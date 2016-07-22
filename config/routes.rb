Rails.application.routes.draw do
  resources :tasks
  devise_for :users, controllers: { 
  	sessions: 'users/sessions',
  	passwords: 'users/passwords'
 	}

  resources :projects do
    member do
      put :current
    end
  	collection do
  		post :current
  	end
  end

  resources :users
  get 'profile', to: 'users#show'

  root 'static#home'
  get 'static/example'
  get 'static/home'
end
