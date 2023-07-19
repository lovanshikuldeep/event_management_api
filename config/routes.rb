Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "events#index"
  resources :events
  resources :users
  post '/auth/login', to: 'authentication#login'
  resources :ettendees
  resources :places
  get '/user/favourite', to: 'places#favourite'
end
