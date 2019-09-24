Rails.application.routes.draw do
  root to: 'toppages#index'
  resources:toppages
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
  member do
    get:myinfos
    get:myworks
    get:likes
    get:myfaves
    get:sharings
    get:myshares
  end
end
    resources :answers, only: [:create]
    resources :infos do
    get:answer_count
  end
    resources :mentions, only: [:create]
    resources :works
    resources :favorites, only: [:create, :destroy]
    resources :shares, only: [:index, :show, :new, :create, :edit, :destroy, :update] do
  member do
    get:discussion
    get:users
  end
end
    resources :links, only: [:create, :destroy]
    resources :comments, only: [:create, :destroy]
end