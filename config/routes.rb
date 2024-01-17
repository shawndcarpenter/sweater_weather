Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v0 do
      get "/forecast", to: "weather#forecast"

      resources :users, only: [:create]
      # post "/users", to: "users#create"
      resources :sessions, only: [:create]
      # post "/sessions", to: "sessions#create"
      post "/road_trip", to: "road_trips#create"
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
