Rails.application.routes.draw do
  root 'static#home'
  get 'static/example'
  get 'static/home'
end
