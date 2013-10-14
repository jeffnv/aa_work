JTunes::Application.routes.draw do

  resources :users, only:[:new, :create]
  resource :session, only: [:new, :create, :destroy]
  resources :bands, only:[:index, :new, :create, :destroy]
end
