Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get '/users', to: 'users#index'
  # get '/users/:id', to: 'users#show'
  # get '/users/:user_id/posts', to: 'posts#index'
  # get '/users/:user_id/posts/:id', to: 'post#show'
  root'users#index'

  resources :users, only: %i[index show] do
    resources :posts, only: %i[index show new create] do
      resources :comments, only: %i[new create]
      resources :likes, only: %i[create]
    end
  end

  # Defines the root path route ("/")
  # root "articles#index"
end
