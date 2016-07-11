Rails.application.routes.draw do
  resources :users
  root 'static#home'
  get 'static/example'
  get 'static/home'
end
