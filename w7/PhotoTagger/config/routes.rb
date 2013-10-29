NewAuthDemo::Application.routes.draw do

  get "static_pages/index"

  resources :users, :only => [:create, :new, :show]
  resource :session, :only => [:create, :destroy, :new]

  namespace "api", :defaults => { :format => :json } do

    resources :photos, :only => [:create, :destroy, :update] do
      resources :photo_taggings, :only => [:index]
    end
    resources :users do
      resources :photos, :only => [:index]
    end
    resources :photo_taggings, :only => [:create]

  end

  root :to => "static_pages#index"
end
