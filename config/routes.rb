Rails.application.routes.draw do
  devise_for :users
  root to: "images#index"
  resources :images, except: %i[edit update] do
    resources :comments, only: %i[new create destroy]
  end
end

# Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
# Defines the root path route ("/")
# root "articles#index"
