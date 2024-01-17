Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v0 do
      get "/forecast", to: "forecasts#show"

      resources :users, only: [:create]

      resources :sessions, only: [:create]

      post "/road_trip", to: "road_trips#create"
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
