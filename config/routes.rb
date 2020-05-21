Rails.application.routes.draw do
  root 'pages#landing'
  devise_for :users
  resources :photos
  resources :profiles, only: [:show] do
    member do
      get 'friends_photo'
      get 'subscribes_list'
      patch  'subscribe' 
      delete 'unsubscribe'
    end
  end
end
