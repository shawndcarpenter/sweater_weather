Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v0 do
      get "/forecast", to: "weather#forecast"
    end

    namespace :v1 do
      get "/munchies", to: "munchies#show"
    end
  end
  # Defines the root path route ("/")
  # root "articles#index"
end
