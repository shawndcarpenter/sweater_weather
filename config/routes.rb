Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v0 do
      get "/forecast", to: "weather#forecast"

      post "/users", to: "users#create"

      post "/sessions", to: "sessions#create"
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
