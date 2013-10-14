JTunes::Application.routes.draw do
  resources :bands do
    resources :albums, only: [:new, :create]
  end
  
  resources :albums, except: [:new, :create] do
    resources :tracks, only: [:new, :create]
  end
  
  resources :tracks, except: [:new, :create]
  
  resources :users, only:[:new, :create]
  resource :session, only: [:new, :create, :destroy]
  
end

