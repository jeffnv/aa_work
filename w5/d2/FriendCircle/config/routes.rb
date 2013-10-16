FriendCircle::Application.routes.draw do
  get "friendships/new"

  get "users/forgot_password" => "users#forgot_password"
  post "users/forgot_password" => "users#send_reset_mail"
  get "users/reset" => "users#reset"
  post "users/reset_password" => "users#reset_password"
  resources :friend_circles

  resources :users
  resource :session
end
