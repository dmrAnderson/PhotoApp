Rails.application.routes.draw do
  resources :photos
  devise_for :users
  get 'pages/about'
  root 'pages#landing'
end
