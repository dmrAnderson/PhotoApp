Rails.application.routes.draw do
  resources :profiles, only: [:show]
  resources :photos
  devise_for :users
  root 'pages#landing'
end
