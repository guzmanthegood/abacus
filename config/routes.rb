Rails.application.routes.draw do
  devise_for :users, controllers: { 
  	sessions: 'users/sessions',
  	passwords: 'users/passwords'
 	}

  resources :users, except: :show
  get 'profile', to: 'users#show'

  root 'static#home'
  get 'static/example'
  get 'static/home'
end
