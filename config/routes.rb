Rails.application.routes.draw do
  resources :users
  resources :attractions

  root 'welcome#index'
  get '/' => 'welcome#index'

  get '/signin' => 'sessions#new'
  post '/signin' => 'sessions#create'

  delete '/signout' => 'sessions#destroy'

  post '/attractions/:id' => 'rides#create'
end