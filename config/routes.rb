Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
  
  #resource :home, only: [:show]
  #root to: "home#show" 

 # Source: https://blog.heroku.com/real_time_rails_implementing_websockets_in_rails_5_with_action_cable
  root "welcome#about"

  get '/edit', to: "users#edit"
  
  get '/signup', to: "registrations#new"
  post '/signup', to: "users#create"

  get 'login', to: "sessions#new"
  post '/login', to: "sessions#create" 
  delete '/logout', to: "sessions#destroy"

  resources :chatrooms, param: :slug
  resources :messages
  resources :users
  resources :staffs
  
  get 'users/:id', to: "users#show", as: "profile"

  # Semi-static page routes
  get 'faq' => 'welcome#faq', as: :faq
  get 'terms' => 'welcome#terms', as: :terms
  get 'privacy' => 'welcome#privacy', as: :privacy
  
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end

