Rails.application.routes.draw do
 root 'users#index'
 resources :users
 resources :posts
 resources :comments, except: :index
end
