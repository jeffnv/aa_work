LotsOfCats::Application.routes.draw do
  root :to => "cats#index"
  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

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
