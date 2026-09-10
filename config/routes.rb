Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root "sessions#new"
  post "login", to: "sessions#create" 
  delete "logout", to: "sessions#destroy"
  get "dashboard", to: "dashboard#index"
end
