FirstRoutes::Application.routes.draw do
  resources :users, :except => [:new, :edit] do
    resources :contacts, :except => [:new, :edit]
  end
  # get 'users' => 'users#index'
  # post 'users' => 'users#create'
  # get 'users/:id' => 'users#show'
  # put 'users/:id' => 'users#update'
  # delete 'users/:id' => 'users#destroy'

end
