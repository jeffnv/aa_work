JTunes::Application.routes.draw do
  resources :bands do
    resources :albums, only: [:new, :create]
  end
  
  resources :albums, except: [:new, :create] do
    resources :tracks, only: [:new, :create]
  end
  
  resources :tracks, except: [:new, :create] do
    resources :notes, only: [:new, :create]
  end
  
  resources :notes, only: [:destroy]
  
  
  resources :users, only:[:new, :create]
  resource :session, only: [:new, :create, :destroy]
  
  
  get '/users/:activation_token', to: 'users#activate'
end

