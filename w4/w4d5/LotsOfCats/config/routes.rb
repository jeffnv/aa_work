LotsOfCats::Application.routes.draw do
  root :to => "cats#index"
  resource :session, only: [:new, :create, :destroy]
  resource :users, only: [:new, :create]

  resources :cats do
    resources :cat_rental_requests, only: [:new, :index]
  end

  resources :cat_rental_requests, except: [:index] do
    member do
      post 'approve'
      post 'deny'
    end
  end
end
