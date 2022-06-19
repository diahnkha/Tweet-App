Rails.application.routes.draw do
  post "likes/:post_id/destroy"=>"likes#destroy"

  post "likes/:post_id/create" =>"likes#create"
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  get 'login' => 'users#login_form'
  get 'users/:id/destroy' => 'users#destroy'
  post 'users/:id/destroy' => 'users#destroy'

  post 'users/:id/update' => 'users#update'
 get "users/:id/likes"=>"users#likes"
  get 'users/:id/edit' => 'users#edit'
  post 'users/create' => 'users#create'

  get 'users/index'
  get 'users/:id' => 'users#show'
  get 'posts/index' => 'posts#index'
  get 'posts/new' => 'posts#new'
  get 'posts/:id' => 'posts#show'
  post 'posts/create' => 'posts#create'
  get '/' => 'home#top'
  get 'about' => 'home#about'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' => 'posts#update'
  post 'posts/:id/destroy' => 'posts#destroy'
  get 'signup' => 'users#new'
end
