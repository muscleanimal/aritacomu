Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get 'signup', to: 'users#new'
  resources :users, only: [:index, :show, :new, :create] do
  member do
    get:myinfos
    get:myworks
    get:likes
    get:myfaves
  end
end
    resources :answers, only: [:create]
    resources :infos
    resources :mentions, only: [:create]
    resources :works
    resources :favorites, only: [:create, :destroy]
    resources :shares, only: [:create, :destroy]
end