Journal::Application.routes.draw do
  root to: "posts#root"
  resources :posts
end
