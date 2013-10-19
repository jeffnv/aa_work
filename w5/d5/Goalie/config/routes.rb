Goalie::Application.routes.draw do
  resources :goals

  resources :users, only: [:new, :create]
  resource :session, only: [:new, :create, :destroy]
end
