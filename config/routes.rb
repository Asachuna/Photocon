Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users, only: [:show, :create, :edit, :update] do
    member do
      get :photos
      get :contests
      get :likes
    end
  end
  
  resources :contests, only: [:index, :new, :create, :show, :destroy] do
    member do
      get 'post', to: 'photos#new'
    end
  end
  
  resources :photos, only: [:index, :show, :create, :destroy]
  
  resources :user_photo_likes, only: [:create, :destroy]
  resources :user_photo_comments, only: [:create, :destroy]
  
end
