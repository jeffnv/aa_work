RedditClone::Application.routes.draw do
  resources :users
  resource :session
  resources :links
  resources :comments
  resources :subs
end
