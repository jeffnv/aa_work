FriendCircle::Application.routes.draw do
  resources :friend_circles
  resources :users
  resource :session
end
