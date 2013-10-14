JTunes::Application.routes.draw do

  resources :users, only:[:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :bands
  resources :albums, only: [:create, :destroy, :show, :update]
  resources :tracks
end

