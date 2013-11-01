NewAuthDemo::Application.routes.draw do
  resources :users, :only => [:create, :new, :show]
  resource :session, :only => [:create, :destroy, :new]
  resources :gists do
    resource :favorite, :only => [:create, :destroy]
  end
  resources :tags
  resources :favorites, :only => [:index]
  root :to => "root#root"
end
