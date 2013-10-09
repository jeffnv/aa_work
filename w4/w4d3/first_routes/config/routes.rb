FirstRoutes::Application.routes.draw do
  #resources :users
  get 'users' => 'users#index'
  post 'users' => 'users#create'
  get 'users/new' => 'users#new'
  get 'users/:id/edit' => 'users#edit'
  get 'users/:id' => 'users#show'
  put 'users/:id' => 'users#update'
  delete 'users/:id' => 'users#destroy'
end
