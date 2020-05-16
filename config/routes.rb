Rails.application.routes.draw do
  root 'pages#landing'
  devise_for :users
  resources :photos
  get 'profiles/friends_photo'
  get 'profiles/subscribes_list'
  resources :profiles, only: [:show] do
    member do
      patch  'subscribe' 
      delete 'unsubscribe'
    end
  end
end
