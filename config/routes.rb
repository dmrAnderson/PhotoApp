Rails.application.routes.draw do
  resources :photos
  devise_for :users
  root 'pages#landing'

  resources :profiles, only: [:show] do
    member do
      patch   'subscribe' 
      delete 'unsubscribe'
    end
  end
end
