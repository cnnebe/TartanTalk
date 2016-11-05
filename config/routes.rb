Rails.application.routes.draw do
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'

  resources :sessions, only: [:create, :destroy]
 #resource :home, only: [:show]

 # root to: "home#show"
  root "welcome#about"
  
  get '/signup', to: "registrations#new"

  post '/signup', to: "users#create"

  post '/signup', to: "registrations#create"

  get 'login', to: "sessions#new"
  post '/login', to: "sessions#create" 
  delete '/logout', to: "sessions#destroy"

  get 'users/:id', to: "users#show", as: "profile"

  resources :chatrooms, param: :slug
  resources :messages
  
  # Serve websocket cable requests in-process
  mount ActionCable.server => '/cable'
end
